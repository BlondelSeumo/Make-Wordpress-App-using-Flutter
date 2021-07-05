// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool> _$isLoginComputed;

  @override
  bool get isLogin => (_$isLoginComputed ??= Computed<bool>(() => super.isLogin, name: '_AuthStore.isLogin')).value;
  Computed<User> _$userComputed;

  @override
  User get user => (_$userComputed ??= Computed<User>(() => super.user, name: '_AuthStore.user')).value;

  final _$_isLoginAtom = Atom(name: '_AuthStore._isLogin');

  @override
  bool get _isLogin {
    _$_isLoginAtom.reportRead();
    return super._isLogin;
  }

  @override
  set _isLogin(bool value) {
    _$_isLoginAtom.reportWrite(value, super._isLogin, () {
      super._isLogin = value;
    });
  }

  final _$_tokenAtom = Atom(name: '_AuthStore._token');

  @override
  String get _token {
    _$_tokenAtom.reportRead();
    return super._token;
  }

  @override
  set _token(String value) {
    _$_tokenAtom.reportWrite(value, super._token, () {
      super._token = value;
    });
  }

  final _$_userAtom = Atom(name: '_AuthStore._user');

  @override
  User get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  final _$setTokenAsyncAction = AsyncAction('_AuthStore.setToken');

  @override
  Future<void> setToken(String value) {
    return _$setTokenAsyncAction.run(() => super.setToken(value));
  }

  final _$loginSuccessAsyncAction = AsyncAction('_AuthStore.loginSuccess');

  @override
  Future<void> loginSuccess(Map<String, dynamic> data) {
    return _$loginSuccessAsyncAction.run(() => super.loginSuccess(data));
  }

  final _$logoutAsyncAction = AsyncAction('_AuthStore.logout');

  @override
  Future<bool> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void setLogin(bool value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(name: '_AuthStore.setLogin');
    try {
      return super.setLogin(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUser(dynamic value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(name: '_AuthStore.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
user: ${user}
    ''';
  }
}
