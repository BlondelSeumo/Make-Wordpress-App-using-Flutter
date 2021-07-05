import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/screens/product_list/product_list.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'child_category.dart';

/// The widget used return category item type
///
class BuildItemProductCategory extends StatefulWidget {
  // Product category object
  final ProductCategory category;

  // Text show at name product
  final String textName;

  // Template of items
  final Map<String, dynamic> template;

  // styles of item
  final Map<String, dynamic> styles;

  // Item width
  final double widthItem;

  // Item height
  final double heightItem;

  // Key set theme darkmode
  final String themeModeKey;

  const BuildItemProductCategory({
    Key key,
    @required this.category,
    this.widthItem,
    this.heightItem,
    this.template = const {},
    this.styles = const {},
    this.textName = '',
    this.themeModeKey = 'value',
  }) : super(key: key);

  @override
  _BuildItemProductCategoryState createState() => _BuildItemProductCategoryState();
}

class _BuildItemProductCategoryState extends State<BuildItemProductCategory> with CategoryMixin {
  void navigate(BuildContext context) {
    Navigator.pushNamed(context, ProductListScreen.routeName, arguments: {'category': widget.category});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widthItem,
      child: buildItem(context),
    );
  }

  /// Build category child level 3
  Widget buildChildren(
    BuildContext context, {
    bool showChildren,
    int col,
    int maxCountChildren,
    Map<String, dynamic> template,
    Map<String, dynamic> configs,
  }) {
    return ChildCategory(
      parent: widget.category,
      template: template,
      styles: configs,
      col: col,
      perPage: maxCountChildren,
      themeModeKey: widget.themeModeKey,
    );
  }

  Widget buildItem(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // setting styles
    Color background =
        ConvertData.fromRGBA(get(widget.styles, ['backgroundItem', widget.themeModeKey], {}), theme.cardColor);
    double sizeText = ConvertData.stringToDouble(get(widget.styles, ['sizeText'], 16));
    Color textColor = ConvertData.fromRGBA(get(widget.styles, ['textColor', widget.themeModeKey], {}), Colors.white);
    double sizeSubtext = ConvertData.stringToDouble(get(widget.styles, ['sizeSubtext'], 12));
    Color subtextColor =
        ConvertData.fromRGBA(get(widget.styles, ['subtextColor', widget.themeModeKey], {}), Colors.white);
    double radiusItem = ConvertData.stringToDouble(get(widget.styles, ['radiusItem'], 8));
    double radiusImage = ConvertData.stringToDouble(get(widget.styles, ['radiusImage'], 0));

    String typeTemplate = get(widget.template, ['template'], Strings.productCategoryItemHorizontal);
    Map<String, dynamic> dataTemplate = get(widget.template, ['data'], {});

    switch (typeTemplate) {
      case Strings.productCategoryItemCard:
        // setting template
        // bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);
        bool enableImage = get(dataTemplate, ['enableImage'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableRound = get(dataTemplate, ['enableRound'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], false);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), Colors.white);

        // size image
        double size = widget.heightItem is double && widget.heightItem < 60 ? widget.heightItem : 60;

        double padVertical = size < 60
            ? 0
            : !(widget.heightItem is double)
                ? 16
                : (widget.heightItem - size) / 2;

        return ProductCategoryCardItem(
          image: enableImage
              ? buildImage(
                  category: widget.category,
                  width: size,
                  height: size,
                  radius: radiusImage,
                  enableRoundImage: enableRound)
              : null,
          name: buildNameProduct(nameStyle: theme.textTheme.subtitle1.copyWith(fontSize: sizeText, color: textColor)),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
                )
              : null,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: padVertical),
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusItem),
            side: enableBorder ? BorderSide(width: 1, color: borderColor) : BorderSide.none,
          ),
          elevation: enableShadow ? 5 : 0,
          onClick: () => navigate(context),
        );
        break;
      case Strings.productCategoryItemOverlay:
        // setting template
        // bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        TextAlign alignment = ConvertData.toTextAlign(get(dataTemplate, ['alignment'], 'center'));
        Color opacityColor =
            ConvertData.fromRGBA(get(dataTemplate, ['opacityColor', widget.themeModeKey], {}), Colors.black);
        double opacity = ConvertData.stringToDouble(get(dataTemplate, ['opacity'], 0.5));

        // size image
        double widthImage = widget.widthItem;
        double heightImage = widget.heightItem ?? widthImage;
        return ProductCategoryOverlayItem(
          image: buildImage(category: widget.category, width: widthImage, height: heightImage, radius: radiusImage),
          name: buildNameProduct(
            nameStyle: theme.textTheme.subtitle1.copyWith(fontSize: sizeText, color: textColor),
            textAlign: alignment,
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  textAlign: alignment,
                )
              : null,
          opacityColor: opacityColor,
          opacity: opacity,
          borderRadius: BorderRadius.circular(radiusItem),
          onClick: () => navigate(context),
        );
        break;
      case Strings.productCategoryItemContained:
        // setting template
        // bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);
        bool enableImage = get(dataTemplate, ['enableImage'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableRound = get(dataTemplate, ['enableRound'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], true);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), theme.dividerColor);

        // size image
        double sizeImage = widget.widthItem;

        return ProductCategoryContainedItem(
          image: enableImage
              ? buildImage(
                  category: widget.category,
                  width: sizeImage,
                  height: sizeImage,
                  radius: radiusImage,
                  borderStyle: enableBorder ? 'solid' : 'none',
                  borderColor: borderColor,
                  enableRoundImage: enableRound,
                )
              : null,
          name: buildNameProduct(
            nameStyle: theme.textTheme.subtitle1.copyWith(fontSize: sizeText, color: textColor),
            textAlign: TextAlign.center,
          ),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
                  textAlign: TextAlign.center,
                )
              : null,
          width: sizeImage,
          onClick: () => navigate(context),
        );
      case Strings.productCategoryItemGrid:
        // setting template
        bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        // item sub category
        int countSubcategory = ConvertData.stringToInt(get(dataTemplate, ['maxCountSubcategory'], 6));
        int colSubcategory = ConvertData.stringToInt(get(dataTemplate, ['columnSubcategory'], 3));

        Map<String, dynamic> dataTemplateSubcategory = {
          'enableSubcategories': false,
          'enableImage': true,
          'enableNumber': false,
          'enableRound': get(dataTemplate, ['enableRoundSubcategory'], false),
          'enableBorder': get(dataTemplate, ['enableBorderSubcategory'], true),
          'borderColor': get(dataTemplate, ['borderColorSubCategory'], {}),
        };
        Map<String, dynamic> stylesSubCategory = {
          'backgroundItem': {
            'dark': {'r': 255, 'g': 255, 'b': 255, 'a': 0},
            'value': {'r': 255, 'g': 255, 'b': 255, 'a': 0},
          },
          'radiusItem': 0,
          'radiusImage': get(dataTemplate, ['radiusSubCategory'], 8),
          'sizeText': get(dataTemplate, ['sizeSubcategory'], 12),
          'textColor': get(dataTemplate, ['textColorSubcategory'], {}),
        };
        return ProductCategoryGridItem(
          name: buildNameProduct(
            nameStyle: theme.textTheme.subtitle1.copyWith(fontSize: sizeText, color: textColor),
            countStyle: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
            showCount: enableNumber,
          ),
          action: InkWell(
            onTap: () => navigate(context),
            child: Text(
              'Show all',
              style: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
            ),
          ),
          color: background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusItem)),
          child: enableSubcategories && widget.category.categories.length > 0
              ? buildChildren(
                  context,
                  col: colSubcategory,
                  maxCountChildren: countSubcategory,
                  template: {
                    'template': Strings.productCategoryItemContained,
                    'data': dataTemplateSubcategory,
                  },
                  configs: stylesSubCategory,
                )
              : null,
        );
        break;
      case Strings.productCategoryItemBasic:
        // setting template
        // bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableIcon = get(dataTemplate, ['enableIcon'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], true);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), theme.dividerColor);
        double iconSize = ConvertData.stringToDouble(get(dataTemplate, ['iconSize'], 14));
        Color iconColor =
            ConvertData.fromRGBA(get(dataTemplate, ['iconColor', widget.themeModeKey], {}), theme.iconTheme.color);

        return ProductCategoryBasicItem(
          name: buildNameProduct(
            nameStyle: theme.textTheme.subtitle1.copyWith(fontSize: sizeText, color: textColor),
            countStyle: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
            showCount: enableNumber,
          ),
          border: enableBorder ? Border(bottom: BorderSide(width: 1, color: borderColor)) : null,
          icon: enableIcon ? Icon(FeatherIcons.chevronRight, size: iconSize, color: iconColor) : null,
          height: widget.heightItem ?? 58,
          color: background,
          padding: EdgeInsets.symmetric(vertical: 12),
          onClick: () => navigate(context),
        );
        break;
      default:
        // setting template
        // bool enableSubcategories = get(dataTemplate, ['enableSubcategories'], true);
        bool enableImage = get(dataTemplate, ['enableImage'], true);
        bool enableNumber = get(dataTemplate, ['enableNumber'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], false);
        bool enableBorder = get(dataTemplate, ['enableBorder'], false);
        Color borderColor =
            ConvertData.fromRGBA(get(dataTemplate, ['borderColor', widget.themeModeKey], {}), Colors.white);

        // size image
        double size = widget.heightItem is double && widget.heightItem < 92 ? widget.heightItem : 92;

        return ProductCategoryHorizontalItem(
          image: enableImage
              ? buildImage(category: widget.category, width: size, height: size, radius: radiusImage)
              : null,
          name: buildNameProduct(nameStyle: theme.textTheme.subtitle1.copyWith(fontSize: sizeText, color: textColor)),
          count: enableNumber
              ? buildCount(
                  category: widget.category,
                  style: theme.textTheme.caption.copyWith(fontSize: sizeSubtext, color: subtextColor),
                )
              : null,
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusItem),
            side: enableBorder ? BorderSide(width: 1, color: borderColor) : BorderSide.none,
          ),
          elevation: enableShadow ? 5 : 0,
          onClick: () => navigate(context),
        );
    }
  }

  Widget buildNameProduct({
    TextStyle nameStyle = const TextStyle(),
    TextStyle countStyle = const TextStyle(),
    bool showCount = false,
    TextAlign textAlign = TextAlign.start,
  }) {
    if (showCount) {
      return RichText(
        text: TextSpan(
          style: nameStyle,
          text: widget?.textName ?? widget.category.name,
          children: [
            TextSpan(text: ' '),
            TextSpan(
              text: '(${widget.category.count})',
              style: countStyle,
            )
          ],
        ),
      );
    }
    return Text(widget?.textName ?? widget.category.name, style: nameStyle, textAlign: textAlign);
  }
}
