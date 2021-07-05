import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:html/parser.dart' show parse;

class PostAudio extends StatefulWidget {
  final Post post;

  const PostAudio({Key key, this.post}) : super(key: key);

  @override
  _PostAudioState createState() => _PostAudioState();
}

class _PostAudioState extends State<PostAudio> {
  AudioPlayer _player;
  ConcatenatingAudioSource _playlist;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  @override
  void didChangeDependencies() {
    _parseData();
    _init();
    super.didChangeDependencies();
  }

  void _parseData() {
    List<AudioSource> data = [];

    var document = parse(widget.post.content.rendered);

    var rows = document.getElementsByClassName("wp-block-audio");

    for (int i = 0; i < rows.length; i++) {
      String audio = rows[i].getElementsByTagName("audio")[0].attributes['src'];
      String caption = rows[i].getElementsByTagName("figcaption")[0].innerHtml;

      if (audio != null && audio != '')
        data.add(AudioSource.uri(
          Uri.parse(audio),
          tag: AudioMetadata(
            album: widget.post.title.rendered,
            title: caption,
            artwork: widget.post.image,
          ),
        ));
    }

    setState(() {
      _playlist = ConcatenatingAudioSource(children: data);
    });
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<SequenceState>(
              stream: _player.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state == null || state.sequence.isEmpty) return SizedBox();
                final metadata = state.currentSource.tag as AudioMetadata;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Image.network(metadata.artwork)),
                      ),
                    ),
                    Text(metadata.album, style: Theme.of(context).textTheme.headline6),
                    Text(metadata.title),
                  ],
                );
              },
            ),
          ),
          ControlButtons(_player),
          StreamBuilder<Duration>(
            stream: _player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<PositionData>(
                stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                    _player.positionStream,
                    _player.bufferedPositionStream,
                    (position, bufferedPosition) => PositionData(position, bufferedPosition)),
                builder: (context, snapshot) {
                  final positionData = snapshot.data ?? PositionData(Duration.zero, Duration.zero);
                  var position = positionData.position;
                  if (position > duration) {
                    position = duration;
                  }
                  var bufferedPosition = positionData.bufferedPosition;
                  if (bufferedPosition > duration) {
                    bufferedPosition = duration;
                  }
                  return SeekBar(
                    duration: duration,
                    position: position,
                    bufferedPosition: bufferedPosition,
                    onChangeEnd: (newPosition) {
                      _player.seek(newPosition);
                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              StreamBuilder<LoopMode>(
                stream: _player.loopModeStream,
                builder: (context, snapshot) {
                  final loopMode = snapshot.data ?? LoopMode.off;
                  const icons = [
                    Icon(Icons.repeat, color: Colors.grey),
                    Icon(Icons.repeat, color: Colors.orange),
                    Icon(Icons.repeat_one, color: Colors.orange),
                  ];
                  const cycleModes = [
                    LoopMode.off,
                    LoopMode.all,
                    LoopMode.one,
                  ];
                  final index = cycleModes.indexOf(loopMode);
                  return IconButton(
                    icon: icons[index],
                    onPressed: () {
                      _player.setLoopMode(cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
                    },
                  );
                },
              ),
              Expanded(
                child: Text(
                  "Playlist",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
              StreamBuilder<bool>(
                stream: _player.shuffleModeEnabledStream,
                builder: (context, snapshot) {
                  final shuffleModeEnabled = snapshot.data ?? false;
                  return IconButton(
                    icon: shuffleModeEnabled
                        ? Icon(Icons.shuffle, color: Colors.orange)
                        : Icon(Icons.shuffle, color: Colors.grey),
                    onPressed: () async {
                      final enable = !shuffleModeEnabled;
                      if (enable) {
                        await _player.shuffle();
                      }
                      await _player.setShuffleModeEnabled(enable);
                    },
                  );
                },
              ),
            ],
          ),
          Container(
            height: 240.0,
            child: StreamBuilder<SequenceState>(
              stream: _player.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                final sequence = state?.sequence ?? [];
                return ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) newIndex--;
                    _playlist.move(oldIndex, newIndex);
                  },
                  children: [
                    for (var i = 0; i < sequence.length; i++)
                      Dismissible(
                        key: ValueKey(sequence[i]),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        onDismissed: (dismissDirection) {
                          _playlist.removeAt(i);
                        },
                        child: Material(
                          color: i == state.currentIndex ? Colors.grey.shade300 : null,
                          child: ListTile(
                            title: Text(sequence[i].tag.title as String),
                            onTap: () {
                              _player.seek(Duration.zero, index: i);
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            _showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero, index: player.effectiveIndices.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x", style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              _showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    @required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;
  SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value:
                min(_dragValue ?? widget.position.inMilliseconds.toDouble(), widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$_remaining")?.group(1) ?? '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

void _showSliderDialog({
  @required BuildContext context,
  @required String title,
  @required int divisions,
  @required double min,
  @required double max,
  String valueSuffix = '',
  @required Stream<double> stream,
  @required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({@required this.album, @required this.title, @required this.artwork});
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    @required Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    @required bool isDiscrete,
    @required TextPainter labelPainter,
    @required RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    @required TextDirection textDirection,
    @required double value,
    @required double textScaleFactor,
    @required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
