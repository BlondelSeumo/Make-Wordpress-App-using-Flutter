import 'package:cirilla/models/auth/user.dart';
import 'package:cirilla/routes.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'profile_content.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';

class ProfileContentLogin extends ProfileContent {
  final User user;
  final Function logout;

  ProfileContentLogin({Key key, String phone, Widget footer, this.user, this.logout})
      : super(
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
        UserContainedItem(
          image: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              user.socialAvatar ?? user.avatar,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(user.displayName ?? "Welcome",
              style: theme.textTheme.subtitle2, maxLines: 1, overflow: TextOverflow.ellipsis),
          leading: Text('Welcome', style: theme.textTheme.caption),
          elevation: 1,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          onClick: () => Navigator.of(context).pushNamed(Routes.account),
        ),
        SizedBox(height: 40),
        buildInfo(
          context,
          title: translate('information'),
          child: Column(
            children: [
              CirillaTile(
                title: Text(translate('edit_account_my_account'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.user,
                  size: 16,
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.account),
              ),
              CirillaTile(
                title: Text(translate('order_return'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.package,
                  size: 16,
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.order),
              ),
              CirillaTile(
                title: Text(translate('chat'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.messageCircle,
                  size: 16,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 28),
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
              CirillaTile(
                title: Text(translate('sign_out'), style: theme.textTheme.subtitle2),
                leading: Icon(
                  FeatherIcons.logOut,
                  size: 16,
                ),
                onTap: logout,
                isChevron: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
