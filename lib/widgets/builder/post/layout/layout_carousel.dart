import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutCarousel extends StatelessWidget {
  final List<Post> posts;
  final BuildItemPostType buildItem;
  final double pad;
  final Color dividerColor;
  final double dividerHeight;
  final EdgeInsetsDirectional padding;
  final double width;
  final double height;

  const LayoutCarousel({
    Key key,
    this.posts,
    this.buildItem,
    this.pad = 0,
    this.dividerColor,
    this.dividerHeight = 1,
    this.padding = EdgeInsetsDirectional.zero,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>
          buildItem(context, post: posts[index], index: index, width: width, height: height),
      separatorBuilder: (context, index) => CirillaDivider(
        color: dividerColor,
        height: pad,
        thickness: dividerHeight,
        axis: Axis.vertical,
      ),
      itemCount: posts.length,
    );
  }
}
