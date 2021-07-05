import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import 'widgets/drawer.dart';
import 'widgets/tab_home.dart';
import 'widgets/tabs.dart';

/// Static screens
Map<String, Widget> widgetOptions = {
  'screens_home': TabHome(),
  "screens_category": ProductCategoryScreen(),
  "screens_wishlist": WishListScreen(),
  "screens_cart": CartScreen(),
  "screens_profile": ProfileScreen(),
};

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  final SettingStore store;
  final Map<String, dynamic> args;

  const HomeScreen({Key key, this.store, this.args}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Utility {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _drawerController = ZoomDrawerController();
  ProductCategoryStore _categoryStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _categoryStore = Provider.of<ProductCategoryStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    // Set transparent status bar on Android
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Observer(
      builder: (_) {
        bool loading = widget.store.loading || widget.store.data == null;
        return Stack(
          children: [
            buildHome(widget.store.data),
            SplashScreen(loading: loading, color: Colors.white),
          ],
        );
      },
    );
  }

  Widget buildHome(DataScreen data) {
    if (data == null) return Container();

    bool isRTL = (Directionality.of(context) == TextDirection.rtl);

    Map<String, Widget> _widgetOptions = {}..addAll(widgetOptions);

    Data tabsData = data.settings['tabs'];
    Data sidebarData = data.settings['sidebar'];
    Data homeData = data.screens['home'];

    // Home Configs
    bool extendBody = get(homeData.configs, ['extendBody'], true);

    // Add custom tabs
    Map<String, Data> extraScreens = data.extraScreens;
    extraScreens.forEach((key, value) {
      _widgetOptions.putIfAbsent("extraScreens_$key", () => CustomScreen(screenKey: key));
    });

    // Drawer
    String layout = sidebarData.widgets['sidebar'].layout;
    Color background = ConvertData.fromRGBA(
      get(sidebarData.widgets['sidebar'].styles, ['background', Provider.of<SettingStore>(context).themeModeKey]),
      Theme.of(context).canvasColor,
    );
    String scaleRotate = 'style2';
    String scaleBottom = 'style5';
    String scaleTop = 'style6';
    double angle = 0.0;
    double heightStyle = 0.0;

    double widthStyle = MediaQuery.of(context).size.width * (isRTL ? 0.65 : 0.83);
    if (scaleRotate == '$layout') {
      angle = -3.0;
    }
    if (scaleBottom == '$layout') {
      heightStyle = MediaQuery.of(context).size.height * (isRTL ? -0.19 : 0.19);
    }
    if (scaleTop == '$layout') {
      heightStyle = -MediaQuery.of(context).size.height * (isRTL ? -0.19 : 0.19);
    }
    String tabActive = widget.store.tab;
    Map<String, dynamic> types = {
      'default': StyleState.overlay,
      'style1': StyleState.scaleRight,
      'style2': StyleState.scaleRight,
      'style3': StyleState.stack,
      'style4': StyleState.fixedStack,
      'style5': StyleState.scaleRight,
      'style6': StyleState.scaleRight,
      'style7': StyleState.rotate3dIn,
      'style8': StyleState.rotate3dOut,
      'style9': StyleState.popUp,
    };

    return ZoomDrawer(
      isRTL: isRTL,
      type: types['$layout'],
      controller: _drawerController,
      slideWidth: widthStyle,
      slideHeight: heightStyle,
      borderRadius: 24.0,
      backgroundColor: background,
      menuScreen: Sidebar(
        data: sidebarData,
        categories: _categoryStore.categories,
      ),
      showShadow: true,
      // shadowColor: Theme.of(context).scaffoldBackgroundColor,
      mainScreen: Scaffold(
        key: _scaffoldKey,
        extendBody: extendBody,
        bottomNavigationBar: Tabs(
          selected: tabActive,
          onItemTapped: widget.store.setTab,
          data: tabsData,
        ),
        body: _widgetOptions[tabActive],
      ),
      angle: angle,
      // openCurve: Curves.fastOutSlowIn,
      // closeCurve: Curves.bounceIn,
    );
  }
}
