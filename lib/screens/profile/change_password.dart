import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/mixins/snack_mixin.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cirilla/utils/app_localization.dart';

class ChangePasswordScreen extends StatefulWidget {
  final HandleLoginType handleLogin;

  const ChangePasswordScreen({Key key, this.handleLogin}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with SnackMixin, AppBarMixin {
  final _formKey = GlobalKey<FormState>();
  final _txtPassword = TextEditingController();
  final _txtNewPassword = TextEditingController();
  final _txtConfirmPassword = TextEditingController();

  bool obscureTextPassword = true;
  bool obscureTextNewPassword = true;
  bool obscureTextConfirmPassword = true;

  AuthStore _authStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
  }

  void submit() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    if (_txtNewPassword.text == _txtPassword.text) {
      showError(context, "Old Password and new password cannot be same.");
    } else if (_txtNewPassword.text != _txtConfirmPassword.text) {
      showError(context, "New passwords do not match.");
    } else {
      try {
        final res = await _authStore.changePasswordStore.changePassword(
          _txtPassword.text,
          _txtNewPassword.text,
        );
        if (res.toString() == _authStore.user.id.toString()) {
          showSuccess(context, "change password successfully.");
        }
      } catch (e) {
        print(e);
        showError(context, "Your current password is incorrect.");
      }
    }
    _formKey.currentState.save();
  }

  void updateObscure(String type) {
    setState(() {
      switch (type) {
        case 'confirm_password':
          obscureTextConfirmPassword = !obscureTextConfirmPassword;
          return;
          break;
        case 'new_password':
          obscureTextNewPassword = !obscureTextNewPassword;
          return;
          break;
        default:
          obscureTextPassword = !obscureTextPassword;
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('change_password'), style: theme.textTheme.subtitle1),
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
              renderPassword(
                  labelText: translate('change_password_old'),
                  validatorTitle: translate('change_password_old_required')),
              SizedBox(height: 16),
              renderNewPassword(),
              SizedBox(height: 16),
              renderConfirm(
                  labelText: translate('change_password_confirm'),
                  validatorTitle: translate('change_password_confirm_required')),
              SizedBox(height: 24),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    translate('change_password_save'),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      submit();
                    }
                  },
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

  Widget renderPassword({String labelText, String validatorTitle}) {
    return TextFormField(
      controller: _txtPassword,
      validator: (value) {
        if (value.isEmpty) {
          return validatorTitle;
        }
        return null;
      },
      obscureText: obscureTextPassword,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          iconSize: 16,
          icon: Icon(obscureTextPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => updateObscure('password'),
        ),
      ),
    );
  }

  Widget renderNewPassword() {
    TranslateType translate = AppLocalizations.of(context).translate;
    return TextFormField(
      controller: _txtNewPassword,
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
      obscureText: obscureTextNewPassword,
      decoration: InputDecoration(
        labelText: translate('change_password_new'),
        suffixIcon: IconButton(
          iconSize: 16,
          icon: Icon(obscureTextNewPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => updateObscure('new_password'),
        ),
      ),
    );
  }

  Widget renderConfirm({String labelText, String validatorTitle}) {
    return TextFormField(
      controller: _txtConfirmPassword,
      validator: (value) {
        if (value.isEmpty) {
          return validatorTitle;
        }
        return null;
      },
      obscureText: obscureTextConfirmPassword,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          iconSize: 16,
          icon: Icon(obscureTextConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => updateObscure('confirm_password'),
        ),
      ),
    );
  }
}
