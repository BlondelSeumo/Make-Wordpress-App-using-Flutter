import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final IconData iconData;
  final double? size;
  final double radius;
  final Widget title;
  final Widget content;
  final Widget textButton;
  final Function onPressed;
  final Color? color;
  NotificationScreen({
    Key? key,
    required this.iconData,
    required this.title,
    required this.content,
    required this.textButton,
    required this.onPressed,
    this.size = 90,
    this.radius = 45,
    this.color,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: color?.withOpacity(0.1) ?? Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            child: Icon(
              iconData,
              color: color ?? Theme.of(context).primaryColor,
              size: 36
            ),
          ),
          SizedBox(height: 24),
          title,
          SizedBox(height: 8),
          content,
          SizedBox(height: 40),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed:()=> onPressed(),
              child: textButton,
            )
          )
        ],
      )
    );
  }
}
