import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';

class LayoutSlideshow extends StatefulWidget {
  final List<Post> posts;
  final BuildItemPostType buildItem;
  final double width;
  final double height;
  final Color indicatorColor;
  final Color indicatorActiveColor;
  final EdgeInsetsDirectional padding;

  LayoutSlideshow({
    Key key,
    this.posts,
    this.buildItem,
    this.width,
    this.height,
    this.indicatorColor,
    this.indicatorActiveColor,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  @override
  _LayoutSlideshowState createState() => _LayoutSlideshowState();
}

class _LayoutSlideshowState extends State<LayoutSlideshow> {
  int pagination = 0;
  final GlobalKey _containerKey = GlobalKey();
  double widthView = 300;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSize());
  }

  getSize() {
    RenderBox containerBox = _containerKey.currentContext.findRenderObject();

    setState(() {
      widthView = containerBox.size.width;
    });
  }

  void changePagination(int value) {
    setState(() {
      pagination = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = widthView;
    double height = (width * widget.height) / widget.width;

    return Padding(
      padding: widget.padding,
      child: SizedBox(
        key: _containerKey,
        width: double.infinity,
        height: height,
        child: Swiper(
          itemWidth: width,
          itemHeight: height,
          containerWidth: width,
          containerHeight: height,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: width,
              child: widget.buildItem(context, post: widget.posts[index], index: index, width: width, height: height),
            );
          },
          itemCount: widget.posts.length,
          curve: Curves.linear,
          pagination: SwiperPagination(
            margin: EdgeInsets.all(14),
            builder: DotSwiperPaginationBuilder(
              space: 4,
              activeSize: 6,
              size: 6,
              color: widget.indicatorColor,
              activeColor: widget.indicatorActiveColor,
            ),
          ),
          // onIndexChanged: (int value) => changePagination(value),
        ),
      ),
    );
  }
}
