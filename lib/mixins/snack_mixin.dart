import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_html/html_parser.dart';

abstract class SnackMixin {
  void showError(BuildContext context, dynamic e, {OnTap onLinkTap}) {
    String message = '';

    if (e.runtimeType == String) {
      message = e;
    } else if (e.runtimeType == DioError) {
      message = e.response != null && e.response.data != null ? e.response.data['message'] : e.message;
    }

    final snackBar = SnackBar(
      content: Builder(
        builder: (BuildContext context) => Html(
          data: "<div>$message</div>",
          style: {
            "div": Style(color: Colors.white),
            "a": Style(color: Colors.white, fontWeight: FontWeight.bold),
          },
          onLinkTap: onLinkTap,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.error,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccess(BuildContext context, String e, {OnTap onLinkTap}) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 700),
      content: Builder(
        builder: (BuildContext context) => Html(
          data: "<div>$e</div>",
          style: {
            "div": Style(color: Colors.white),
            "a": Style(color: Colors.white, fontWeight: FontWeight.bold),
          },
          onLinkTap: onLinkTap,
        ),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
