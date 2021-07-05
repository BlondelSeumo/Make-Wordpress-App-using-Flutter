import 'package:flutter/material.dart';

import 'core_paragraph.dart';
import 'core_image.dart';
import 'core_gallery.dart';

class PostBlock extends StatelessWidget {
  static const String paragraph = 'core/paragraph';
  static const String gallery = 'core/gallery';
  static const String image = 'core/image';

  final Map<String, dynamic> block;

  const PostBlock({Key key, this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (block['blockName']) {
      case paragraph:
        return Paragraph(block: block);
      case image:
        return BlockImage(block: block);
      case gallery:
        return BlockGallery(block: block);
      default:
        return Paragraph(block: block);
    }
  }
}
