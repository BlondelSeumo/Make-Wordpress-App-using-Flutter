import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';

class LayoutSlideshow extends StatefulWidget {
  final List<Product> products;
  final BuildItemProductType buildItem;
  final double width;
  final double height;
  final Color indicatorColor;
  final Color indicatorActiveColor;
  final EdgeInsetsDirectional padding;
  final double widthView;

  LayoutSlideshow({
    Key key,
    this.products,
    this.buildItem,
    this.width,
    this.height,
    this.indicatorColor,
    this.indicatorActiveColor,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
  }) : super(key: key);

  @override
  _LayoutSlideshowState createState() => _LayoutSlideshowState();
}

class _LayoutSlideshowState extends State<LayoutSlideshow> {
  int pagination = 0;
  void changePagination(int value) {
    setState(() {
      pagination = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthWidget = widget.widthView - widget.padding.start - widget.padding.end;
    double width = widthWidget;
    double height = (width * widget.height) / widget.width;

    return Padding(
      padding: widget.padding,
      child: SizedBox(
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
              child: widget.buildItem(context, product: widget.products[index], width: width, height: height),
            );
          },
          itemCount: widget.products.length,
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
