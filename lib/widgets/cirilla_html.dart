import 'package:cirilla/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class CirillaHtml extends StatelessWidget {
  final String html;

  const CirillaHtml({Key key, this.html}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: html,
      onLinkTap: (
        String url,
        RenderContext renderContext,
        Map<String, String> attributes,
        dom.Element element,
      ) {
        if (url != null && url.isNotEmpty && url.startsWith("http")) {
          String queryString = Uri(queryParameters: {
            'app-builder-css': 'true',
            'id-selector': attributes['data-id-selector'],
          }).query;

          String _url = url.contains("?") ? "$url&$queryString" : "$url?$queryString";
          Navigator.of(context).pushNamed(WebViewScreen.routeName, arguments: {
            'url': _url,
            ...attributes,
            'name': element.text,
          });
        }
      },
    );
  }
}
