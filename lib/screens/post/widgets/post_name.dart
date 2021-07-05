import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';

class PostName extends StatelessWidget {
  final Post post;
  final Color color;

  PostName({Key key, this.post, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(post.postTitle, style: theme.textTheme.headline6.copyWith(color: color));
  }
}
