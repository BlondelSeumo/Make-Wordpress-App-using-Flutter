import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/image_loading.dart';

class PostAuthor extends StatelessWidget with PostMixin {
  final Post post;
  final Color color;

  PostAuthor({Key key, this.post, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ImageLoading('https://lokeshdhakar.com/projects/lightbox2/images/image-3.jpg', width: 32, height: 32),
        ),
        SizedBox(width: 8),
        Text(post.postAuthor, style: theme.textTheme.caption.copyWith(color: color)),
      ],
    );
  }
}
