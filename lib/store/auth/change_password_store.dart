import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'change_password_store.g.dart';

class ChangePasswordStore = _ChangePasswordStore with _$ChangePasswordStore;

abstract class _ChangePasswordStore with Store {
  // repository instance
  RequestHelper _requestHelper;

  // constructor:-------------------------------------------------------------------------------------------------------
  _ChangePasswordStore(RequestHelper requestHelper) {
    this._requestHelper = requestHelper;
  }

  // store variables:-----------------------------------------------------------

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @action
  Future<dynamic> changePassword(String passwordOld, String passwordNew) async {
    _loading = true;
    try {
      final res = await _requestHelper
          .changePassword(queryParameters: {"password_old": passwordOld, "password_new": passwordNew});
      _loading = false;
      return res;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }
}
