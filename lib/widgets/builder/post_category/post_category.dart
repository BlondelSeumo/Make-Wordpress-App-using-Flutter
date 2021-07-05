import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/widgets/cirilla_post_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/mixins/mixins.dart';

import 'layout/layout_list.dart';
import 'layout/layout_carousel.dart';
import 'layout/layout_grid.dart';
import 'layout/layout_big_first.dart';
import 'layout/layout_masonry.dart';
import 'layout/layout_slideshow.dart';

class PostCategoryWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  PostCategoryWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _PostCategoryWidgetState createState() => _PostCategoryWidgetState();
}

class _PostCategoryWidgetState extends State<PostCategoryWidget> with Utility {
  SettingStore _settingStore;
  AppStore _appStore;
  PostCategoryStore _postCategoryStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    String language = _settingStore?.locale ?? 'en';
    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(widget.widgetConfig.id) == null) {
      PostCategoryStore store =
          PostCategoryStore(_settingStore.requestHelper, perPage: limit, lang: language, key: widget.widgetConfig.id)
            ..getPostCategories();
      _appStore.addStore(store);
      _postCategoryStore ??= store;
    } else {
      _postCategoryStore = _appStore.getStoreByKey(widget.widgetConfig.id);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    // Layout
    String layout = widget?.widgetConfig?.layout ?? Strings.postCategoryLayoutList;

    // Styles
    Map<String, dynamic> styles = widget?.widgetConfig?.styles ?? {};
    Map margin = get(styles, ['margin'], {});
    Map padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    double height = ConvertData.stringToDouble(get(styles, ['height'], 200));
    double pad = ConvertData.stringToDouble(get(styles, ['pad'], 16));

    // Styles
    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    Map<String, dynamic> template = get(fields, ['template'], {});

    // general config
    int limit = ConvertData.stringToInt(get(fields, ['limit'], 4));
    List<PostCategory> emptyCategories = List.generate(limit, (index) => PostCategory()).toList();

    return Observer(
      builder: (_) {
        bool loading = _postCategoryStore.loading;
        List<PostCategory> categories = _postCategoryStore.postCategories;

        return Container(
          margin: ConvertData.space(margin, 'margin'),
          color: background,
          height: layout == Strings.postCategoryLayoutCarousel ? height : null,
          child: LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              double widthView = constraints.maxWidth;
              return buildLayout(
                layout,
                categories: loading ? emptyCategories : categories,
                pad: pad,
                styles: styles,
                template: template,
                themeModeKey: themeModeKey,
                widthView: widthView,
                padding: ConvertData.space(padding, 'padding'),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildLayout(
    String layout, {
    List<PostCategory> categories,
    double pad,
    Map<String, dynamic> styles,
    Map<String, dynamic> template,
    String themeModeKey,
    double widthView,
    EdgeInsetsDirectional padding = EdgeInsetsDirectional.zero,
  }) {
    switch (layout) {
      case Strings.postCategoryLayoutCarousel:
        return LayoutCarousel(
          categories: categories,
          buildItem: (_, {PostCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          padding: padding,
        );
      case Strings.postCategoryLayoutGrid:
        int column = ConvertData.stringToInt(get(styles, ['col'], 2), 2);
        double ratio = ConvertData.stringToDouble(get(styles, ['ratio'], 1), 1);
        return LayoutGrid(
          categories: categories,
          buildItem: (_, {PostCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          column: column,
          ratio: ratio,
          pad: pad,
          padding: padding,
          widthView: widthView,
        );
      case Strings.postCategoryLayoutBigFirst:
        return LayoutBigFirst(
          categories: categories,
          buildItem: (_, {PostCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          template: template,
          padding: padding,
          widthView: widthView,
        );
      case Strings.postCategoryLayoutMasonry:
        return LayoutMasonry(
          categories: categories,
          buildItem: (_, {PostCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          padding: padding,
          widthView: widthView,
        );
      case Strings.postCategoryLayoutSlideshow:
        Color indicatorColor = ConvertData.fromRGBA(
          get(styles, ['indicatorColor', themeModeKey], {}),
          Theme.of(context).dividerColor,
        );
        Color indicatorActiveColor = ConvertData.fromRGBA(
          get(styles, ['indicatorActiveColor', themeModeKey], {}),
          Theme.of(context).primaryColor,
        );
        return LayoutSlideshow(
          categories: categories,
          buildItem: (_, {PostCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          indicatorColor: indicatorColor,
          indicatorActiveColor: indicatorActiveColor,
          padding: padding,
          widthView: widthView,
        );
      default:
        return LayoutList(
          categories: categories,
          buildItem: (_, {PostCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          padding: padding,
          widthView: widthView,
        );
    }
  }

  Widget buildItem({
    PostCategory category,
    Map<String, dynamic> template,
    Map<String, dynamic> styles,
    double width,
    double height,
  }) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    Color background = ConvertData.fromRGBA(get(styles, ['backgroundItem', themeModeKey], {}), Colors.transparent);
    Color textColor = ConvertData.fromRGBA(get(styles, ['textColor', themeModeKey], {}), Colors.black);
    Color labelColor = ConvertData.fromRGBA(get(styles, ['labelColor', themeModeKey], {}), Colors.black);
    Color labelTextColor = ConvertData.fromRGBA(get(styles, ['labelTextColor', themeModeKey], {}), Colors.white);
    double radius = ConvertData.stringToDouble(get(styles, ['radius'], 0));
    double radiusImage = ConvertData.stringToDouble(get(styles, ['radiusImage'], 0));

    return CirillaPostCategoryItem(
      category: category,
      width: width,
      height: height,
      template: template,
      background: background,
      textColor: textColor,
      labelColor: labelColor,
      labelTextColor: labelTextColor,
      radius: radius,
      radiusImage: radiusImage,
    );
  }
}
