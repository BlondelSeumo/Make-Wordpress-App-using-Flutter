import 'package:flutter/material.dart';

class LoginScreenSocialTop extends StatelessWidget {
  final EdgeInsetsDirectional padding;
  final EdgeInsetsDirectional paddingFooter;
  final Widget header;
  final Widget loginForm;
  final Widget socialLogin;
  final Widget registerText;
  final Widget termText;

  LoginScreenSocialTop({
    Key key,
    this.header,
    this.loginForm,
    this.socialLogin,
    this.registerText,
    this.termText,
    this.padding,
    this.paddingFooter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    header,
                    SizedBox(height: 24),
                    socialLogin,
                    SizedBox(height: 16),
                    termText,
                    SizedBox(height: 56),
                    loginForm,
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: paddingFooter,
              child: registerText,
            ),
          ),
        ),
      ],
    );
  }
}
