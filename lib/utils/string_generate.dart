import 'dart:math';

import 'package:cirilla/models/models.dart';

class StringGenerate {
  static String uuid([int length = 9]) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(length, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  // General Product Store key
  static String getProductKeyStore(
    String id, {
    List<Product> excludeProduct,
    List<Product> includeProduct,
    List<int> tags,
    String currency,
    String language,
    int limit,
    int category,
    String search,
  }) {
    String key = id;

    if (excludeProduct != null && excludeProduct.length > 0) {
      String keyExcludes = excludeProduct.map((product) => "${product.id}").join('_');

      key = "${key}_exclude=$keyExcludes";
    }

    if (includeProduct != null && includeProduct.length > 0) {
      String keyIncludes = includeProduct.map((product) => "${product.id}").join('_');

      key = "${key}_include=$keyIncludes";
    }

    if (tags != null && tags.length > 0) {
      String keyTags = tags.map((tag) => "$tag").join('_');

      key = "${key}_tag=$keyTags";
    }

    if (currency != null && currency != "") {
      key = "${key}_currency=$currency";
    }

    if (language != null && language != "") {
      key = "${key}_language=$language";
    }

    if (limit != null) {
      key = "${key}_limit=$limit";
    }

    if (category != null) {
      key = "${key}_category=$category";
    }

    if (search != null) {
      key = "${key}_search=$search";
    }

    return key;
  }
}
