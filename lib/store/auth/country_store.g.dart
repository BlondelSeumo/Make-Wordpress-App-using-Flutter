// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddressStore on _AddressStore, Store {
  Computed<BillDetailData> _$billDetailDataComputed;

  @override
  BillDetailData get billDetailData => (_$billDetailDataComputed ??=
          Computed<BillDetailData>(() => super.billDetailData, name: '_AddressStore.billDetailData'))
      .value;
  Computed<ObservableList<CountryData>> _$countryComputed;

  @override
  ObservableList<CountryData> get country =>
      (_$countryComputed ??= Computed<ObservableList<CountryData>>(() => super.country, name: '_AddressStore.country'))
          .value;
  Computed<String> _$countryCodeBillComputed;

  @override
  String get countryCodeBill => (_$countryCodeBillComputed ??=
          Computed<String>(() => super.countryCodeBill, name: '_AddressStore.countryCodeBill'))
      .value;
  Computed<String> _$countryCodeShipComputed;

  @override
  String get countryCodeShip => (_$countryCodeShipComputed ??=
          Computed<String>(() => super.countryCodeShip, name: '_AddressStore.countryCodeShip'))
      .value;
  Computed<List<dynamic>> _$countryStatesBillComputed;

  @override
  List<dynamic> get countryStatesBill => (_$countryStatesBillComputed ??=
          Computed<List<dynamic>>(() => super.countryStatesBill, name: '_AddressStore.countryStatesBill'))
      .value;
  Computed<String> _$countryNameShipComputed;

  @override
  String get countryNameShip => (_$countryNameShipComputed ??=
          Computed<String>(() => super.countryNameShip, name: '_AddressStore.countryNameShip'))
      .value;
  Computed<String> _$stateCodeBillComputed;

  @override
  String get stateCodeBill =>
      (_$stateCodeBillComputed ??= Computed<String>(() => super.stateCodeBill, name: '_AddressStore.stateCodeBill'))
          .value;
  Computed<String> _$stateCodeShipComputed;

  @override
  String get stateCodeShip =>
      (_$stateCodeShipComputed ??= Computed<String>(() => super.stateCodeShip, name: '_AddressStore.stateCodeShip'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_AddressStore.loading')).value;

  final _$fetchCountriesFutureAtom = Atom(name: '_AddressStore.fetchCountriesFuture');

  @override
  ObservableFuture<List<CountryData>> get fetchCountriesFuture {
    _$fetchCountriesFutureAtom.reportRead();
    return super.fetchCountriesFuture;
  }

  @override
  set fetchCountriesFuture(ObservableFuture<List<CountryData>> value) {
    _$fetchCountriesFutureAtom.reportWrite(value, super.fetchCountriesFuture, () {
      super.fetchCountriesFuture = value;
    });
  }

  final _$_billDetailDataAtom = Atom(name: '_AddressStore._billDetailData');

  @override
  BillDetailData get _billDetailData {
    _$_billDetailDataAtom.reportRead();
    return super._billDetailData;
  }

  @override
  set _billDetailData(BillDetailData value) {
    _$_billDetailDataAtom.reportWrite(value, super._billDetailData, () {
      super._billDetailData = value;
    });
  }

  final _$_loadingAtom = Atom(name: '_AddressStore._loading');

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  final _$_countryCodeBillAtom = Atom(name: '_AddressStore._countryCodeBill');

  @override
  String get _countryCodeBill {
    _$_countryCodeBillAtom.reportRead();
    return super._countryCodeBill;
  }

  @override
  set _countryCodeBill(String value) {
    _$_countryCodeBillAtom.reportWrite(value, super._countryCodeBill, () {
      super._countryCodeBill = value;
    });
  }

  final _$_countryCodeShipAtom = Atom(name: '_AddressStore._countryCodeShip');

  @override
  String get _countryCodeShip {
    _$_countryCodeShipAtom.reportRead();
    return super._countryCodeShip;
  }

  @override
  set _countryCodeShip(String value) {
    _$_countryCodeShipAtom.reportWrite(value, super._countryCodeShip, () {
      super._countryCodeShip = value;
    });
  }

  final _$_countryStatesBillAtom = Atom(name: '_AddressStore._countryStatesBill');

  @override
  List<dynamic> get _countryStatesBill {
    _$_countryStatesBillAtom.reportRead();
    return super._countryStatesBill;
  }

  @override
  set _countryStatesBill(List<dynamic> value) {
    _$_countryStatesBillAtom.reportWrite(value, super._countryStatesBill, () {
      super._countryStatesBill = value;
    });
  }

  final _$_countryNameShipAtom = Atom(name: '_AddressStore._countryNameShip');

  @override
  String get _countryNameShip {
    _$_countryNameShipAtom.reportRead();
    return super._countryNameShip;
  }

  @override
  set _countryNameShip(String value) {
    _$_countryNameShipAtom.reportWrite(value, super._countryNameShip, () {
      super._countryNameShip = value;
    });
  }

  final _$_stateCodeBillAtom = Atom(name: '_AddressStore._stateCodeBill');

  @override
  String get _stateCodeBill {
    _$_stateCodeBillAtom.reportRead();
    return super._stateCodeBill;
  }

  @override
  set _stateCodeBill(String value) {
    _$_stateCodeBillAtom.reportWrite(value, super._stateCodeBill, () {
      super._stateCodeBill = value;
    });
  }

  final _$_stateCodeShipAtom = Atom(name: '_AddressStore._stateCodeShip');

  @override
  String get _stateCodeShip {
    _$_stateCodeShipAtom.reportRead();
    return super._stateCodeShip;
  }

  @override
  set _stateCodeShip(String value) {
    _$_stateCodeShipAtom.reportWrite(value, super._stateCodeShip, () {
      super._stateCodeShip = value;
    });
  }

  final _$_countryAtom = Atom(name: '_AddressStore._country');

  @override
  ObservableList<CountryData> get _country {
    _$_countryAtom.reportRead();
    return super._country;
  }

  @override
  set _country(ObservableList<CountryData> value) {
    _$_countryAtom.reportWrite(value, super._country, () {
      super._country = value;
    });
  }

  final _$changeCountryBillAsyncAction = AsyncAction('_AddressStore.changeCountryBill');

  @override
  Future<void> changeCountryBill(String value, List<dynamic> states) {
    return _$changeCountryBillAsyncAction.run(() => super.changeCountryBill(value, states));
  }

  final _$changeStateBillAsyncAction = AsyncAction('_AddressStore.changeStateBill');

  @override
  Future<void> changeStateBill(String value) {
    return _$changeStateBillAsyncAction.run(() => super.changeStateBill(value));
  }

  final _$changeCountryShipAsyncAction = AsyncAction('_AddressStore.changeCountryShip');

  @override
  Future<void> changeCountryShip(String value, List<dynamic> states) {
    return _$changeCountryShipAsyncAction.run(() => super.changeCountryShip(value, states));
  }

  final _$changeStateShipAsyncAction = AsyncAction('_AddressStore.changeStateShip');

  @override
  Future<void> changeStateShip(String value) {
    return _$changeStateShipAsyncAction.run(() => super.changeStateShip(value));
  }

  final _$getCountryAsyncAction = AsyncAction('_AddressStore.getCountry');

  @override
  Future<void> getCountry({Map<String, dynamic> queryParameters}) {
    return _$getCountryAsyncAction.run(() => super.getCountry(queryParameters: queryParameters));
  }

  final _$getAddressAsyncAction = AsyncAction('_AddressStore.getAddress');

  @override
  Future<void> getAddress({dynamic userId = String}) {
    return _$getAddressAsyncAction.run(() => super.getAddress(userId: userId));
  }

  final _$postBillingAsyncAction = AsyncAction('_AddressStore.postBilling');

  @override
  Future<void> postBilling(
      {dynamic userId = String,
      dynamic firstName = String,
      dynamic lastName = String,
      dynamic company = String,
      dynamic address1 = String,
      dynamic address2 = String,
      dynamic city = String,
      dynamic postCode = String,
      dynamic country = String,
      dynamic state = String,
      dynamic email = String,
      dynamic phone = String}) {
    return _$postBillingAsyncAction.run(() => super.postBilling(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        company: company,
        address1: address1,
        address2: address2,
        city: city,
        postCode: postCode,
        country: country,
        state: state,
        email: email,
        phone: phone));
  }

  final _$postShippingAsyncAction = AsyncAction('_AddressStore.postShipping');

  @override
  Future<void> postShipping(
      {dynamic userId = String,
      dynamic firstName = String,
      dynamic lastName = String,
      dynamic company = String,
      dynamic address1 = String,
      dynamic address2 = String,
      dynamic city = String,
      dynamic postCode = String,
      dynamic country = String,
      dynamic state = String}) {
    return _$postShippingAsyncAction.run(() => super.postShipping(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        company: company,
        address1: address1,
        address2: address2,
        city: city,
        postCode: postCode,
        country: country,
        state: state));
  }

  @override
  String toString() {
    return '''
fetchCountriesFuture: ${fetchCountriesFuture},
billDetailData: ${billDetailData},
country: ${country},
countryCodeBill: ${countryCodeBill},
countryCodeShip: ${countryCodeShip},
countryStatesBill: ${countryStatesBill},
countryNameShip: ${countryNameShip},
stateCodeBill: ${stateCodeBill},
stateCodeShip: ${stateCodeShip},
loading: ${loading}
    ''';
  }
}
