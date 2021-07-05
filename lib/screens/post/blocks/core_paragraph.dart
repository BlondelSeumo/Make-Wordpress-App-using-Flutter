import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class Paragraph extends StatelessWidget {
  final Map<String, dynamic> block;

  const Paragraph({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(data: "<div>${block['innerHTML']}</div>", style: {
      'p': Style(
        lineHeight: LineHeight(1.8),
        fontSize: FontSize(15),
      ),
      'div': Style(
        lineHeight: LineHeight(1.8),
        fontSize: FontSize(15),
      ),
      'img': Style(
        padding: EdgeInsets.symmetric(vertical: 8),
      )
    });
  }
}
