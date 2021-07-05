import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/screens/home/home.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import 'utility_mixin.dart' show get;

class NavigationMixin {
  void navigate(BuildContext context, Map<String, dynamic> action) {
    String type = get(action, ['type'], 'tab');

    if (type == 'none') return;

    String route = get(action, ['route'], '/');
    Map<String, dynamic> args = get(action, ['args'], {});
    print(action);
    if (type == 'tab') {
      String tab = get(action, ['args', 'key'], Strings.tabActive);
      SettingStore store = Provider.of<SettingStore>(context, listen: false);
      store.setTab(tab);
      Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
      if (ZoomDrawer.of(context) != null && ZoomDrawer.of(context).isOpen()) {
        ZoomDrawer.of(context).toggle();
      }
    } else if (type == 'none') {
    } else {
      Navigator.of(context).pushNamed(route, arguments: args);
    }
  }
}
