import 'package:cirilla/mixins/mixins.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> with AppBarMixin {
  final _formKey = GlobalKey<FormState>();
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtDisplayName = TextEditingController();
  final _txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('edit_acount'), style: theme.textTheme.subtitle1),
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: renderForm(
          child: Column(
            children: [
              SizedBox(height: 12),
              renderFirstName(
                  labelText: translate('edit_account_first_name'),
                  validatorTitle: translate('edit_account_first_name_required')),
              SizedBox(height: 16),
              renderLastName(
                  labelText: translate('edit_account_last_name'),
                  validatorTitle: translate('edit_account_last_name_required')),
              SizedBox(height: 16),
              renderDisplayName(
                  labelText: translate('edit_account_display_name'),
                  validatorTitle: translate('edit_account_display_name_required')),
              SizedBox(height: 16),
              renderEmail(
                  labelText: translate('edit_account_email_address'),
                  validatorTitle: translate('edit_account_email_required')),
              SizedBox(height: 24),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    translate('edit_account_save'),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    textStyle: theme.textTheme.subtitle2,
                  ),
                ),
              )
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

  Widget renderFirstName({String labelText, String validatorTitle}) {
    return TextFormField(
      controller: _txtFirstName,
      validator: (value) {
        if (value.isEmpty) {
          return validatorTitle;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderLastName({String labelText, String validatorTitle}) {
    return TextFormField(
      controller: _txtLastName,
      validator: (value) {
        if (value.isEmpty) {
          return validatorTitle;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderDisplayName({String labelText, String validatorTitle}) {
    return TextFormField(
      controller: _txtDisplayName,
      validator: (value) {
        if (value.isEmpty) {
          return validatorTitle;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget renderEmail({String labelText, String validatorTitle}) {
    return TextFormField(
      controller: _txtEmail,
      validator: (value) {
        if (value.isEmpty) {
          return validatorTitle;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
