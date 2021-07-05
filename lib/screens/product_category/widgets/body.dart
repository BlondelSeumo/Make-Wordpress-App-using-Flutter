import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/search/product_search.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

abstract class Body extends StatefulWidget with Utility {
  // List top categories (parent = 0)
  final List<ProductCategory> categories;

  // setting page category list
  final WidgetConfig widgetConfig;

  // Config style category list
  final Map<String, dynamic> configs;

  // Key set language
  final String languageKey;

  // Key set theme darkmode
  final String themeModeKey;

  const Body({
    Key key,
    this.categories,
    this.widgetConfig,
    this.configs = const {},
    this.themeModeKey = 'value',
    this.languageKey = 'text',
  }) : super(key: key);

  Widget buildBody(
    BuildContext context, {
    ProductCategory parent,
    Widget appBar,
    Widget tab,
    Widget banner,
    WidgetConfig widgetConfig,
    String languageKey,
    String themeModeKey,
  });

  Widget buildAppBar(BuildContext context, {Map<String, dynamic> configs});

  // Build Banner
  Widget buildBanner(BuildContext context, {Map<String, dynamic> configs, String languageKey});

  // Builder Layout Tabs
  Widget buildTabs(
    BuildContext context, {
    TabController tabController,
    List<ProductCategory> categories,
    Function onChanged,
    WidgetConfig widgetConfig,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.categories.length);
  }

  void _onChanged(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = widget.buildAppBar(context, configs: widget.configs);
    Widget banner = widget.buildBanner(context, configs: widget.configs);

    Widget tabs = widget.buildTabs(
      context,
      tabController: _tabController,
      categories: widget.categories,
      onChanged: _onChanged,
      widgetConfig: widget.widgetConfig,
    );

    Widget body = widget.buildBody(
      context,
      parent: widget.categories[_index],
      tab: tabs,
      appBar: appBar,
      banner: banner,
      widgetConfig: widget.widgetConfig,
      languageKey: widget.languageKey,
      themeModeKey: widget.themeModeKey,
    );

    return SafeArea(child: body);
  }
}

class SearchProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Search(
      icon: Icon(FeatherIcons.search, size: 16),
      label: Text('Search Products', style: theme.textTheme.bodyText1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 1, color: theme.dividerColor),
      ),
      onTap: () async {
        await showSearch<String>(
          context: context,
          delegate: ProductSearchDelegate(),
        );
      },
    );
  }
}

class BannerWidget extends StatelessWidget {
  final Map<String, dynamic> configs;
  final String languageKey;

  BannerWidget({
    Key key,
    this.configs,
    this.languageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageBanner = ConvertData.imageFromConfigs(get(configs, ['imageBanner'], ''), languageKey);
    double widthBanner = ConvertData.stringToDouble(get(configs, ['widthBanner'], 335));
    double heightBanner = ConvertData.stringToDouble(get(configs, ['heightBanner'], 80));
    double radiusBanner = ConvertData.stringToDouble(get(configs, ['radiusBanner'], 8));

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double widthImage = constraints.maxWidth;
        double heightImage = (widthImage * heightBanner) / widthBanner;
        return ClipRRect(
          borderRadius: BorderRadius.circular(radiusBanner),
          child: ImageLoading(
            imageBanner != '' ? imageBanner : Assets.noImageUrl,
            width: widthImage,
            height: heightImage,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
