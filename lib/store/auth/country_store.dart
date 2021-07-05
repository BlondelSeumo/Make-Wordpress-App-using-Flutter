import 'package:cirilla/models/address/bill_detail.dart';
import 'package:cirilla/models/address/country.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'country_store.g.dart';

class AddressStore = _AddressStore with _$AddressStore;

abstract class _AddressStore with Store {
  final RequestHelper _requestHelper;

  _AddressStore(
    this._requestHelper,
  ) {
    _reaction();
  }
  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<CountryData>> emptyCountriesResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<CountryData>> fetchCountriesFuture = emptyCountriesResponse;

  @observable
  BillDetailData _billDetailData;

  @observable
  bool _loading = false;

  @observable
  String _countryCodeBill = "";

  @observable
  String _countryCodeShip = "";

  @observable
  List _countryStatesBill = [];

  @observable
  String _countryNameShip = "";

  @observable
  String _stateCodeBill = "";

  @observable
  String _stateCodeShip = "";

  @observable
  ObservableList<CountryData> _country = ObservableList<CountryData>.of([]);

  @computed
  BillDetailData get billDetailData => _billDetailData;

  @computed
  ObservableList<CountryData> get country => _country;

  @computed
  String get countryCodeBill => _countryCodeBill;

  @computed
  String get countryCodeShip => _countryCodeShip;

  @computed
  List get countryStatesBill => _countryStatesBill;

  @computed
  String get countryNameShip => _countryNameShip;

  @computed
  String get stateCodeBill => _stateCodeBill;

  @computed
  String get stateCodeShip => _stateCodeShip;

  @computed
  bool get loading => _loading;

  @action
  Future<void> changeCountryBill(String value, List states) async {
    _countryCodeBill = value;
    _stateCodeBill = states.length > 0 ? states[0]['code'] : '';
  }

  @action
  Future<void> changeStateBill(String value) async {
    _stateCodeBill = value;
  }

  @action
  Future<void> changeCountryShip(String value, List states) async {
    _countryCodeShip = value;
    _stateCodeShip = states.length > 0 ? states[0]['code'] : '';
  }

  @action
  Future<void> changeStateShip(String value) async {
    _stateCodeShip = value;
  }

  @action
  Future<void> getCountry({Map<String, dynamic> queryParameters}) async {
    final futureCountry = _requestHelper.getCountry(queryParameters: queryParameters);
    fetchCountriesFuture = ObservableFuture(futureCountry);
    return futureCountry.then((country) {
      _country = ObservableList<CountryData>.of(country);
    }).catchError((error) {});
  }

  @action
  Future<void> getAddress({userId: String}) async {
    try {
      Map<String, dynamic> json = await _requestHelper.getAddress(
        userId: userId,
      );

      BillDetailData detail = BillDetailData.fromJson(json);

      _billDetailData = detail;

      _countryCodeBill = detail.billing['country'];
      _stateCodeBill = detail.billing['state'] ?? '';

      _countryCodeShip = detail.shipping['country'];
      _stateCodeShip = detail.shipping['state'] ?? '';
    } on DioError catch (e) {
      throw e;
    }
  }

  @action
  Future<void> postBilling({
    userId: String,
    firstName: String,
    lastName: String,
    company: String,
    address1: String,
    address2: String,
    city: String,
    postCode: String,
    country: String,
    state: String,
    email: String,
    phone: String,
  }) async {
    Map<String, dynamic> billing = {
      "first_name": firstName,
      "last_name": lastName,
      "company": company,
      "address_1": address1,
      "address_2": address2,
      "city": city,
      "postcode": postCode,
      "country": country,
      "state": state,
      "email": email,
      "phone": phone,
    };
    try {
      Map<String, dynamic> json = await _requestHelper.postAddress(
        userId: userId,
        data: {"billing": billing},
      );
      return json;
    } on DioError catch (e) {
      throw e;
    }
  }

  @action
  Future<void> postShipping({
    userId: String,
    firstName: String,
    lastName: String,
    company: String,
    address1: String,
    address2: String,
    city: String,
    postCode: String,
    country: String,
    state: String,
  }) async {
    Map<String, dynamic> shipping = {
      'first_name': firstName,
      'last_name': lastName,
      "company": company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': postCode,
      'country': country,
      'state': state,
    };
    try {
      Map<String, dynamic> json = await _requestHelper.postAddress(
        userId: userId,
        data: {"shipping": shipping},
      );
      return json;
    } on DioError catch (e) {
      throw e;
    }
  }

  // disposers:---------------------------------------------------------------------------------------------------------
  List<ReactionDisposer> _disposers;
  void _reaction() {
    _disposers = [];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
