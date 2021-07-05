import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:cirilla/routes.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostArchiveWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  PostArchiveWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  _PostArchiveWidgetState createState() => _PostArchiveWidgetState();
}

class _PostArchiveWidgetState extends State<PostArchiveWidget> with Utility, NavigationMixin {
  AppStore _appStore;
  SettingStore _settingStore;
  PostArchiveStore _postArchiveStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(widget.widgetConfig.id) == null) {
      PostArchiveStore store = PostArchiveStore(_settingStore.requestHelper, key: widget.widgetConfig.id)
        ..getPostArchives();
      _appStore.addStore(store);
      _postArchiveStore ??= store;
    } else {
      _postArchiveStore = _appStore.getStoreByKey(widget.widgetConfig.id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_postArchiveStore == null) return Container();
      String themeModeKey = _settingStore.themeModeKey;

      bool loading = _postArchiveStore.loading;
      List<PostArchive> data = _postArchiveStore.postArchives;

      // Styles
      Map<String, dynamic> styles = widget?.widgetConfig?.styles ?? {};
      Map margin = get(styles, ['margin'], {});
      Map padding = get(styles, ['padding'], {});
      Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);

      // Config general
      Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
      bool enableIconArchives = get(fields, ['enableIconArchives'], true);
      bool enableCount = get(fields, ['enableCount'], true);

      double verticalPadding = loading || data.length > 1 ? 16 : 0;
      CrossAxisAlignment crossAxisAlignment =
          loading || data.length > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center;

      return Container(
        margin: ConvertData.space(margin, 'margin'),
        padding: ConvertData.space(padding, 'padding'),
        color: background,
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (enableIconArchives)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 16, top: verticalPadding, bottom: verticalPadding),
                child: CirillaIconOpacity(
                  iconData: FeatherIcons.calendar,
                  radius: 8,
                ),
              ),
            Expanded(
              child: loading ? buildLoading(context) : buildItem(context, data: data, enableCount: enableCount),
            ),
          ],
        ),
      );
    });
  }

  Widget buildLoading(BuildContext context) {
    return Column(
      children: List.generate(
        4,
        (index) => CirillaTile(
          title: Container(
            height: 12,
            width: 120,
            color: Theme.of(context).dividerColor,
          ),
          isChevron: false,
        ),
      ),
    );
  }

  Widget buildItem(
    BuildContext context, {
    List<PostArchive> data,
    bool enableCount,
  }) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: data.map(
        (PostArchive item) {
          return CirillaTile(
            title: RichText(
              text: TextSpan(
                  text: buildDate(item),
                  children: enableCount
                      ? [
                          TextSpan(text: '   '),
                          TextSpan(text: '(${item.posts})', style: theme.textTheme.caption),
                        ]
                      : null,
                  style: theme.textTheme.subtitle2),
            ),
            isChevron: false,
            onTap: () => Navigator.of(context).pushNamed(Routes.posts),
          );
        },
      ).toList(),
    );
  }

  String buildDate(PostArchive item) {
    int year = ConvertData.stringToInt(item?.year ?? DateTime.now().year);
    int month = ConvertData.stringToInt(item?.month ?? DateTime.now().month);
    DateTime date = DateTime(year, month, 1);
    return DateFormat('MMMM y', 'en_US').format(date);
  }
}
