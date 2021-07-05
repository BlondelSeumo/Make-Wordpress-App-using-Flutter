import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/auth/login_screen.dart';
import 'package:cirilla/screens/auth/register_screen.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  final Data data;
  const Header({
    Key key,
    this.data,
  }) : super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  AuthStore _authStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
  }

  void logout() async {
    await _authStore.logout();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    final sidebarData = widget.data.widgets['sidebar'];
    String alignHeader = get(sidebarData.fields, ['alignHeader'], 'left');
    return Container(
      padding: EdgeInsets.only(bottom: itemPaddingMedium * 3),
      child: Observer(
        builder: (_) => _authStore.isLogin
            ? Column(
                crossAxisAlignment: alignHeader == 'center'
                    ? CrossAxisAlignment.center
                    : alignHeader == 'left'
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(
                      _authStore.user.avatar ?? Assets.noImageUrl,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _authStore.user.displayName ?? '',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    _authStore.user.userEmail ?? '',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 16),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: alignHeader == 'center'
                              ? MainAxisAlignment.center
                              : alignHeader == 'right'
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Icon(
                              FeatherIcons.logOut,
                              color: Theme.of(context).iconTheme.color,
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 8),
                              child: Text(translate('side_bar_logout').toUpperCase(),
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          ],
                        ),
                        onTap: logout,
                      ))
                ],
              )
            : Column(
                crossAxisAlignment: alignHeader == 'center'
                    ? CrossAxisAlignment.center
                    : alignHeader == 'left'
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            Assets.noAvatar,
                          )),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    translate('side_bar_guest'),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    translate('side_bar_guest_info'),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: alignHeader == 'center'
                        ? MainAxisAlignment.center
                        : alignHeader == 'right'
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Icon(
                        FeatherIcons.logIn,
                        color: Theme.of(context).iconTheme.color,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushNamed(LoginScreen.routeName,
                                arguments: {'showMessage': ({String message}) => print('112')}),
                            child: Text(
                              translate('side_bar_login').toUpperCase(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          )),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushNamed(RegisterScreen.routeName,
                                arguments: {'showMessage': ({String message}) => print('112')}),
                            child: Text(
                              translate('side_bar_sign_up').toUpperCase(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
