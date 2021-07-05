import 'dart:io' show Platform;
import 'package:cirilla/screens/auth/login_mobile_screen.dart';
import 'package:cirilla/store/auth/login_store.dart';
import 'package:cirilla/widgets/cirilla_button_social.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cirilla/constants/app.dart' show googleClientId;
import 'package:cirilla/constants/constants.dart' show isWeb;

import 'package:cirilla/screens/auth/services/login_apple.dart';
import 'package:cirilla/screens/auth/services/login_facebook.dart';

class SocialLogin extends StatefulWidget {
  final LoginStore store;
  final Function(Map<String, dynamic>) handleLogin;
  final MainAxisAlignment mainAxisAlignment;

  final Map<String, bool> enable;

  const SocialLogin({
    Key key,
    this.store,
    this.handleLogin,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.enable,
  }) : super(key: key);

  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> with AppleLoginMixin, FacebookLoginMixin {
  GoogleSignInAccount _currentUser;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: isWeb || Platform.isAndroid ? googleClientId : null,
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleLogin(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleLogin(GoogleSignInAccount user) async {
    GoogleSignInAuthentication auth = await user.authentication;
    widget.handleLogin({
      'type': 'google',
      'idToken': auth.idToken,
    });
  }

  Future<void> loginGoogle(Function login) async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('---- Login Google Error---');
      print(e);
      print('---- End Login Google Error---');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool enableFacebook = widget?.enable['facebook'] ?? true;
    bool enableGoogle = widget?.enable['google'] ?? true;
    bool enableSms = widget?.enable['sms'] ?? true;
    bool enableApple = !isWeb && Platform.isIOS && widget?.enable['apple'];

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        if (enableFacebook)
          CirillaButtonSocial.facebook(
            onPressed: () => loginFacebook(widget.handleLogin),
          ),
        if (enableFacebook && (enableGoogle || enableSms || enableApple))
          SizedBox(
            width: 16,
          ),
        if (enableGoogle)
          CirillaButtonSocial.google(
            onPressed: () => loginGoogle(widget.handleLogin),
          ),
        if (enableGoogle && (enableSms || enableApple))
          SizedBox(
            width: 16,
          ),
        if (enableSms)
          CirillaButtonSocial.sms(
            onPressed: () => Navigator.of(context).pushNamed(LoginMobileScreen.routeName),
          ),
        if (enableSms && enableApple)
          SizedBox(
            width: 16,
          ),
        if (enableApple)
          CirillaButtonSocial.apple(
            onPressed: () => loginApple(widget.handleLogin),
          ),
      ],
    );
  }
}
