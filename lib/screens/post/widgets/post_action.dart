import 'package:cirilla/models/models.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PostAction extends StatelessWidget {
  final Post post;
  final Color color;
  final Axis axis;

  PostAction({Key key, this.post, this.color, this.axis = Axis.horizontal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              InkWell(
                onTap: () => {},
                child: Icon(FeatherIcons.messageCircle, size: 18, color: color),
              ),
              SizedBox(height: 32),
              InkWell(
                onTap: () {},
                child: Icon(FeatherIcons.bookmark, size: 18, color: color),
              ),
              SizedBox(height: 32),
              InkWell(
                onTap: () => Share.share(post.link, subject: post.postTitle),
                child: Icon(FeatherIcons.share2, size: 18, color: color),
              ),
            ],
          ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 32,
        children: [
          InkWell(
            onTap: () => {},
            child: Icon(FeatherIcons.messageCircle, size: 18, color: color),
          ),
          InkWell(
            onTap: () {},
            child: Icon(FeatherIcons.bookmark, size: 18, color: color),
          ),
          InkWell(
            onTap: () => Share.share(post.link, subject: post.postTitle),
            child: Icon(FeatherIcons.share2, size: 18, color: color),
          ),
        ],
      ),
    );
  }
}
