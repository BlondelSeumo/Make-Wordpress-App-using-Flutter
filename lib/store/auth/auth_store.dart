import 'package:cirilla/models/auth/user.dart';
import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/auth/country_store.dart';
import 'package:cirilla/store/wishlist/wishlist_store.dart';
import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:cirilla/constants/app.dart' show googleClientId;
import 'package:cirilla/constants/constants.dart' show isWeb;
import 'dart:io' show Platform;

import 'change_password_store.dart';
import 'forgot_password_store.dart';
import 'login_store.dart';
import 'register_store.dart';

part 'auth_store.g.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: isWeb || Platform.isAndroid ? googleClientId : null,
  scopes: <String>[
    'email',
    'profile',
  ],
);

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final PersistHelper _persistHelper;
  final RequestHelper _requestHelper;

  LoginStore loginStore;

  RegisterStore registerStore;

  ForgotPasswordStore forgotPasswordStore;

  ChangePasswordStore changePasswordStore;

  AddressStore addressStore;

  WishListStore wishListStore;

  @observable
  bool _isLogin = false;

  @action
  void setLogin(bool value) {
    _isLogin = value;
  }

  @observable
  String _token;

  @action
  Future<void> setToken(String value) async {
    if (value == null) return;
    _token = value;
    return await _persistHelper.saveToken(value);
  }

  @observable
  User _user;

  @computed
  bool get isLogin => _isLogin;

  @computed
  User get user => _user;

  // Action: -----------------------------------------------------------------------------------------------------------
  @action
  void setUser(value) {
    _user = value;
  }

  @action
  Future<void> loginSuccess(Map<String, dynamic> data) async {
    _isLogin = true;
    _user = User.fromJson(data['user']);
    return await setToken(data['token']);
  }

  @action
  Future<bool> logout() async {
    _isLogin = false;
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print('Logout google error or not logged!');
    }

    try {
      await Firebase.initializeApp();
      await FB.FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Logout Firebase error or not logged!');
    }

    return await _persistHelper.removeToken();
  }

  // Constructor: ------------------------------------------------------------------------------------------------------
  _AuthStore(this._persistHelper, this._requestHelper) {
    this.loginStore = LoginStore(_requestHelper, this);
    this.registerStore = RegisterStore(_requestHelper, this);
    this.forgotPasswordStore = ForgotPasswordStore(_requestHelper);
    this.changePasswordStore = ChangePasswordStore(_requestHelper);
    this.addressStore = AddressStore(_requestHelper);
    this.wishListStore = WishListStore(_persistHelper);
    init();
  }

  Future init() async {
    restore();
  }

  void restore() async {
    String token = _persistHelper.getToken();
    if (token != null && token != '') {
      try {
        Map<String, dynamic> json = await _requestHelper.current();
        _user = User.fromJson(json);
        _token = token;
        _isLogin = true;
      } catch (e) {
        await _persistHelper.removeToken();
      }
    }
  }
}
