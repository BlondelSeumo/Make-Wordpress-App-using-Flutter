import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:cirilla/widgets/cirilla_shimmer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

abstract class CategoryMixin {
  /// Exclude categories
  List<ProductCategory> exclude({List<ProductCategory> categories, List<int> excludes}) {
    if (excludes.length == 0 || categories.length == 0) return categories;

    List<ProductCategory> _categories = <ProductCategory>[];

    for (ProductCategory productCategory in categories) {
      if (!excludes.contains(productCategory.id)) {
        _categories.add(ProductCategory(
          id: productCategory.id,
          name: productCategory.name,
          description: productCategory.description,
          parent: productCategory.parent,
          count: productCategory.count,
          image: productCategory.image,
          categories: exclude(categories: productCategory.categories, excludes: excludes),
        ));
      }
    }
    return _categories;
  }

  /// Flatten category
  List<ProductCategory> flatten({List<ProductCategory> categories}) {
    if (categories.length == 0 || categories.length == 0) return categories;

    List<ProductCategory> _categories = <ProductCategory>[];

    _categories = categories
        .expand(
          (productCategory) => [
            ProductCategory(
              id: productCategory.id,
              name: productCategory.name,
              description: productCategory.description,
              parent: productCategory.parent,
              count: productCategory.count,
              image: productCategory.image,
              categories: [],
            ),
            ...flatten(categories: productCategory.categories),
          ],
        )
        .toList();

    return _categories;
  }

  /// Include categories
  List<ProductCategory> include({List<ProductCategory> categories, List<int> includes}) {
    if (includes.length == 0 || categories.length == 0) return categories;

    List<ProductCategory> _categories = <ProductCategory>[];

    for (ProductCategory productCategory in categories) {
      List<ProductCategory> subs = include(categories: productCategory.categories, includes: includes);

      if (includes.contains(productCategory.id)) {
        _categories.add(ProductCategory(
          id: productCategory.id,
          name: productCategory.name,
          description: productCategory.description,
          parent: productCategory.parent,
          count: productCategory.count,
          image: productCategory.image,
          categories: subs,
        ));
      } else {
        _categories.addAll(subs);
      }
    }
    return _categories;
  }

  /// Max depth categories
  List<ProductCategory> depth({List<ProductCategory> categories, int maxDepth = 3, int level = 1}) {
    if (categories.length == 0) return categories;

    List<ProductCategory> _categories = <ProductCategory>[];

    for (ProductCategory productCategory in categories) {
      _categories.add(
        ProductCategory(
            id: productCategory.id,
            name: productCategory.name,
            description: productCategory.description,
            parent: productCategory.parent,
            count: productCategory.count,
            image: productCategory.image,
            categories: level < maxDepth
                ? depth(categories: productCategory.categories, maxDepth: maxDepth, level: level + 1)
                : []),
      );
    }
    return _categories;
  }

  /// Get categories by parent
  List<ProductCategory> parent({List<ProductCategory> categories, int parentId = 0}) {
    if (categories.length == 0) return categories;

    List<ProductCategory> _categories = <ProductCategory>[];
    for (ProductCategory productCategory in categories) {
      if (productCategory.parent == parentId) {
        _categories.add(productCategory);
      }
      _categories.addAll(parent(categories: productCategory.categories, parentId: parentId));
    }
    return _categories;
  }

  Widget buildImage(
      {ProductCategory category,
      double width,
      double height,
      String borderStyle = 'none',
      Color borderColor,
      double pad = 0,
      double radius = 0,
      bool enableRoundImage = false,
      String sizes = 'shopCatalog'}) {
    if (borderStyle == 'none') {
      double radiusImage = enableRoundImage
          ? width > height
              ? width / 2
              : height / 2
          : radius;
      return ClipRRect(
        borderRadius: BorderRadius.circular(radiusImage),
        child: ImageItem(
          url: category.image != null ? category.image.values(sizes) : '',
          size: Size(width, height),
        ),
      );
    }

    double widthImage = width - 2 * pad < 0 ? width : width - 2 * pad;
    double heightImage = height - 2 * pad < 0 ? height : height - 2 * pad;
    double radiusImageBox = enableRoundImage
        ? width > height
            ? width / 2
            : height / 2
        : radius;
    double radiusImage = enableRoundImage
        ? widthImage > heightImage
            ? widthImage / 2
            : heightImage / 2
        : radius;

    if (borderStyle == 'solid') {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusImageBox),
          border: Border.all(width: 1, color: borderColor),
        ),
        padding: EdgeInsets.all(pad),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusImage),
          child: ImageItem(
            url: category?.image?.src ?? '',
            size: Size(width, height),
          ),
        ),
      );
    }

    List<double> dashPattern = borderStyle == 'dashed' ? [5, 3] : [2, 2];

    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(radiusImageBox),
      padding: EdgeInsets.all(pad),
      dashPattern: dashPattern,
      color: borderColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusImage),
        child: ImageItem(
          url: category?.image?.src ?? '',
          size: Size(widthImage, heightImage),
        ),
      ),
    );
  }

  Widget buildName({
    ProductCategory category,
    TextStyle style,
    TextAlign textAlign,
    ThemeData theme,
  }) {
    return Text(category.name, style: style ?? theme.textTheme.subtitle2, textAlign: textAlign);
  }

  Widget buildCount({
    ProductCategory category,
    TextStyle style,
    TextAlign textAlign,
    ThemeData theme,
  }) {
    String text = category?.count is int && category.count > 1 ? '${category.count} items' : '${category.count} item';
    return Text(text, style: style ?? theme.textTheme.caption, textAlign: textAlign);
  }

  Widget buildNamePostCategory({PostCategory category, ThemeData theme, Color color}) {
    if (category.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 24,
          width: double.infinity,
          color: Colors.white,
        ),
      );
    }
    return Text(category.name, style: theme.textTheme.subtitle2.copyWith(color: color));
  }

  Widget buildImagePostCategory({
    PostCategory category,
    double width = 109,
    double height = 109,
    double radius = 8,
    bool enableRound = false,
  }) {
    double borderRadius = !enableRound
        ? radius
        : width > height
            ? width / 2
            : height / 2;
    if (category.id == null) {
      return CirillaShimmer(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: ImageItem(
        url: category.image ?? '',
        size: Size(width, height),
      ),
    );
  }

  Widget buildCountPostCategory({
    PostCategory category,
    int count,
    double size = 22,
    Color color = Colors.black,
    TextStyle countStyle,
  }) {
    if (category.id == null) {
      return CirillaShimmer(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return Badge(
      text: Text(
        category.count.toString(),
        style: countStyle,
      ),
      color: color,
      size: size,
    );
  }
}
