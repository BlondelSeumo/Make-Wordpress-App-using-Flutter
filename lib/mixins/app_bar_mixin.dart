import 'package:flutter/material.dart';

abstract class AppBarMixin {
  Widget leading() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget leadingPined() {
    return Builder(
      builder: (BuildContext context) {
        return Ink(
          width: 38.0,
          height: 38.0,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Widget leadingButton({IconData icon, Function onPress}) {
    return Builder(
      builder: (BuildContext context) {
        return Ink(
          width: 38.0,
          height: 38.0,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 20,
            ),
            onPressed: onPress,
          ),
        );
      },
    );
  }

  AppBar baseStyleAppBar(BuildContext context, {String title}) {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actionsIconTheme: IconThemeData(size: 22, opacity: 0),
      leading: leading(),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
