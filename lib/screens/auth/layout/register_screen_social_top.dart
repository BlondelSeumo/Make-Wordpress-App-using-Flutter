import 'package:flutter/material.dart';

class RegisterScreenSocialTop extends StatelessWidget {
  final EdgeInsetsDirectional padding;
  final EdgeInsetsDirectional paddingFooter;
  final Widget header;
  final Widget registerForm;
  final Widget socialLogin;
  final Widget loginText;

  RegisterScreenSocialTop({
    Key key,
    this.header,
    this.registerForm,
    this.socialLogin,
    this.loginText,
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
                    SizedBox(height: 56),
                    registerForm,
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
              child: loginText,
            ),
          ),
        ),
      ],
    );
  }
}
