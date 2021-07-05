// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgotPasswordStore on _ForgotPasswordStore, Store {
  Computed<bool> _$canForgotPasswordComputed;

  @override
  bool get canForgotPassword => (_$canForgotPasswordComputed ??=
          Computed<bool>(() => super.canForgotPassword, name: '_ForgotPasswordStore.canForgotPassword'))
      .value;

  final _$emailAtom = Atom(name: '_ForgotPasswordStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ForgotPasswordStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$successAtom = Atom(name: '_ForgotPasswordStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$forgotPasswordAsyncAction = AsyncAction('_ForgotPasswordStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword({String identityToken, String userIdentity}) {
    return _$forgotPasswordAsyncAction
        .run(() => super.forgotPassword(identityToken: identityToken, userIdentity: userIdentity));
  }

  final _$_ForgotPasswordStoreActionController = ActionController(name: '_ForgotPasswordStore');

  @override
  void setUserEmail(String value) {
    final _$actionInfo = _$_ForgotPasswordStoreActionController.startAction(name: '_ForgotPasswordStore.setUserEmail');
    try {
      return super.setUserEmail(value);
    } finally {
      _$_ForgotPasswordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_ForgotPasswordStoreActionController.startAction(name: '_ForgotPasswordStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_ForgotPasswordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
loading: ${loading},
success: ${success},
canForgotPassword: ${canForgotPassword}
    ''';
  }
}

mixin _$ForgotPasswordErrorStore on _ForgotPasswordErrorStore, Store {
  Computed<bool> _$hasErrorsInForgotPasswordComputed;

  @override
  bool get hasErrorsInForgotPassword =>
      (_$hasErrorsInForgotPasswordComputed ??= Computed<bool>(() => super.hasErrorsInForgotPassword,
              name: '_ForgotPasswordErrorStore.hasErrorsInForgotPassword'))
          .value;

  final _$emailAtom = Atom(name: '_ForgotPasswordErrorStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
hasErrorsInForgotPassword: ${hasErrorsInForgotPassword}
    ''';
  }
}
