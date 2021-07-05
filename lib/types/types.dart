import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';

typedef TranslateType = String Function(String key, [Map<String, String> options]);
typedef ShowMessageType = void Function({String message});

// Handle login type
typedef HandleLoginType = void Function(Map<String, dynamic> queryParameters);

// Type build item post
typedef BuildItemPostType = Widget Function(BuildContext context, {Post post, int index, double width, double height});

// Type build item product
typedef BuildItemProductType = Widget Function(BuildContext context, {Product product, double width, double height});

// Type build item product
typedef BuildItemProductCategoryType = Widget Function(BuildContext context,
    {ProductCategory category, double width, double height});

// Type build item product
typedef BuildItemPostCategoryType = Widget Function(BuildContext context,
    {PostCategory category, double width, double height});

// Type build item banner
typedef BuildItemBannerType = Widget Function(BuildContext context, {int index, double width, double height});
