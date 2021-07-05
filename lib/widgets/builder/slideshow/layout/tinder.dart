import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cirilla/widgets/widgets.dart';

import 'view.dart';

class Tinder extends View {
  Tinder({
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
    double widthItem = width;
    double heightItem = (widthItem * size.height) / size.width;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Swiper(
            itemWidth: widthItem,
            itemHeight: heightItem,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: widthItem,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: buildItem(context, index, Size(widthItem, heightItem)),
                ),
              );
            },
            autoplay: autoPlay,
            autoplayDelay: delay + interval,
            duration: interval,
            itemCount: count,
            curve: Curves.linear,
            viewportFraction: 1,
            scale: 1,
            layout: SwiperLayout.TINDER,
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
