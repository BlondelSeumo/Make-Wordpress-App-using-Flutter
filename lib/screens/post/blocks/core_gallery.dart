import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class BlockGallery extends StatelessWidget {
  final Map<String, dynamic> block;

  const BlockGallery({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var document = parse(block['innerHTML']);

    var images = document.getElementsByTagName("figure");

    if (images == null || images.length == 0) return Container();

    List<Widget> _images = [];

    print(images);

    for (int i = 0; i < images.length; i++) {
      String image = images[i].getElementsByTagName("img")[0].attributes['src'];
      _images.add(Column(
        children: [Image.network(image)],
      ));
    }

    return Column(
      children: _images,
    );
  }
}
