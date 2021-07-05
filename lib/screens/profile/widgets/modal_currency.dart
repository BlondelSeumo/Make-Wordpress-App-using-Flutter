import 'package:cirilla/models/currency/currency.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';

class ModalCurrency extends StatelessWidget {
  final List<Currency> currencies;
  final String value;
  final Function(String value) onChange;

  ModalCurrency({
    Key key,
    this.currencies,
    this.value,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: currencies.map((item) {
        TextStyle titleStyle = theme.textTheme.subtitle2;
        TextStyle activeTitleStyle = titleStyle.copyWith(color: theme.primaryColor);

        return CirillaTile(
          title: Text(item.name, style: item.code == value ? activeTitleStyle : titleStyle),
          trailing: item.code == value ? Icon(FeatherIcons.check, size: 20, color: theme.primaryColor) : null,
          isChevron: false,
          onTap: () {
            onChange(item.code);
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }
}
