import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/widgets.dart';

import 'view.dart';

class Basic extends View {
  Basic({
    Key key,
    @required Widget Function(BuildContext context, int index, Size size) buildItem,
    bool autoPlay,
    bool enableIndicator,
    int interval,
    int delay,
    int count,
    Size size,
    Color colorIndicator,
    Color colorIndicatorActive,
  }) : super(
          key: key,
          buildItem: buildItem,
          autoPlay: autoPlay ?? true,
          enableIndicator: enableIndicator ?? true,
          interval: interval ?? 1800,
          delay: delay ?? 1000,
          count: count ?? 2,
          size: size ?? Size(375, 330),
          colorIndicator: colorIndicator ?? Colors.black,
          colorIndicatorActive: colorIndicatorActive ?? Colors.black,
        );

  @override
  Widget buildLayout(BuildContext context, double width, int pagination, Function(int value) changePagination) {
    double height = (width * size.height) / size.width;
    return Column(
      children: [
        SizedBox(
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
                child: buildItem(context, index, Size(width, height)),
              );
            },
            autoplay: autoPlay,
            autoplayDelay: delay + interval,
            duration: interval,
            itemCount: count,
            viewportFraction: 1,
            scale: 1,
            curve: Curves.linear,
            onIndexChanged: (int value) => changePagination(value),
          ),
        ),
        if (enableIndicator)
          Container(
            height: 24,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CirillaPagination(
              length: count,
              visit: pagination,
              color: colorIndicator,
              colorActive: colorIndicatorActive,
            ),
          ),
      ],
    );
  }
}
