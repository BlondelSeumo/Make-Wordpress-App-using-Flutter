import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder/post/layout/layout_big_first.dart';
import 'package:cirilla/widgets/cirilla_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'layout/layout_list.dart';
import 'layout/layout_carousel.dart';
import 'layout/layout_masonry.dart';
import 'layout/layout_slideshow.dart';

class PostWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  PostWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with Utility, PostMixin {
  AppStore _appStore;
  SettingStore _settingStore;
  PostStore _postStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};

    // Filter
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));
    String search = get(fields, ['search', _settingStore.languageKey], '');
    List<dynamic> tags = get(fields, ['tags'], []);
    List<dynamic> categories = get(fields, ['categories'], []);
    List<dynamic> post = get(fields, ['post'], []);

    // Gen key for store
    String keyTags = tags.map((e) => e['key']).join('_');
    String keyCategories = categories.map((e) => e['key']).join('_');
    String keyPosts = post.map((e) => e['key']).join('_');

    String key = '${widget.widgetConfig.id}_${search}_${keyTags}_${keyCategories}_$keyPosts';

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(key) == null) {
      PostStore store = PostStore(
        _settingStore.requestHelper,
        key: key,
        perPage: limit,
        search: search,
        tags: tags.map((t) => PostTag(id: ConvertData.stringToInt(t['key']))).toList(),
        categories: categories.map((t) => PostCategory(id: ConvertData.stringToInt(t['key']))).toList(),
        include: post.map((t) => Post(id: ConvertData.stringToInt(t['key']))).toList(),
      )..getPosts();
      _appStore.addStore(store);
      _postStore ??= store;
    } else {
      _postStore = _appStore.getStoreByKey(key);
    }
    super.didChangeDependencies();
  }

  void goDetail(BuildContext context, Post post) {
    Navigator.pushNamed(context, PostScreen.routeName, arguments: {'post': post});
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_postStore == null) return Container();
        String themeModeKey = _settingStore?.themeModeKey ?? 'value';

        bool loading = _postStore.loading;
        List<Post> posts = _postStore.posts;

        // Item style
        WidgetConfig configs = widget.widgetConfig;

        // Item template
        String layout = configs.layout ?? Strings.postLayoutList;

        // Style
        Map<String, dynamic> margin = get(configs.styles, ['margin'], {});
        Map<String, dynamic> padding = get(configs.styles, ['padding'], {});
        Map<String, dynamic> background = get(configs.styles, ['background', themeModeKey], {});
        var height = get(configs.styles, ['height'], '');

        List<Post> emptyPosts = List.generate(4, (index) => Post()).toList();

        return Container(
          margin: ConvertData.space(margin, 'margin'),
          height:
              height == "" || layout != Strings.postCategoryLayoutCarousel ? null : ConvertData.stringToDouble(height),
          color: ConvertData.fromRGBA(background, Colors.transparent),
          child: LayoutPostList(
            fields: configs.fields,
            styles: configs.styles,
            posts: loading ? emptyPosts : posts,
            layout: layout,
            padding: ConvertData.space(padding, 'padding'),
            themeModeKey: themeModeKey,
          ),
        );
      },
    );
  }
}

class LayoutPostList extends StatelessWidget {
  final Map<String, dynamic> fields;
  final Map<String, dynamic> styles;
  final List<Post> posts;
  final String layout;
  final EdgeInsetsDirectional padding;
  final String themeModeKey;

  LayoutPostList({
    Key key,
    this.fields = const {},
    this.styles = const {},
    this.posts,
    this.layout = Strings.postLayoutList,
    this.padding = EdgeInsetsDirectional.zero,
    this.themeModeKey = 'value',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // General config
    Map<String, dynamic> templateItem = get(fields, ['template'], {});
    double width = ConvertData.stringToDouble(get(templateItem, ['data', 'size', 'width'], 100));
    double height = ConvertData.stringToDouble(get(templateItem, ['data', 'size', 'height'], 100));

    // Styles config
    double pad = ConvertData.stringToDouble(get(styles, ['pad'], 0));
    double dividerHeight = ConvertData.stringToDouble(get(styles, ['dividerWidth'], 1));
    Color dividerColor = ConvertData.fromRGBA(get(styles, ['dividerColor', themeModeKey], {}), Colors.transparent);
    Color indicatorColor = ConvertData.fromRGBA(
      get(styles, ['indicatorColor', themeModeKey], {}),
      Theme.of(context).dividerColor,
    );
    Color indicatorActiveColor = ConvertData.fromRGBA(
      get(styles, ['indicatorActiveColor', themeModeKey], {}),
      Theme.of(context).primaryColor,
    );

    switch (layout) {
      case Strings.postLayoutCarousel:
        return LayoutCarousel(
          posts: posts,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          padding: padding,
          width: width,
          height: height,
        );
        break;
      case Strings.postLayoutMasonry:
        return LayoutMasonry(
          posts: posts,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          padding: padding,
          width: width,
          height: height,
        );
        break;
      case Strings.postLayoutBigFirst:
        return LayoutBigFirst(
          posts: posts,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          template: templateItem,
        );
        break;
      case Strings.postLayoutSlideshow:
        return LayoutSlideshow(
          posts: posts,
          buildItem: _buildItem,
          width: width,
          height: height,
          padding: padding,
          indicatorColor: indicatorColor,
          indicatorActiveColor: indicatorActiveColor,
        );
        break;
      default:
        return LayoutList(
          posts: posts,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          padding: padding,
          width: width,
          height: height,
        );
    }
  }

  Widget _buildItem(
    BuildContext context, {
    Post post,
    int index,
    double width = 100,
    double height = 100,
  }) {
    // Template
    Map<String, dynamic> templateItem = get(fields, ['template'], {});

    Color backgroundColor = ConvertData.fromRGBA(
      get(styles, ['backgroundColorItem', themeModeKey], {}),
      Theme.of(context).cardColor,
    );
    Color textColor = ConvertData.fromRGBA(
      get(styles, ['textColor', themeModeKey], {}),
      Theme.of(context).textTheme.subtitle1.color,
    );
    Color subTextColor = ConvertData.fromRGBA(
      get(styles, ['subTextColor', themeModeKey], {}),
      Theme.of(context).textTheme.caption.color,
    );
    Color labelColor = ConvertData.fromRGBA(get(styles, ['labelColor', themeModeKey], {}), Color(0xFF21BA45));
    Color labelTextColor = ConvertData.fromRGBA(get(styles, ['labelTextColor', themeModeKey], {}), Colors.white);
    double radius = ConvertData.stringToDouble(get(styles, ['radius'], 0));
    Color shadowColor = ConvertData.fromRGBA(get(styles, ['shadowColor', themeModeKey], {}), Colors.black);
    double offsetX = ConvertData.stringToDouble(get(styles, ['offsetX'], 0));
    double offsetY = ConvertData.stringToDouble(get(styles, ['offsetY'], 4));
    double blurRadius = ConvertData.stringToDouble(get(styles, ['blurRadius'], 24));
    double spreadRadius = ConvertData.stringToDouble(get(styles, ['spreadRadius'], 0));

    BoxShadow shadow = BoxShadow(
      color: shadowColor,
      offset: Offset(offsetX, offsetY),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );

    return CirillaPostItem(
      post: post,
      width: width,
      height: height,
      template: templateItem,
      index: index,
      background: backgroundColor,
      textColor: textColor,
      subTextColor: subTextColor,
      labelColor: labelColor,
      labelTextColor: labelTextColor,
      radius: radius,
      boxShadow: [shadow],
      // elevation: 5,
    );
  }
}
