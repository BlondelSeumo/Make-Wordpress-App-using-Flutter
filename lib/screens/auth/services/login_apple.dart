import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

mixin AppleLoginMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> loginApple(Function login) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      login({
        'type': 'apple',
        'identityToken': credential.identityToken,
        'authorizationCode': credential.authorizationCode,
        'userIdentifier': credential.userIdentifier,
        'givenName': credential.givenName,
        'familyName': credential.familyName,
      });
    } catch (e) {
      print('---- Login Apple Error---');
      print(e);
      print('---- End Login Apple Error---');
    }
  }
}
