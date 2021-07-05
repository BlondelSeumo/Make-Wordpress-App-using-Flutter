import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/post_author/post_author.dart';
import 'package:cirilla/store/post_author/post_author_store.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

import '../../builder_item/carousel.dart';
import '../../builder_item/two_column.dart';
import '../../builder_item/one_column.dart';

class PostAuthorWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  PostAuthorWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _PostAuthorWidgetState createState() => _PostAuthorWidgetState();
}

class _PostAuthorWidgetState extends State<PostAuthorWidget> with Utility, NavigationMixin {
  SettingStore _settingStore;
  AppStore _appStore;
  PostAuthorStore _postAuthorStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(widget.widgetConfig.id) == null) {
      PostAuthorStore store = PostAuthorStore(_settingStore.requestHelper, perPage: limit, key: widget.widgetConfig.id)
        ..getPostAuthors();
      _appStore.addStore(store);
      _postAuthorStore ??= store;
    } else {
      _postAuthorStore = _appStore.getStoreByKey(widget.widgetConfig.id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    String layout = widget?.widgetConfig?.layout ?? 'carousel';

    // Styles
    Map<String, dynamic> styles = widget?.widgetConfig?.styles ?? {};
    Map margin = get(styles, ['margin'], {});
    Map padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);

    // Config general
    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));
    String template = get(fields, ['template', 'template'], 'default');
    Map dataTemplate = get(fields, ['template', 'data'], {});
    double pad = ConvertData.stringToDouble(get(fields, ['pad'], 0));

    return Observer(builder: (_) {
      if (_postAuthorStore == null) return Container();

      bool loading = _postAuthorStore.loading;
      List<PostAuthor> postAuthors = _postAuthorStore.postAuthors;
      return Container(
        margin: ConvertData.space(margin, 'margin'),
        padding: ConvertData.space(padding, 'padding'),
        color: background,
        child: loading
            ? buildLayout(
                layout: layout,
                length: limit,
                pad: pad,
                renderItem: (int index, double width) => buildItemLoading(
                  context,
                  template: template,
                  dataTemplate: dataTemplate,
                  width: width,
                  themeModeKey: themeModeKey,
                ),
              )
            : postAuthors.length > 0
                ? buildLayout(
                    layout: layout,
                    length: postAuthors.length,
                    pad: pad,
                    renderItem: (int index, double width) => buildItem(
                      context,
                      author: postAuthors[index],
                      template: template,
                      dataTemplate: dataTemplate,
                      width: width,
                      themeModeKey: themeModeKey,
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
    Widget Function(int index, double width) renderItem,
  }) {
    switch (layout) {
      case 'two_columns':
        return TwoColumn(
          itemCount: length,
          axisSpacing: pad,
          buildItem: (BuildContext context, int index, double width) => renderItem(index, width),
        );
      case 'list':
        return OneColumn(
          itemCount: length,
          axisSpacing: pad,
          buildItem: (BuildContext context, int index, double width) => renderItem(index, width),
        );
      default:
        return Carousel(
          length: length,
          pad: pad,
          renderItem: (BuildContext context, int index) => renderItem(index, null),
        );
    }
  }

  Widget buildItemLoading(
    BuildContext context, {
    String template,
    Map dataTemplate,
    double width,
    String themeModeKey,
  }) {
    ThemeData theme = Theme.of(context);

    switch (template) {
      case 'contained':
        bool enableAvatar = get(dataTemplate, ['enableAvatar'], true);
        bool enableCount = get(dataTemplate, ['enableCount'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], true);
        Color background = ConvertData.fromRGBA(
            get(dataTemplate, ['background', themeModeKey ?? 'value'], {'r': 0, 'b': 0, 'g': 0, 'a': 0}),
            Colors.transparent);
        return UserContainedItem(
          onClick: () => {},
          image: enableAvatar
              ? Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(color: theme.canvasColor, shape: BoxShape.circle),
                )
              : null,
          title: Container(height: 16, width: double.infinity, color: theme.canvasColor),
          trailing: enableCount ? Container(height: 8, width: double.infinity, color: theme.canvasColor) : null,
          color: background,
          elevation: enableShadow ? 5 : 0,
          width: width ?? 248,
        );
      default:
        bool enableAvatar = get(dataTemplate, ['enableAvatar'], true);
        bool enableCount = get(dataTemplate, ['enableCount'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], true);
        Color background = ConvertData.fromRGBA(
            get(dataTemplate, ['background', themeModeKey ?? 'value'], {'r': 0, 'b': 0, 'g': 0, 'a': 0}),
            Colors.transparent);
        return UserVerticalItem(
          onClick: () => {},
          image: enableAvatar
              ? Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(color: theme.canvasColor, shape: BoxShape.circle),
                )
              : null,
          title: Container(
            width: double.infinity,
            height: 16,
            color: theme.canvasColor,
            constraints: BoxConstraints(maxWidth: 117),
          ),
          trailing: enableCount
              ? Container(
                  width: double.infinity,
                  height: 8,
                  color: theme.canvasColor,
                  constraints: BoxConstraints(maxWidth: 117),
                )
              : null,
          width: width ?? 159,
          color: background,
          elevation: enableShadow ? 5 : 0,
        );
    }
  }

  Widget buildItem(
    BuildContext context, {
    PostAuthor author,
    String template,
    Map dataTemplate,
    double width,
    String themeModeKey,
  }) {
    ThemeData theme = Theme.of(context);

    switch (template) {
      case 'contained':
        bool enableAvatar = get(dataTemplate, ['enableAvatar'], true);
        bool enableCount = get(dataTemplate, ['enableCount'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], true);
        Color background = ConvertData.fromRGBA(
            get(dataTemplate, ['background', themeModeKey ?? 'value'], {'r': 0, 'b': 0, 'g': 0, 'a': 0}),
            Colors.transparent);
        return UserContainedItem(
          image: enableAvatar
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    author?.avatar?.medium ?? Assets.noImageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          title: Text(author.name, style: theme.textTheme.subtitle1),
          trailing: enableCount ? Text('${author?.count ?? '0'} Articles', style: theme.textTheme.overline) : null,
          color: background,
          elevation: enableShadow ? 5 : 0,
          width: width ?? 248,
          onClick: () {},
        );
      default:
        bool enableAvatar = get(dataTemplate, ['enableAvatar'], true);
        bool enableCount = get(dataTemplate, ['enableCount'], true);
        bool enableShadow = get(dataTemplate, ['enableShadow'], true);
        Color background = ConvertData.fromRGBA(
            get(dataTemplate, ['background', themeModeKey ?? 'value'], {'r': 0, 'b': 0, 'g': 0, 'a': 0}),
            Colors.transparent);
        return UserVerticalItem(
          image: enableAvatar
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    author?.avatar?.medium ?? Assets.noImageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          title: Text(author.name, style: theme.textTheme.subtitle1),
          trailing: enableCount ? Text('${author?.count ?? '0'} Articles', style: theme.textTheme.overline) : null,
          width: width ?? 159,
          color: background,
          elevation: enableShadow ? 5 : 0,
          onClick: () {},
        );
    }
  }
}
