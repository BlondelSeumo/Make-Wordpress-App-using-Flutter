import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_post_item.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutBigFirst extends StatelessWidget with PostMixin {
  final List<Post> posts;

  final Map<String, dynamic> template;

  final BuildItemPostType buildItem;
  final double pad;
  final Color dividerColor;
  final double dividerHeight;
  final EdgeInsetsDirectional padding;

  const LayoutBigFirst({
    Key key,
    this.posts,
    this.buildItem,
    this.pad = 0,
    this.dividerColor,
    this.dividerHeight = 1,
    this.padding = EdgeInsetsDirectional.zero,
    this.template,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (posts.length <= 0) return Container();

    List<Post> _posts = List<Post>.of(posts);
    Post firstPost = _posts.removeAt(0);

    //
    double width = ConvertData.stringToDouble(get(template, ['data', 'size', 'width'], 100));
    double height = ConvertData.stringToDouble(get(template, ['data', 'size', 'height'], 100));

    return Container(
      padding: padding,
      child: Column(
        children: [
          Column(
            children: [
              FirstItem(post: firstPost, width: width, height: height, template: template),
              CirillaDivider(color: dividerColor, height: pad, thickness: dividerHeight),
            ],
          ),
          ...List.generate(
            posts.length,
            (int index) {
              double newWidth = MediaQuery.of(context).size.width;
              double newHeight = (newWidth * height) / width;
              return Column(
                children: [
                  buildItem(
                    context,
                    post: posts[index],
                    index: index,
                    width: newWidth,
                    height: newHeight,
                  ),
                  CirillaDivider(color: dividerColor, height: pad, thickness: dividerHeight)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class FirstItem extends StatelessWidget with PostMixin {
  final Post post;
  final double width;
  final double height;

  final Map<String, dynamic> template;

  const FirstItem({Key key, this.post, this.width, this.height, this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CirillaPostItem(
      index: 0,
      post: post,
      width: screenWidth,
      height: (screenWidth * height) / width,
      template: {
        'template': Strings.postItemContained,
        'data': template['data'],
      },
    );
  }
}
