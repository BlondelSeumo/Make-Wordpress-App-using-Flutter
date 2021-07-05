import 'package:cirilla/store/auth/country_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  final TextEditingController txtFirstName;
  final TextEditingController txtLastName;
  final TextEditingController txtCompany;
  final TextEditingController txtAddress1;
  final TextEditingController txtAddress2;
  final TextEditingController txtCity;
  final TextEditingController txtState;
  final TextEditingController txtPostCode;
  final TextEditingController txtEmail;
  final TextEditingController txtPhone;
  final List<Map<String, dynamic>> states;
  final Map billData;
  final String billCountry;
  final String billState;
  final AddressStore addressData;
  final Function onTap;
  final Function onState;
  final Function onSave;
  final bool onEmailPhone;
  AddressScreen(
      {Key key,
      this.states,
      this.billData,
      this.billCountry,
      this.billState,
      this.addressData,
      this.onTap,
      this.onState,
      this.onSave,
      this.txtFirstName,
      this.txtLastName,
      this.txtCompany,
      this.txtAddress1,
      this.txtAddress2,
      this.txtCity,
      this.txtState,
      this.txtPostCode,
      this.txtEmail,
      this.txtPhone,
      this.onEmailPhone})
      : super(key: key);
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    widget.onSave();
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    widget.txtFirstName.text = widget.billData['first_name'];
    widget.txtLastName.text = widget.billData['last_name'];
    widget.txtCompany.text = widget.billData['company'];
    widget.txtAddress1.text = widget.billData['address_1'];
    widget.txtAddress2.text = widget.billData['address_2'];
    widget.txtCity.text = widget.billData['city'];
    widget.txtPostCode.text = widget.billData['postcode'];
    if (widget.onEmailPhone == true) {
      widget.txtEmail.text = widget.billData['email'] ?? '';
      widget.txtPhone.text = widget.billData['phone'] ?? '';
    }

    return renderForm(
      child: ListView(
        padding: EdgeInsetsDirectional.only(end: 20, start: 20, bottom: 48),
        children: [
          SizedBox(height: 12),
          renderFirstName(labelText: translate('address_first_name')),
          SizedBox(height: 16),
          renderLastName(labelText: translate('address_last_name')),
          SizedBox(height: 16),
          renderCompany(labelText: translate('address_company')),
          SizedBox(height: 16),
          renderCountry(billCountry: widget.billCountry, onTap: () => widget.onTap()),
          SizedBox(height: 16),
          renderAddress1(labelText: translate('address_1')),
          SizedBox(height: 16),
          renderAddress2(labelText: translate('address_2')),
          SizedBox(height: 16),
          renderCity(labelText: translate('address_city')),
          SizedBox(height: 16),
          renderState(states: widget.states, billState: widget.billState, onState: () => widget.onState()),
          SizedBox(height: 16),
          renderPostCode(labelText: translate('address_post_code')),
          SizedBox(height: 16),
          if (widget.onEmailPhone == true) renderEmail(labelText: translate('address_email')),
          SizedBox(height: 16),
          if (widget.onEmailPhone == true) renderPhone(labelText: translate('address_phone')),
          SizedBox(height: 16),
          Text(
            translate('address_note'),
            style: theme.textTheme.caption,
          ),
          SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _submit(),
              child: Text(translate('address_save')),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderForm({Widget child}) {
    return Form(
      key: _formKey,
      child: child,
    );
  }

  Widget renderFirstName({String labelText}) {
    return TextFormField(
      controller: widget.txtFirstName,
      onFieldSubmitted: (value) {
        print('a');
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderLastName({String labelText}) {
    return TextFormField(
      controller: widget.txtLastName,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderCompany({String labelText}) {
    return TextFormField(
      controller: widget.txtCompany,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderCountry({Function onTap, String billCountry}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CirillaTile(
        title: Text(billCountry),
        height: 48,
        trailing: Icon(FeatherIcons.chevronDown, size: 16),
        onTap: () => onTap(),
        isDivider: false,
        isChevron: false,
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget renderAddress1({String labelText}) {
    return TextFormField(
      controller: widget.txtAddress1,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderAddress2({String labelText}) {
    return TextFormField(
      controller: widget.txtAddress2,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderCity({String labelText}) {
    return TextFormField(
      controller: widget.txtCity,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderState({Function onState, List<Map<String, dynamic>> states, String billState}) {
    if (states.isEmpty != true)
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CirillaTile(
          title: Text(billState),
          height: 48,
          trailing: Icon(FeatherIcons.chevronDown, size: 16),
          onTap: () => onState(),
          isDivider: false,
          isChevron: false,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      );
    return Container();
  }

  Widget renderPostCode({String labelText}) {
    return TextFormField(
      controller: widget.txtPostCode,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderEmail({String labelText}) {
    return TextFormField(
      controller: widget.txtEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return 'Enter a valid email!';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderPhone({String labelText}) {
    return TextFormField(
      controller: widget.txtPhone,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.isEmpty) {
          return 'null';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
