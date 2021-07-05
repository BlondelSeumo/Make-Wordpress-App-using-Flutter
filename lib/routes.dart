import 'package:cirilla/screens/profile/order.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/screens/web_view/web_view.dart';
import 'package:cirilla/store/store.dart';
import 'package:flutter/material.dart';

import 'screens/profile/address_shipping.dart';

///
/// Define route
class Routes {
  Routes._();

  static const String posts = '/post_list';

  static const String contact = '/contact';

  static const String account = '/profile/account';
  static const String edit_account = '/profile/edit_account';
  static const String help_info = '/profile/help_info';
  static const String change_password = '/profile/change_password';
  static const String address_billing = '/profile/address_billing';
  static const String address_shipping = '/profile/address_shipping';
  static const String setting = '/profile/setting';
  static const String order = '/profile/order';

  static const String checkout = '/checkout';

  static routes(SettingStore store) => <String, WidgetBuilder>{
        HomeScreen.routeName: (context) => HomeScreen(store: store),

        // Auth
        LoginScreen.routeName: (context) => LoginScreen(store: store),
        RegisterScreen.routeName: (context) => RegisterScreen(store: store),
        ForgotScreen.routeName: (context) => ForgotScreen(),
        LoginMobileScreen.routeName: (context) => LoginMobileScreen(),

        account: (context) => AccountScreen(),
        edit_account: (context) => EditAccountScreen(),
        change_password: (context) => ChangePasswordScreen(),
        address_billing: (context) => AddressBookScreen(),
        address_shipping: (context) => AddressShippingScreen(),
        help_info: (context) => HelpInfoScreen(store: store),
        setting: (context) => SettingScreen(),
        order: (context) => OrderScreen(),
        contact: (context) => ContactScreen(store: store),
        checkout: (context) => Checkout(),
      };

  static onGenerateRoute(dynamic settings, SettingStore store) {
    final Map args = settings.arguments;

    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case PostScreen.routeName:
            return PostScreen(store: store, args: args);
            break;
          case PostListScreen.routeName:
            return PostListScreen(store: store, args: args);
            break;
          case ProductListScreen.routeName:
            return ProductListScreen(store: store, args: args);
            break;
          case ProductScreen.routeName:
            return ProductScreen(store: store, args: args);
            break;
          case WebViewScreen.routeName:
            return WebViewScreen(args: args);
            break;
          case PageScreen.routeName:
            return PageScreen(args: args);
            break;
          case CustomScreen.routeName:
            return CustomScreen(screenKey: args['key']);
          default:
            return NotFound();
        }
      },
    );
  }
}
