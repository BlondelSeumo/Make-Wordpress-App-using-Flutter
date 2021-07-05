import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'widgets/profile_content_login.dart';
import 'widgets/profile_content_logout.dart';
import 'widgets/profile_footer.dart';

const enableLogin = false;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Utility {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  SettingStore _settingStore;
  AuthStore _authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingStore = Provider.of<SettingStore>(context);
    _authStore = Provider.of<AuthStore>(context);
  }

  void logout() async {
    bool isLogout = await _authStore.logout();
    print(isLogout);
  }

  void showMessage({String message}) {
    scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.green,
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 40,
        child: Center(child: Text(message)),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String title = enableLogin ? 'Account' : 'Profile';
    String language = _settingStore.locale ?? 'en';

    WidgetConfig widgetConfig = _settingStore.data.screens['profile'].widgets['profilePage'];
    Map<String, dynamic> fields = widgetConfig.fields;

    String textCopyRight = ConvertData.stringFromConfigs(get(fields, ['textCopyRight'], '© Cirrilla 2020'), language);
    String phone = ConvertData.stringFromConfigs(get(fields, ['phone'], '0123456789'), language);
    List socials = get(fields, ['itemSocial'], []);

    // Padding
    Map<String, dynamic> _padding = get(widgetConfig.styles, ['padding']);
    EdgeInsetsDirectional padding = _padding != null ? ConvertData.space(_padding, 'padding') : defaultScreenPadding;

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: theme.textTheme.subtitle1),
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: padding,
          child: SizedBox(
              width: double.infinity,
              child: Observer(
                builder: (_) => _authStore.isLogin
                    ? ProfileContentLogin(
                        logout: logout,
                        user: _authStore.user,
                        phone: phone,
                        footer: ProfileFooter(
                          copyright: textCopyRight,
                          socials: socials,
                          lang: language,
                        ),
                      )
                    : ProfileContentLogout(
                        showMessage: showMessage,
                        phone: phone,
                        footer: ProfileFooter(
                          copyright: textCopyRight,
                          socials: socials,
                          lang: language,
                        ),
                      ),
              )),
        ),
      ),
    );
  }
}
