import 'package:cirilla/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:ui/painter/zoom_painter.dart';

import 'widgets/zoom_animation.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.color, this.loading});

  final Color color;
  final bool loading;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  Size size = Size.zero;
  AnimationController _controller;
  ZoomAnimation _animation;
  AnimationStatus _status = AnimationStatus.forward;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          _status = status;
        });
      })
      ..addListener(() {
        setState(() {});
      });
    _animation = ZoomAnimation(_controller);
  }

  @override
  void didChangeDependencies() {
    setState(() {
      size = MediaQuery.of(context).size;
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.loading && _controller.status != AnimationStatus.forward) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_status == AnimationStatus.completed) return Container();

    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: ZoomPainter(color: widget.color, zoomSize: _animation.zoomSize.value * size.width),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: _animation.textOpacity.value,
            child: Image.asset(Assets.logo),
          ),
        ),
      )
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
