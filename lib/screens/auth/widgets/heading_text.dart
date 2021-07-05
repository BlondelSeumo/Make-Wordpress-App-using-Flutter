import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String title;
  const HeadingText({Key key, this.title}) : super(key: key);

  factory HeadingText.animated({
    Key key,
    String title,
    Map<String, bool> enable,
  }) = _HeadingTextAnimated;
  Widget buildDescription(BuildContext context) {
    return Text('Create account to continue', style: Theme.of(context).textTheme.bodyText1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        buildDescription(context),
      ],
    );
  }
}

class _HeadingTextAnimated extends HeadingText {
  final Map<String, bool> enable;
  _HeadingTextAnimated({
    Key key,
    String title,
    this.enable,
  }) : super(key: key, title: title);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textTitle = theme.textTheme.headline5.copyWith(fontWeight: FontWeight.w700);
    List<String> animated = ["Email"];
    if (enable['facebook']) {
      animated.add('Facebook');
    }

    if (enable['google']) {
      animated.add('Google');
    }

    if (!isWeb && Platform.isIOS && enable['apple']) {
      animated.add('Apple');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(title, style: textTitle),
              SizedBox(width: 8.0),
              RotateAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                repeatForever: true,
                text: animated,
                textStyle: textTitle.copyWith(color: theme.primaryColor),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        buildDescription(context),
      ],
    );
  }
}
