import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'auth_store.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  // repository instance
  RequestHelper _requestHelper;
  AuthStore _auth;

  // constructor:-------------------------------------------------------------------------------------------------------
  _RegisterStore(RequestHelper requestHelper, AuthStore authStore) {
    this._requestHelper = requestHelper;
    this._auth = authStore;
  }

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  // actions:-------------------------------------------------------------------
  @action
  Future<dynamic> register(Map<String, dynamic> queryParameters) async {
    _loading = true;
    try {
      Map<String, dynamic> data = await _requestHelper.register(queryParameters);
      await _auth.loginSuccess(data);
      _loading = false;
      return true;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }
}
