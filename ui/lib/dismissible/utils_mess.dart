import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger
      .of(context)
      .showSnackBar(
        SnackBar(
          content: SizedBox(
            width: 0,
            child: Text(message),
          )
        )
      );
}
