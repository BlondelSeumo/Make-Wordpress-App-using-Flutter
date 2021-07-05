import 'package:flutter/material.dart';

class SubscribeItem extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget? content;
  final Widget? textField;
  final Widget? elevatedButton;
  SubscribeItem({
    Key? key,
    this.icon,
    this.title,
    this.content,
    this.textField,
    this.elevatedButton,
  });
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? Container(),
        SizedBox(
          height: 8,
        ),
        title ?? Container(),
        SizedBox(
          height: 8,
        ),
        content ?? Container(),
        SizedBox(
          height: 16,
        ),
        textField ?? Container(),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: elevatedButton ?? Container(),
        )
      ],
    );
  }
}
