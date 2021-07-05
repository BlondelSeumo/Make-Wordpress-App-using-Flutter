import 'package:flutter/material.dart';

class CirillaText extends StatelessWidget {
  final String text;

  const CirillaText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.subtitle2);
  }
}

class CirillaSubText extends StatelessWidget {
  final String text;
  final bool active;

  const CirillaSubText(this.text, {Key key, this.active = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).textTheme.headline1.color;
    TextStyle style = Theme.of(context).textTheme.bodyText2;
    TextStyle styleActive = Theme.of(context).textTheme.bodyText2.apply(color: activeColor);

    return Text(text, style: active ? styleActive : style);
  }
}
