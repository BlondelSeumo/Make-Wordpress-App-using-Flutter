import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/widgets.dart';

import 'view.dart';

double widthPad = 64;

class CenterMode extends View {
  CenterMode({
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
    double widthItem = width - widthPad;
    double heightItem = (widthItem * size.height) / size.width;
    double viewportFraction = widthItem / width;
    double aspectRatio = (widthItem - 32) / widthItem;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: heightItem,
          child: Swiper(
            itemWidth: widthItem,
            itemHeight: heightItem,
            containerWidth: width,
            containerHeight: heightItem,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: buildItem(context, index, Size(widthItem, heightItem)),
                ),
              );
            },
            autoplay: autoPlay,
            autoplayDelay: delay + interval,
            duration: interval,
            curve: Curves.linear,
            itemCount: count,
            viewportFraction: viewportFraction,
            scale: aspectRatio,
            onIndexChanged: (int value) => changePagination(value),
          ),
        ),
        if (enableIndicator)
          Padding(
            padding: EdgeInsets.only(top: 16),
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
