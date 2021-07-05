import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutList extends StatefulWidget {
  final List<Post> posts;
  final BuildItemPostType buildItem;
  final double pad;
  final Color dividerColor;
  final double dividerHeight;
  final EdgeInsetsDirectional padding;

  final double width;
  final double height;

  const LayoutList({
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
  _LayoutListState createState() => _LayoutListState();
}

class _LayoutListState extends State<LayoutList> with PostMixin {
  final GlobalKey _containerKey = GlobalKey();
  double widthView = 300;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  }

  getSize() {
    RenderBox containerBox = _containerKey.currentContext.findRenderObject();
    double startPad = widget?.padding?.start ?? 0;
    double endPad = widget.padding?.end ?? 0;

    setState(() {
      widthView = containerBox.size.width - startPad - endPad;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      key: _containerKey,
      child: Column(
        children: List.generate(
          widget.posts.length,
          (int index) {
            double newWidth = widthView;
            double newHeight = (newWidth * widget.height) / widget.width;

            return Column(
              children: [
                widget.buildItem(
                  context,
                  post: widget.posts[index],
                  index: index,
                  width: newWidth,
                  height: newHeight,
                ),
                if (index < widget.posts.length - 1)
                  CirillaDivider(
                    color: widget.dividerColor,
                    height: widget.pad,
                    thickness: widget.dividerHeight,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
