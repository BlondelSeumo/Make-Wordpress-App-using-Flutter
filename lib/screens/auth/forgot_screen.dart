import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  static const routeName = '/forgot';

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  void onSubmit({String email}) {
    print('Email: $email ');
  }

  @override
  Widget build(BuildContext context) {
    return ForgotPassword(
      onSubmit: onSubmit,
    );
  }
}

class ForgotPassword extends StatelessWidget with AppBarMixin {
  final _formKey = GlobalKey<FormState>();
  final _txtEmail = TextEditingController();

  final Function onSubmit;

  ForgotPassword({
    Key key,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    TranslateType translate = AppLocalizations.of(context).translate;

    return Scaffold(
      appBar: baseStyleAppBar(context, title: translate('forgot_password_appbar')),
      body: SafeArea(
        child: renderForm(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        translate('forgot_password_description'),
                        style: textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      renderPhoneNumberField(translate),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              String email = _txtEmail.text;
                              onSubmit(email: email);
                            }
                          },
                          child: Text(translate('forgot_password_btn')),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderForm({Widget child}) {
    return Form(
      key: _formKey,
      child: child,
    );
  }

  Widget renderPhoneNumberField(TranslateType translate) {
    return TextFormField(
      controller: _txtEmail,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_email_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('input_email'),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
