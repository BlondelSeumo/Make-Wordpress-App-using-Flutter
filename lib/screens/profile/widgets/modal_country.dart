import 'package:cirilla/store/auth/country_store.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';

class ModalCountries extends StatefulWidget {
  final AddressStore countriesStore;
  final String value;
  final String valueShip;
  final bool onShip;
  final List states;
  final String code;
  final Function(String value, String countryCode, List states) onChange;
  final Function(String valueShip, String countryCodeShip, List states) onChangeShip;

  ModalCountries(
      {Key key,
      this.countriesStore,
      this.value,
      this.states,
      this.onChange,
      this.onChangeShip,
      this.code,
      this.valueShip,
      this.onShip})
      : super(key: key);
  _ModalCountriesState createState() => _ModalCountriesState();
}

class _ModalCountriesState extends State<ModalCountries> {
  final _txtSearch = TextEditingController();
  String search = '';
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text('Select country', style: Theme.of(context).textTheme.subtitle1),
        SizedBox(
          height: 42,
        ),
        TextFormField(
          controller: _txtSearch,
          validator: (value) {
            if (value.isEmpty) {
              return 'null';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(labelText: 'Search', labelStyle: Theme.of(context).textTheme.bodyText2),
        ),
        Expanded(
            child: ListView(
          children: widget.countriesStore.country
              .where((element) => element.name.toLowerCase().contains(search.toLowerCase()))
              .toList()
              .map((item) {
            TextStyle titleStyle = theme.textTheme.subtitle2;
            TextStyle activeTitleStyle = titleStyle.copyWith(color: theme.primaryColor);
            return widget.onShip == true
                ? CirillaTile(
                    title: Text(item.name,
                        style: item.code == (widget.valueShip == '' ? widget.code : widget.valueShip)
                            ? activeTitleStyle
                            : titleStyle),
                    trailing: item.code == (widget.valueShip == '' ? widget.code : widget.valueShip)
                        ? Icon(FeatherIcons.check, size: 20, color: theme.primaryColor)
                        : null,
                    isChevron: false,
                    onTap: () {
                      if (item.code != (widget.valueShip == '' ? widget.code : widget.valueShip)) {
                        widget.onChangeShip(item.name, item.code, item.states);
                      }

                      Navigator.pop(context);
                    },
                  )
                : CirillaTile(
                    title: Text(item.name,
                        style: item.code == (widget.value == '' ? widget.code : widget.value)
                            ? activeTitleStyle
                            : titleStyle),
                    trailing: item.code == (widget.value == '' ? widget.code : widget.value)
                        ? Icon(FeatherIcons.check, size: 20, color: theme.primaryColor)
                        : null,
                    isChevron: false,
                    onTap: () {
                      if (item.code != (widget.value == '' ? widget.code : widget.value)) {
                        widget.onChange(item.name, item.code, item.states);
                      }
                      Navigator.pop(context);
                    },
                  );
          }).toList(),
        ))
      ],
    );
  }
}
