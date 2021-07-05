import 'package:cirilla/routes.dart';
import 'package:cirilla/screens/auth/login_screen.dart';
import 'package:cirilla/screens/auth/register_screen.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import 'profile_content.dart';

class ProfileContentLogout extends ProfileContent {
  final ShowMessageType showMessage;

  ProfileContentLogout({
    Key key,
    String phone,
    Widget footer,
    this.showMessage,
  }) : super(
          key: key,
          phone: phone,
          footer: footer,
        );

  @override
  Widget buildLayout(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Column(
      children: [
        Text(
          translate('login_sign_in_to_receive'),
          style: theme.textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  child: Text(
                    translate('login_btn_create_account'),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  child: Text(
                    translate('login_btn_login'),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName, arguments: {'showMessage': showMessage}),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: theme.textTheme.subtitle2,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        buildInfo(
          context,
          title: translate('settings'),
          child: Column(
            children: [
              CirillaTile(
                title: Text(translate('app_settings'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.settings,
                  size: 16,
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.setting),
              ),
              CirillaTile(
                title: Text(translate('help_info'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.info,
                  size: 16,
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.help_info),
              ),
              CirillaTile(
                title: Text(translate('hotline'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.phoneForwarded,
                  size: 16,
                ),
                trailing: Text(phone, style: theme.textTheme.bodyText1),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
