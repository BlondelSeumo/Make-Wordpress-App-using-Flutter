import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class BlockImage extends StatelessWidget {
  final Map<String, dynamic> block;

  const BlockImage({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var document = parse(block['innerHTML']);

    var image = document.getElementsByTagName("img")[0];

    if (image.attributes['src'] == null || image.attributes['src'] == "") return Container();

    return Image.network(image.attributes['src']);
  }
}
