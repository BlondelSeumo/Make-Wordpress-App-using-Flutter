import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:cirilla/routes.dart';

class AccountScreen extends StatelessWidget with AppBarMixin {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('edit_account_your_account'), style: theme.textTheme.subtitle1),
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CirillaTile(
              title: Text(translate('edit_account'), style: theme.textTheme.subtitle2),
              onTap: () => Navigator.of(context).pushNamed(Routes.edit_account),
            ),
            CirillaTile(
              title: Text(translate('change_phone'), style: theme.textTheme.subtitle2),
              onTap: () {},
            ),
            CirillaTile(
              title: Text(translate('change_password'), style: theme.textTheme.subtitle2),
              onTap: () => Navigator.of(context).pushNamed(Routes.change_password),
            ),
            CirillaTile(
              title: Text(translate('address_billing'), style: theme.textTheme.subtitle2),
              onTap: () => Navigator.of(context).pushNamed(Routes.address_billing),
            ),
            CirillaTile(
              title: Text(translate('address_shipping'), style: theme.textTheme.subtitle2),
              onTap: () => Navigator.of(context).pushNamed(Routes.address_shipping),
            ),
          ],
        ),
      ),
    );
  }
}
