import 'package:cirilla/widgets/cirilla_html.dart';
import 'package:flutter/material.dart';

class TermText extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final String html;

  const TermText({
    Key key,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.html,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CirillaHtml(html: html),
    );
  }
}
