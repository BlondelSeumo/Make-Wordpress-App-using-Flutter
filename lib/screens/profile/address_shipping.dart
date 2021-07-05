import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/address/country.dart';
import 'package:cirilla/screens/profile/widgets/address.dart';
import 'package:cirilla/screens/profile/widgets/modal_country.dart';
import 'package:cirilla/screens/profile/widgets/modal_state.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AddressShippingScreen extends StatefulWidget {
  @override
  _AddressShippingScreenState createState() => _AddressShippingScreenState();
}

class _AddressShippingScreenState extends State<AddressShippingScreen> with SnackMixin, LoadingMixin, AppBarMixin {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtCompany = TextEditingController();
  TextEditingController txtAddress1 = TextEditingController();
  TextEditingController txtAddress2 = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtPostCode = TextEditingController();
  AuthStore _authStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    _authStore.addressStore.getCountry();
    _authStore.addressStore.getAddress(userId: _authStore.user.id);
  }

  @override
  void dispose() {
    _authStore.addressStore.changeCountryShip(_authStore.addressStore.billDetailData.shipping['country'], []);
    _authStore.addressStore.changeStateShip(_authStore.addressStore.billDetailData.shipping['state']);
    super.dispose();
  }

  postAddress() async {
    try {
      await _authStore.addressStore.postShipping(
        userId: _authStore.user.id,
        firstName: txtFirstName.text,
        lastName: txtLastName.text,
        company: txtCompany.text,
        address1: txtAddress1.text,
        address2: txtAddress2.text,
        city: txtCity.text,
        postCode: txtPostCode.text,
        country: _authStore.addressStore.countryCodeShip,
        state: _authStore.addressStore.stateCodeShip,
      );
      showSuccess(context, "address shipping successfully");
    } catch (e) {
      showError(context, e);
      print(e);
    }
  }

  void onClickCountry() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return buildViewModal(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return ModalCountries(
                countriesStore: _authStore.addressStore,
                valueShip: _authStore.addressStore.countryCodeShip,
                code: _authStore.addressStore.billDetailData.shipping['country'],
                onShip: true,
                onChangeShip: (String value, String countryCode, List states) {
                  _authStore.addressStore.changeCountryShip(countryCode, states);
                },
              );
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  void onClickState(List<Map<String, dynamic>> states) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return buildViewModal(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return ModalState(
                states: states,
                valueShip: _authStore.addressStore.stateCodeShip,
                code: _authStore.addressStore.billDetailData.shipping['state'],
                onShip: true,
                onChangeShip: (String value, String stateCodeShip) {
                  _authStore.addressStore.changeStateShip(stateCodeShip);
                },
              );
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Observer(builder: (_) {
      Map shipData = _authStore?.addressStore?.billDetailData?.shipping;

      String codeCountry = _authStore.addressStore.countryCodeShip;

      String stateCode = _authStore.addressStore.stateCodeShip;

      CountryData selectCountry = _authStore.addressStore.country
          .firstWhere((element) => element.code == codeCountry, orElse: () => CountryData());

      String selectNameCountry = selectCountry?.name ?? '';

      bool shownameState = selectCountry?.states?.isEmpty ?? true;

      String selectnameState = shownameState == false
          ? selectCountry.states.firstWhere((element) => element['code'] == stateCode)['name']
          : '';
      List<Map<String, dynamic>> states = selectCountry?.states ?? [];
      return Scaffold(
        appBar: AppBar(
          title: Text(translate('address_shipping'), style: theme.textTheme.subtitle1),
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: leading(),
        ),
        body: Stack(
          children: [
            if (shipData != null)
              AddressScreen(
                billData: shipData,
                billCountry: selectNameCountry,
                billState: selectnameState,
                addressData: _authStore.addressStore,
                onTap: () => onClickCountry(),
                onState: () => onClickState(states),
                onSave: () => postAddress(),
                txtFirstName: txtFirstName,
                txtLastName: txtLastName,
                txtCompany: txtCompany,
                txtAddress1: txtAddress1,
                txtAddress2: txtAddress2,
                txtCity: txtCity,
                txtPostCode: txtPostCode,
                states: states,
              ),
            if (shipData == null) buildLoading(context, isLoading: !_authStore.addressStore.loading),
          ],
        ),
      );
    });
  }

  Widget buildViewModal({Widget child}) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      constraints: BoxConstraints(maxHeight: height - 100),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        child: child,
      ),
    );
  }
}
