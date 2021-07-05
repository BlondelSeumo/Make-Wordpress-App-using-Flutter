import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product_image.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/product/widgets/product_image_popup.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:ui/image/image_loading.dart';

import 'product_slideshow_pagination.dart';

class ProductSlideshow extends StatefulWidget {
  final List<ProductImage> images;
  final int scrollDirection;
  final double width;
  final double height;
  final String productGalleryFit;

  final WidgetConfig configs;

  const ProductSlideshow({
    Key key,
    this.images,
    this.scrollDirection = 0,
    this.width,
    this.height,
    this.productGalleryFit,
    this.configs,
  }) : super(key: key);

  @override
  _ProductSlideshowState createState() => _ProductSlideshowState();
}

class _ProductSlideshowState extends State<ProductSlideshow> with ProductSlideshowPagination, Utility {
  SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    List<ProductImage> images = widget.images;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = widget.height == 0 ? screenHeight : (screenWidth * widget.height) / widget.width;

    // Indicator
    Map<String, dynamic> styles = widget.configs.styles;
    Alignment indicatorAlignment = ConvertData.toAlignment(get(styles, ['indicatorAlignment'], 'bottom-left'));
    Map<String, dynamic> indicatorMargin = get(styles, ['indicatorMargin'], null);

    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: containerHeight, width: screenWidth),
      child: Swiper(
        controller: _controller,
        scrollDirection: Axis.values[widget.scrollDirection],
        itemBuilder: (BuildContext context, int index) {
          ProductImage image = images[index];
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, _a1, _a2) => ProductImagesPopup(
                          images: images,
                          arguments: ProductImagesPopupArguments(
                            index,
                            _controller,
                          )),
                    ),
                  );
                },
                child: Hero(
                  tag: "product_images_${image.id}",
                  child: ImageLoading(
                    image.shopSingle,
                    fit: ConvertData.toBoxFit(widget.productGalleryFit),
                    width: screenWidth,
                    height: containerHeight,
                  ),
                ),
              );
            },
          );
        },
        itemCount: images.length,
        pagination: SwiperPagination(
          alignment: indicatorAlignment,
          margin: ConvertData.space(indicatorMargin, 'indicatorMargin', EdgeInsetsDirectional.zero),
          builder: buildPagination(context),
        ),
      ),
    );
  }

  SwiperPlugin buildPagination(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';

    // Indicator
    Map<String, dynamic> styles = widget.configs.styles;

    String productGalleryIndicator = get(styles, ['productGalleryIndicator'], 'dot');

    Map<String, dynamic> indicatorColor = get(styles, ['indicatorColor', themeModeKey], null);
    Map<String, dynamic> indicatorActiveColor = get(styles, ['indicatorActiveColor', themeModeKey], null);
    double indicatorSize = ConvertData.stringToDouble(get(styles, ['indicatorSize'], 6));
    double indicatorActiveSize = ConvertData.stringToDouble(get(styles, ['indicatorActiveSize'], 10));
    double indicatorSpace = ConvertData.stringToDouble(get(styles, ['indicatorSpace'], 4));

    Color colorIndicator = ConvertData.fromRGBA(indicatorColor, theme.indicatorColor);
    Color colorIndicatorActive = ConvertData.fromRGBA(indicatorActiveColor, theme.indicatorColor);
    double indicatorBorderRadius = ConvertData.stringToDouble(get(styles, ['indicatorBorderRadius'], 8));

    if (productGalleryIndicator == 'image') {
      return imagePagination(
        images: widget.images,
        controller: _controller,
        activeColor: colorIndicatorActive,
        size: indicatorSize,
        space: indicatorSpace,
        borderRadius: indicatorBorderRadius,
      );
    }
    if (productGalleryIndicator.toLowerCase() == 'number') {
      return numberPagination(
        textStyle: theme.textTheme.overline.apply(color: colorIndicatorActive),
        background: colorIndicator,
        size: indicatorSize,
        space: indicatorSpace,
        borderRadius: indicatorBorderRadius,
      );
    }

    return DotSwiperPaginationBuilder(
      color: colorIndicator,
      activeColor: colorIndicatorActive,
      size: indicatorSize,
      activeSize: indicatorActiveSize,
      space: indicatorSpace,
    );
  }
}
