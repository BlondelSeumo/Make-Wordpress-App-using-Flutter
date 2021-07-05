import 'package:cirilla/mixins/navigation_mixin.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/notification/notification_screen.dart';

class OrderReceived extends StatefulWidget {
  @override
  _OrderReceivedState createState() => _OrderReceivedState();
}

class _OrderReceivedState extends State<OrderReceived> with NavigationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Info'),
      ),
      body: buildCartEmpty(context),
    );
  }

  Widget buildCartEmpty(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Container(
      child: NotificationScreen(
        title: Text('Congrats !', style: Theme.of(context).textTheme.headline6),
        content: Text(
          'Thank you purchase. Your order will be shipping to you.',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        iconData: FeatherIcons.check,
        textButton: Text(translate('cart_shopping_now')),
        onPressed: () => navigate(context, {
          "type": "tab",
          "router": "/",
          "args": {"key": "screens_category"}
        }),
      ),
    );
  }
}
