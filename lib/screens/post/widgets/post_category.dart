import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';

class PostCategory extends StatelessWidget with PostMixin {
  final Post post;

  PostCategory({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return buildCategory(theme, post);
  }
}
