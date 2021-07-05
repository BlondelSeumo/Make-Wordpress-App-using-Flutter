import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:mobx/mobx.dart';

part 'forgot_password_store.g.dart';

class ForgotPasswordStore = _ForgotPasswordStore with _$ForgotPasswordStore;

abstract class _ForgotPasswordStore with Store {
  // repository instance
  RequestHelper _requestHelper;

  // store for handling form errors
  final ForgotPasswordErrorStore formErrorStore = ForgotPasswordErrorStore();

  // constructor:-------------------------------------------------------------------------------------------------------
  _ForgotPasswordStore(RequestHelper api) {
    this._requestHelper = api;
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
    ];
  }

  // store variables:-----------------------------------------------------------

  @observable
  String email = '';

  @observable
  bool loading = false;

  @observable
  bool success = false;

  @computed
  bool get canForgotPassword => !formErrorStore.hasErrorsInForgotPassword && email.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserEmail(String value) {
    email = value;
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.email = 'forgot_password_error_email';
    } else {
      formErrorStore.email = null;
    }
  }

  @action
  Future forgotPassword({String identityToken, String userIdentity}) async {
    loading = true;
    success = false;
    try {
      await _requestHelper.forgotPassword(userLogin: email);
      loading = false;
      success = true;
    } catch (e) {
      loading = false;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateEmail(email);
  }
}

class ForgotPasswordErrorStore = _ForgotPasswordErrorStore with _$ForgotPasswordErrorStore;

abstract class _ForgotPasswordErrorStore with Store {
  @observable
  String email;

  @computed
  bool get hasErrorsInForgotPassword => email != null;
}
