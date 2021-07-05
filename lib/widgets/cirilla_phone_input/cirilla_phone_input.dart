import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'countries.dart';
import 'phone_number.dart';

enum CirillaPhoneInputType { enable, disable, error }

class CirillaPhoneInput extends StatefulWidget {
  final String initialCountryCode;
  final String initialValue;
  final TextInputType keyboardType;
  final bool autoValidate;
  final FormFieldValidator<String> validator;
  final bool enabled;
  final bool autofocus;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<PhoneNumber> onChanged;
  final FormFieldSetter<PhoneNumber> onSaved;
  final void Function(PhoneNumber) onSubmitted;
  final String searchText;

  CirillaPhoneInput({
    Key key,
    this.initialCountryCode = 'US',
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.autoValidate = true,
    this.validator,
    this.enabled = true,
    this.autofocus = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
    this.searchText = 'Search country\'s name',
  }) : super(key: key);

  @override
  _CirillaPhoneInputState createState() => _CirillaPhoneInputState();
}

class _CirillaPhoneInputState extends State<CirillaPhoneInput> {
  GlobalKey _keyContainer = GlobalKey();
  double widthContainer = 80;

  Map<String, String> _selectedCountry = countries.firstWhere((item) => item['code'] == 'US');
  List<Map<String, String>> filteredCountries = countries;
  FormFieldValidator<String> validator;
  FocusNode _focusNode;

  CirillaPhoneInputType type = CirillaPhoneInputType.enable;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);
    if (widget.initialCountryCode != null) {
      _selectedCountry = countries.firstWhere((item) => item['code'] == widget.initialCountryCode);
    }
    validator = widget.autoValidate ? (value) => value.length != 10 ? 'Invalid Mobile Number' : null : widget.validator;
    if (!widget.enabled) {
      type = CirillaPhoneInputType.disable;
    }
    _focusNode = widget.focusNode is FocusNode ? widget.focusNode : FocusNode();
    super.initState();
  }

  _getSizes(_) {
    final RenderBox renderBoxContainer = _keyContainer.currentContext.findRenderObject();
    final size = renderBoxContainer.size;
    setState(() {
      widthContainer = size.width + 16;
    });
  }

  Color colorLine(ThemeData theme) {
    if (_focusNode.hasFocus && (type != CirillaPhoneInputType.error && type != CirillaPhoneInputType.disable)) {
      return theme.primaryColor;
    }
    switch (type) {
      case CirillaPhoneInputType.disable:
        return theme.disabledColor.withOpacity(0.2);
        break;
      case CirillaPhoneInputType.error:
        return theme.errorColor;
        break;
      default:
        return theme.dividerColor;
    }
  }

  void onFieldSubmitted(String value) {
    CirillaPhoneInputType newType = !widget.enabled
        ? CirillaPhoneInputType.disable
        : type == CirillaPhoneInputType.error
            ? CirillaPhoneInputType.error
            : CirillaPhoneInputType.enable;
    setState(() {
      type = newType;
    });
    if (widget.onSubmitted != null) {
      PhoneNumber data = PhoneNumber(
        countryISOCode: _selectedCountry['code'],
        countryCode: _selectedCountry['dial_code'],
        number: value,
      );
      widget.onSubmitted(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color colorBorderCountry = colorLine(theme);
    double widthLine = _focusNode.hasFocus ? 2 : 1;
    return Stack(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: _selectedCountry['dial_code'],
            prefixIcon: Container(
              width: widthContainer,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
          ),
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          controller: widget.controller,
          focusNode: _focusNode,
          onTap: () {
            FocusScope.of(context).requestFocus(_focusNode);
          },
          validator: (String value) {
            String resultValidator = validator(value);
            setState(() {
              type = resultValidator != null ? CirillaPhoneInputType.error : CirillaPhoneInputType.enable;
            });
            return resultValidator;
          },
          onFieldSubmitted: onFieldSubmitted,
          onSaved: (value) {
            if (widget.onSaved != null)
              widget.onSaved(
                PhoneNumber(
                  countryISOCode: _selectedCountry['code'],
                  countryCode: _selectedCountry['dial_code'],
                  number: value,
                ),
              );
          },
          onChanged: (value) {
            if (value.startsWith("+") && value.length > 2 && value.length < 5) {
              setState(() {
                _selectedCountry =
                    countries.firstWhere((item) => item['dial_code'].startsWith(value), orElse: () => _selectedCountry);
              });
            }

            if (widget.onChanged != null)
              widget.onChanged(
                PhoneNumber(
                  countryISOCode: _selectedCountry['code'],
                  countryCode: _selectedCountry['dial_code'],
                  number: value,
                ),
              );
          },
          textInputAction: widget.textInputAction,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: InkWell(
            onTap: () => _changeCountry(),
            child: Container(
              key: _keyContainer,
              height: 48,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16, right: 8),
              decoration: BoxDecoration(border: Border(right: BorderSide(width: widthLine, color: colorBorderCountry))),
              child: Row(
                children: [
                  Text(
                    _selectedCountry['flag'],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    FeatherIcons.chevronDown,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _changeCountry() async {
    filteredCountries = countries;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (ctx, setState) => Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: widget.searchText,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredCountries = countries
                            .where((country) => country['name'].toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredCountries.length,
                      itemBuilder: (ctx, index) => Column(
                        children: <Widget>[
                          ListTile(
                            leading: Text(
                              filteredCountries[index]['flag'],
                              style: TextStyle(fontSize: 30),
                            ),
                            title: Text(
                              filteredCountries[index]['name'],
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              filteredCountries[index]['dial_code'],
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              _selectedCountry = filteredCountries[index];
                              Navigator.of(context).pop();
                            },
                          ),
                          Divider(thickness: 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    setState(() {});
  }
}
