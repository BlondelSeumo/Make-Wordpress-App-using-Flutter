import 'dart:async';

import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/auth/widgets/verify_code.dart';
import 'package:cirilla/screens/home/home.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_phone_input/cirilla_phone_input.dart';
import 'package:cirilla/widgets/cirilla_phone_input/phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

// Ensure firebase initialize
class LoginMobileScreen extends StatelessWidget {
  static const routeName = '/login_mobile';

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            child: Text('Error'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginMobile();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

class LoginMobile extends StatefulWidget {
  LoginMobile({
    Key key,
  }) : super(key: key);

  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> with SnackMixin, LoadingMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStore _authStore;

  final _formKey = GlobalKey<FormState>();

  final _txtPhoneNumber = TextEditingController();

  PhoneNumber _phoneNumber;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User logged!');
        handleLogin(user);
      }
    });
  }

  @override
  void didChangeDependencies() {
    _authStore = Provider.of<AuthStore>(context);
    super.didChangeDependencies();
  }

  handleLogin(User user) async {
    try {
      IdTokenResult idTokenResult = await user.getIdTokenResult();
      await _authStore.loginStore.login({'type': 'phone', 'token': idTokenResult.token});
      Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
    } catch (e) {
      showError(context, e);
      await _authStore.logout();
    }
  }

  setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  onSubmit(BuildContext context, {String phoneNumber}) async {
    setLoading(true);
    try {
      // For web
      if (isWeb) {
        ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(phoneNumber);
        String smsCode = await showModalBottomSheet<String>(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (context) => VerifyCode(),
        );
        if (smsCode == null) {
          setLoading(false);
          return;
        }
        try {
          await confirmationResult.confirm(smsCode);
          setLoading(false);
        } catch (e) {
          setLoading(false);
          showError(context, e.message);
        }
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Automatic handling of the SMS code on Android devices.
            await _auth.signInWithCredential(credential);
            setLoading(false);
          },
          verificationFailed: (FirebaseAuthException e) {
            setLoading(false);
            showError(context, e.message);
          },
          codeSent: (String verificationId, int resendToken) async {
            String smsCode = await showModalBottomSheet<String>(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (context) => VerifyCode(),
            );
            // The case user close modal pass code without any data
            if (smsCode == null) {
              setLoading(false);
              return;
            }

            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

            try {
              await _auth.signInWithCredential(phoneAuthCredential);
              setLoading(false);
            } catch (e) {
              setLoading(false);
              showError(context, e.message);
            }
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            setLoading(false);
          },
        );
      }
    } catch (e) {
      setLoading(false);
      showError(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('login_mobile_appbar')),
        elevation: 0,
      ),
      body: Observer(
        builder: (_) => Stack(
          children: [
            buildBody(),
            if (_authStore.loginStore.loading)
              Align(
                child: buildLoadingOverlay(context),
                alignment: FractionalOffset.center,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    TranslateType translate = AppLocalizations.of(context).translate;

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      translate('login_mobile_description'),
                      style: textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CirillaPhoneInput(
                      controller: _txtPhoneNumber,
                      validator: (value) {
                        if (value.isEmpty) {
                          return translate('validate_phone_number_required');
                        }
                        return null;
                      },
                      autoValidate: false,
                      onChanged: (phone) {
                        setState(() {
                          _phoneNumber = phone;
                        });
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _loading
                        ? buildLoading(context, isLoading: _loading)
                        : SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate() && _phoneNumber != null) {
                                  onSubmit(
                                    context,
                                    phoneNumber: _phoneNumber.number.startsWith('+')
                                        ? _phoneNumber.number
                                        : _phoneNumber.completeNumber,
                                  );
                                }
                              },
                              child: Text(translate('login_mobile_btn_code')),
                            ),
                          ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
