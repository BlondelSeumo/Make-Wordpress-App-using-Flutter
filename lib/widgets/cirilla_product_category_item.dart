import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/product_list/product_list.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

class CirillaProductCategoryItem extends StatelessWidget with Utility, CategoryMixin {
  // Template item style
  final Map<String, dynamic> template;

  final ProductCategory category;

  final double width;

  final double height;

  final Color background;

  final Color textColor;

  final Color subTextColor;

  final TextStyle textStyle;

  final TextStyle subTextStyle;

  final double radius;

  final double radiusImage;

  CirillaProductCategoryItem({
    Key key,
    this.template,
    this.category,
    this.width,
    this.height,
    this.background,
    this.textColor,
    this.subTextColor,
    this.textStyle,
    this.subTextStyle,
    this.radius,
    this.radiusImage,
  }) : super(key: key);

  void navigate(BuildContext context) {
    if (category.id == null) {
      return;
    }
    Navigator.pushNamed(context, ProductListScreen.routeName, arguments: {'category': category});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';

    String temp = get(template, ['template'], Strings.postItemContained);
    bool enableName = get(template, ['data', 'enableName'], true);

    TextStyle countStyle = subTextStyle ?? theme.textTheme.caption;

    switch (temp) {
      case Strings.productCategoryItemWrap:
        bool enableNumber = get(template, ['data', 'enableNumber'], true);
        bool enableRoundImage = get(template, ['data', 'enableRoundImage'], true);

        double widthItem = width ?? 335;
        double heightItem = height is double && height > 0 ? height : 92;

        double sizeImage = heightItem < 60 ? heightItem : 60;
        double paddingVertical = (heightItem - sizeImage) / 2;

        TextStyle nameStyle = textStyle ?? theme.textTheme.subtitle1;

        return SizedBox(
          width: widthItem,
          height: heightItem,
          child: ProductCategoryCardItem(
            image: buildImage(
              category: category,
              width: sizeImage,
              height: sizeImage,
              radius: radiusImage ?? 0,
              enableRoundImage: enableRoundImage ?? true,
            ),
            name: enableName
                ? buildName(
                    category: category,
                    style: nameStyle.copyWith(color: textColor ?? Colors.white),
                    theme: theme,
                  )
                : null,
            color: background ?? theme.cardColor,
            count: enableNumber
                ? buildCount(
                    category: category,
                    style: countStyle.copyWith(color: subTextColor),
                    theme: theme,
                  )
                : null,
            type: 'block',
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: paddingVertical),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
            onClick: () => navigate(context),
          ),
        );
      case Strings.productCategoryItemHorizontal:
        bool enableNumber = get(template, ['data', 'enableNumber'], true);

        double widthItem = width ?? 335;
        double heightItem = height is double && height > 0 ? height : 92;

        TextStyle nameStyle = textStyle ?? theme.textTheme.subtitle1;

        return SizedBox(
          width: widthItem,
          height: heightItem,
          child: ProductCategoryHorizontalItem(
            image: buildImage(
              category: category,
              width: 92,
              height: heightItem > 92 ? 92 : heightItem,
              radius: radiusImage ?? 0,
            ),
            name: enableName
                ? buildName(
                    category: category,
                    style: nameStyle.copyWith(color: textColor ?? Colors.white),
                    theme: theme,
                  )
                : null,
            color: background ?? theme.cardColor,
            count: enableNumber
                ? buildCount(
                    category: category,
                    style: countStyle.copyWith(color: subTextColor),
                    theme: theme,
                  )
                : null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
            onClick: () => navigate(context),
          ),
        );
      case Strings.productCategoryItemOverlay:
        bool enableNumber = get(template, ['data', 'enableNumber'], false);
        TextAlign textAlign = ConvertData.toTextAlign(get(template, ['data', 'alignment'], 'left'));
        double opacity = ConvertData.stringToDouble(get(template, ['data', 'opacity'], 0.5));
        Color opacityColor =
            ConvertData.fromRGBA(get(template, ['data', 'opacityColor', themeModeKey], {}), Colors.black);

        double widthItem = width is double && width > 0
            ? width
            : height is double && height > 0
                ? height
                : 160;
        double heightItem = height is double && height > 0 ? height : widthItem;
        TextStyle nameStyle = textStyle ?? theme.textTheme.subtitle1;

        return ProductCategoryOverlayItem(
          image: buildImage(
            category: category,
            width: widthItem,
            height: heightItem,
            radius: radiusImage ?? 8,
          ),
          name: enableName
              ? buildName(
                  category: category,
                  style: nameStyle.copyWith(color: textColor ?? Colors.white),
                  theme: theme,
                  textAlign: textAlign,
                )
              : null,
          count: enableNumber
              ? buildCount(
                  category: category,
                  style: countStyle.copyWith(color: subTextColor ?? Colors.white),
                  theme: theme,
                  textAlign: textAlign,
                )
              : null,
          opacityColor: opacityColor,
          opacity: opacity,
          borderRadius: BorderRadius.circular(radius ?? 8),
          onClick: () => navigate(context),
        );
        break;
      default:
        bool enableNumber = get(template, ['data', 'enableNumber'], false);
        bool enableRoundImage = get(template, ['data', 'enableRoundImage'], false);
        TextAlign textAlign = ConvertData.toTextAlign(get(template, ['data', 'alignment'], 'left'));
        double pad = ConvertData.stringToDouble(get(template, ['data', 'pad'], 0));
        Color borderColor =
            ConvertData.fromRGBA(get(template, ['data', 'borderColor', themeModeKey], {}), theme.dividerColor);
        String borderStyle = get(template, ['data', 'borderStyle'], 'none');
        double widthItem = width is double && width > 0
            ? width
            : height is double && height > 0
                ? height
                : 109;
        double heightItem = height is double && height > 0 ? height : widthItem;
        TextStyle nameStyle = textStyle ?? theme.textTheme.subtitle2;

        return ProductCategoryContainedItem(
          width: widthItem,
          image: buildImage(
            category: category,
            width: widthItem,
            height: heightItem,
            borderColor: borderColor,
            borderStyle: borderStyle,
            radius: radiusImage,
            enableRoundImage: enableRoundImage,
            pad: pad,
          ),
          name: enableName
              ? buildName(
                  category: category,
                  style: nameStyle.copyWith(color: textColor),
                  theme: theme,
                  textAlign: textAlign,
                )
              : null,
          count: enableNumber
              ? buildCount(
                  category: category,
                  style: countStyle.copyWith(color: subTextColor),
                  theme: theme,
                  textAlign: textAlign,
                )
              : null,
          color: background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 0)),
          onClick: () => navigate(context),
        );
    }
  }
}
