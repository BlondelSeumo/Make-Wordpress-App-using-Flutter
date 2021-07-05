import 'package:cirilla/models/models.dart';
import 'package:cirilla/routes.dart';
import 'package:flutter/material.dart';

class PostTagWidget extends StatelessWidget {
  final Post post;
  final double paddingHorizontal;

  PostTagWidget({Key key, this.post, this.paddingHorizontal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Text('Tags:', style: theme.textTheme.subtitle2),
        ),
        if (post.postTags.length > 0) ...[
          SizedBox(height: 16),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              itemBuilder: (BuildContext context, int index) => ElevatedButton(
                child: Text(post.postTags[index].name),
                style: ElevatedButton.styleFrom(
                  onPrimary: theme.textTheme.subtitle2.color,
                  primary: theme.colorScheme.surface,
                  textStyle: theme.textTheme.caption.copyWith(fontWeight: FontWeight.w500),
                  elevation: 0,
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.posts, arguments: {'tag': post.postTags[index]});
                },
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8),
              itemCount: post.postTags.length,
            ),
          ),
        ],
      ],
    );
  }
}
