import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';

class ModalState extends StatefulWidget {
  final String value;
  final List states;
  final String valueShip;
  final bool onShip;
  final String code;
  final Function(String value, String stateCodeBill) onChange;
  final Function(String valueShip, String countryCodeShip) onChangeShip;

  ModalState(
      {Key key, this.value, this.states, this.onChange, this.onChangeShip, this.onShip, this.valueShip, this.code})
      : super(key: key);
  _ModalStateState createState() => _ModalStateState();
}

class _ModalStateState extends State<ModalState> {
  final _txtSearch = TextEditingController();
  String search = '';
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text('Select country', style: Theme.of(context).textTheme.subtitle1),
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
          decoration: InputDecoration(
            labelText: 'Search',
          ),
        ),
        Expanded(
            child: ListView(
          children: widget.states
              .where((element) => element['name'].toLowerCase().contains(search.toLowerCase()))
              .toList()
              .map((item) {
            TextStyle titleStyle = theme.textTheme.subtitle2;
            TextStyle activeTitleStyle = titleStyle.copyWith(color: theme.primaryColor);
            return widget.onShip == true
                ? CirillaTile(
                    title: Text(item['name'],
                        style: item['code'] == (widget.valueShip == '' ? widget.code : widget.valueShip)
                            ? activeTitleStyle
                            : titleStyle),
                    trailing: item['code'] == (widget.valueShip == '' ? widget.code : widget.valueShip)
                        ? Icon(FeatherIcons.check, size: 20, color: theme.primaryColor)
                        : null,
                    isChevron: false,
                    onTap: () {
                      widget.onChangeShip(item['name'], item['code']);
                      Navigator.pop(context);
                    },
                  )
                : CirillaTile(
                    title: Text(item['name'],
                        style: item['code'] == (widget.value == '' ? widget.code : widget.value)
                            ? activeTitleStyle
                            : titleStyle),
                    trailing: item['code'] == (widget.value == '' ? widget.code : widget.value)
                        ? Icon(FeatherIcons.check, size: 20, color: theme.primaryColor)
                        : null,
                    isChevron: false,
                    onTap: () {
                      widget.onChange(item['name'], item['code']);
                      Navigator.pop(context);
                    },
                  );
          }).toList(),
        ))
      ],
    );
  }
}
