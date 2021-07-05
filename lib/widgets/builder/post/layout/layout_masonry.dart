import 'package:cirilla/models/models.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutMasonry extends StatelessWidget {
  final List<Post> posts;
  final Widget Function(BuildContext context, {Post post, int index, double width, double height}) buildItem;
  final double pad;
  final Color dividerColor;
  final double dividerHeight;
  final EdgeInsetsDirectional padding;

  final double width;
  final double height;

  LayoutMasonry({
    Key key,
    this.posts,
    this.buildItem,
    this.pad,
    this.dividerColor,
    this.dividerHeight,
    this.padding,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> listLeft = [];
    List<int> listRight = [];

    for (var i = 0; i < posts.length; i++) {
      if (i % 2 == 0) {
        listLeft.add(i);
      } else {
        listRight.add(i);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildList(context, items: listLeft, mod: 0)),
        SizedBox(width: 16),
        Expanded(child: _buildList(context, items: listRight)),
      ],
    );
  }

  Widget _buildList(context, {List<int> items, int mod = 1}) {
    return Column(
      children: List.generate(
        items.length,
        (int index) {
          double newHeight = height;

          if (index % 2 == mod) {
            newHeight = height * 0.8;
          }

          return Column(
            children: [
              buildItem(
                context,
                post: posts[items[index]],
                index: index,
                height: newHeight,
                width: width,
              ),
              CirillaDivider(
                color: dividerColor,
                height: pad,
                thickness: dividerHeight,
              ),
            ],
          );
        },
      ),
    );
  }
}
