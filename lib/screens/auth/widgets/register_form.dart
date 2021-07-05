import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_phone_input/phone_number.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final HandleLoginType handleRegister;
  final bool enableRegisterPhoneNumber;
  final String term;

  const RegisterForm({
    Key key,
    this.handleRegister,
    this.enableRegisterPhoneNumber = true,
    this.term,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with SnackMixin {
  final _formKey = GlobalKey<FormState>();
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtUsername = TextEditingController();
  final _txtEmail = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtPhone = TextEditingController();
  bool _obscureText = true;
  FocusNode _lastNameFocusNode;
  FocusNode _usernameFocusNode;
  FocusNode _phoneFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  PhoneNumber _phoneNumber;
  bool _agree = true;

  @override
  void initState() {
    super.initState();
    _lastNameFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // dispose controller input
    _txtFirstName.dispose();
    _txtLastName.dispose();
    _txtUsername.dispose();
    _txtEmail.dispose();
    _txtPassword.dispose();
    _txtPhone.dispose();

    // dispose focus input
    _lastNameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _updateObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstName(translate),
          SizedBox(height: 16),
          buildLastName(translate),
          SizedBox(height: 16),
          buildUsername(translate),
          SizedBox(height: 16),
          if (widget.enableRegisterPhoneNumber) buildPhone(translate),
          SizedBox(height: 16),
          buildEmail(translate),
          SizedBox(height: 16),
          buildPasswordField(translate),
          SizedBox(height: 8),
          Container(
            child: CirillaHtml(
              html: widget.term,
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!_agree) {
                  showError(context, translate('agree_term'));
                  return;
                }
                if (_formKey.currentState.validate()) {
                  widget.enableRegisterPhoneNumber == true
                      ? widget.handleRegister({
                          'first_name': _txtFirstName.text,
                          'last_name': _txtLastName.text,
                          'user_login': _txtUsername.text,
                          'phone':
                              _phoneNumber.number.startsWith('+') ? _phoneNumber.number : _phoneNumber.completeNumber,
                          'country_iso_code': _phoneNumber.countryISOCode,
                          'country_code': _phoneNumber.countryCode,
                          'email': _txtEmail.text,
                          'password': _txtPassword.text,
                          'enable_phone_number': widget.enableRegisterPhoneNumber,
                          'agree_privacy_term': _agree,
                        })
                      : widget.handleRegister({
                          'first_name': _txtFirstName.text,
                          'last_name': _txtLastName.text,
                          'user_login': _txtUsername.text,
                          'email': _txtEmail.text,
                          'password': _txtPassword.text,
                          'agree_privacy_term': _agree,
                        });
                }
              },
              child: Text(translate('register_btn_submit')),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFirstName(TranslateType translate) {
    return TextFormField(
      controller: _txtFirstName,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_first_name_required');
        }
        if (RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
          return translate('validate_without_special_characters');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('input_first_name_required'),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
      },
    );
  }

  Widget buildLastName(TranslateType translate) {
    return TextFormField(
      controller: _txtLastName,
      focusNode: _lastNameFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_last_name_required');
        }
        if (RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
          return translate('validate_without_special_characters');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('input_last_name_required'),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_usernameFocusNode);
      },
    );
  }

  Widget buildUsername(TranslateType translate) {
    return TextFormField(
      controller: _txtUsername,
      focusNode: _usernameFocusNode,
      validator: (value) {
        if (!RegExp(r'^.{8,}$').hasMatch(value)) {
          return translate('validate_characters_in_length');
        }
        if (RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
          return translate('validate_without_special_characters');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('input_username_required'),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_phoneFocusNode);
      },
    );
  }

  Widget buildPhone(TranslateType translate) {
    return CirillaPhoneInput(
      controller: _txtPhone,
      focusNode: _phoneFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_phone_number_required');
        }
        return null;
      },
      onChanged: (phone) {
        setState(() {
          _phoneNumber = phone;
        });
      },
      autoValidate: false,
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        FocusScope.of(context).requestFocus(_phoneFocusNode);
      },
    );
  }

  Widget buildEmail(TranslateType translate) {
    return TextFormField(
      controller: _txtEmail,
      focusNode: _emailFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_email_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('input_email_required'),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget buildPasswordField(TranslateType translate) {
    return TextFormField(
      controller: _txtPassword,
      validator: (value) {
        if (!RegExp(r'^.{8,}$').hasMatch(value)) {
          return translate('validate_characters_in_length');
        }
        if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
          return translate('validate_one_upper_case');
        }
        if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
          return translate('validate_one_lower_case');
        }
        if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
          return translate('validate_one_digit');
        }
        if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
          return translate('validate_one_special_character');
        }
        return null;
      },
      focusNode: _passwordFocusNode,
      obscureText: _obscureText, // Error when login then login again if enable
      decoration: InputDecoration(
        labelText: translate('input_password_required'),
        suffixIcon: IconButton(
          iconSize: 16,
          icon: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: _updateObscure,
        ),
      ),
    );
  }

  Widget buildAgreeTerm(TranslateType translate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Accept the [Terms and Conditions]'),
        Switch(
          value: _agree,
          onChanged: (value) {
            setState(() {
              _agree = value;
            });
          },
        )
      ],
    );
  }
}
