import 'package:cirilla/constants/assets.dart';
import 'package:flutter/material.dart';

class SplashScreenLayout1 extends StatefulWidget {
  final bool loading;

  const SplashScreenLayout1({Key key, this.loading = true}) : super(key: key);

  @override
  _SplashScreenLayout1State createState() => _SplashScreenLayout1State();
}

class _SplashScreenLayout1State extends State<SplashScreenLayout1> with SingleTickerProviderStateMixin {
  bool _animation = false;
  bool _end = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SplashScreenLayout1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.loading && !_animation) {
      setState(() {
        _animation = true;
      });
    }
  }

  _onEnd() {
    setState(() {
      _end = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (_end) return Container();

    return AnimatedOpacity(
      onEnd: _onEnd,
      opacity: !_animation ? 1.0 : 0.0,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeOut,
      child: Container(
        color: Colors.white,
        width: width,
        height: height,
        child: Center(child: Image.asset(Assets.logo)),
      ),
    );
  }
}
