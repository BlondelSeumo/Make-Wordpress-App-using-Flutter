import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/routes.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class PostTagWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  PostTagWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _PostTagWidgetState createState() => _PostTagWidgetState();
}

class _PostTagWidgetState extends State<PostTagWidget> with Utility, NavigationMixin {
  SettingStore _settingStore;
  AppStore _appStore;
  PostTagStore _postTagStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey('${widget.widgetConfig.id}_$limit') == null) {
      PostTagStore store = PostTagStore(
        _settingStore.requestHelper,
        perPage: limit,
        key: '${widget.widgetConfig.id}_$limit',
      )..getPostTags();
      _appStore.addStore(store);
      _postTagStore ??= store;
    } else {
      _postTagStore = _appStore.getStoreByKey('${widget.widgetConfig.id}_$limit');
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    String layout = widget?.widgetConfig?.layout ?? 'wrap';

    // Styles
    Map<String, dynamic> styles = widget?.widgetConfig?.styles ?? {};
    Map margin = get(styles, ['margin'], {});
    Map padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);

    // Config general
    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));
    double pad = ConvertData.stringToDouble(get(fields, ['pad'], '0'));
    double height = ConvertData.stringToDouble(get(fields, ['height'], '34'));
    double borderRadius = ConvertData.stringToDouble(get(fields, ['borderRadius'], '5'));

    // Item
    Color itemColor = ConvertData.fromRGBA(get(styles, ['itemColor', themeModeKey], {}), Colors.black);
    Color itemBackground = ConvertData.fromRGBA(get(styles, ['itemBackground', themeModeKey], {}), Colors.transparent);
    Color itemBorderColor =
        ConvertData.fromRGBA(get(styles, ['itemBorderColor', themeModeKey], {}), theme.dividerColor);

    return Observer(builder: (_) {
      if (_postTagStore == null) return Container();

      bool loading = _postTagStore.loading;
      List<PostTag> postTags = _postTagStore.postTags;
      return Container(
        margin: ConvertData.space(margin, 'margin'),
        padding: ConvertData.space(padding, 'padding'),
        color: background,
        child: loading
            ? buildLayout(
                layout: layout,
                length: limit,
                pad: pad,
                renderItem: (int index) => buildItem(
                  context,
                  itemColor: itemColor,
                  itemBackground: itemBackground,
                  itemBorderColor: itemBorderColor,
                  loading: true,
                  borderRadius: borderRadius,
                  height: height,
                ),
              )
            : postTags.length > 0
                ? buildLayout(
                    layout: layout,
                    length: postTags.length,
                    pad: pad,
                    renderItem: (int index) => buildItem(
                      context,
                      tag: postTags[index],
                      itemColor: itemColor,
                      itemBackground: itemBackground,
                      itemBorderColor: itemBorderColor,
                      borderRadius: borderRadius,
                      height: height,
                    ),
                  )
                : null,
      );
    });
  }

  Widget buildLayout({
    String layout,
    int length,
    double pad,
    Widget Function(int index) renderItem,
  }) {
    switch (layout) {
      case 'carousel':
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              length,
              (index) => Padding(
                padding: EdgeInsetsDirectional.only(end: index < length - 1 ? pad : 0),
                child: renderItem(index),
              ),
            ),
          ),
        );
      default:
        return Wrap(
          spacing: pad,
          runSpacing: pad,
          children: List.generate(
            length,
            (index) => renderItem(index),
          ),
        );
    }
  }

  Widget buildItem(
    BuildContext context, {
    PostTag tag,
    Color itemColor,
    Color itemBackground,
    Color itemBorderColor,
    double height = 34,
    bool loading = false,
    double borderRadius = 3,
  }) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: () => loading ? {} : Navigator.pushNamed(context, Routes.posts, arguments: {'tag': tag}),
        child: Text(!loading && tag != null ? '#${tag.name}' : '#loading'),
        style: OutlinedButton.styleFrom(
          primary: itemColor,
          backgroundColor: itemBackground,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: itemBorderColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: Theme.of(context).textTheme.caption,
          padding: EdgeInsets.symmetric(horizontal: 24),
        ),
      ),
    );
  }
}
