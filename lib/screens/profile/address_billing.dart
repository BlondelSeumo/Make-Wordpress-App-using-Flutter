import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/profile/widgets/address.dart';
import 'package:cirilla/screens/profile/widgets/modal_country.dart';
import 'package:cirilla/screens/profile/widgets/modal_state.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:cirilla/models/address/country.dart';

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> with SnackMixin, LoadingMixin, AppBarMixin {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtCompany = TextEditingController();
  TextEditingController txtAddress1 = TextEditingController();
  TextEditingController txtAddress2 = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtPostCode = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
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
    _authStore.addressStore.changeCountryBill(_authStore.addressStore.billDetailData.billing['country'], []);
    _authStore.addressStore.changeStateBill(_authStore.addressStore.billDetailData.billing['state']);
    super.dispose();
  }

  postAddress() async {
    try {
      await _authStore.addressStore.postBilling(
          userId: _authStore.user.id,
          firstName: txtFirstName.text,
          lastName: txtLastName.text,
          company: txtCompany.text,
          address1: txtAddress1.text,
          address2: txtAddress2.text,
          city: txtCity.text,
          postCode: txtPostCode.text,
          country: _authStore.addressStore.countryCodeBill,
          state: _authStore.addressStore.stateCodeBill,
          email: txtEmail.text,
          phone: txtPhone.text);
      showSuccess(context, "address billing successfully");
    } catch (e) {
      showError(context, e);
    }
  }

  void onClickCountry() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return buildViewModal(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return ModalCountries(
                countriesStore: _authStore.addressStore,
                value: _authStore.addressStore.countryCodeBill,
                code: _authStore.addressStore.billDetailData.billing['country'],
                onChange: (String value, String countryCode, List states) {
                  _authStore.addressStore.changeCountryBill(countryCode, states);
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

  void onClickState(List<Map<String, dynamic>> states) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return buildViewModal(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return ModalState(
                states: states,
                value: _authStore.addressStore.stateCodeBill,
                code: _authStore.addressStore.billDetailData.billing['state'],
                onChange: (String value, String stateCodeBill) {
                  _authStore.addressStore.changeStateBill(stateCodeBill);
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
      Map billData = _authStore?.addressStore?.billDetailData?.billing;
      String codeCountry = _authStore.addressStore.countryCodeBill;

      String stateCode = _authStore.addressStore.stateCodeBill ?? '';

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
          title: Text(translate('address_billing'), style: theme.textTheme.subtitle1),
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: leading(),
        ),
        body: Stack(
          children: [
            if (billData != null)
              AddressScreen(
                billData: billData,
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
                txtEmail: txtEmail,
                txtPhone: txtPhone,
                states: states,
                onEmailPhone: true,
              ),
            if (billData == null) buildLoading(context, isLoading: !_authStore.addressStore.loading),
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
