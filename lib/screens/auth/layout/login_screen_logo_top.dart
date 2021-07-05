import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_divider_text.dart';
import 'package:flutter/material.dart';

class LoginScreenLogoTop extends StatelessWidget {
  final Widget header;
  final Widget loginForm;
  final Widget socialLogin;
  final Widget registerText;
  final Widget termText;
  final Color background;
  final EdgeInsetsDirectional padding;
  final EdgeInsetsDirectional paddingFooter;

  LoginScreenLogoTop({
    Key key,
    this.header,
    this.loginForm,
    this.socialLogin,
    this.registerText,
    this.termText,
    this.background,
    this.padding,
    this.paddingFooter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    double width = MediaQuery.of(context).size.width;

    double widthDivider = width - padding.start - padding.end;

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
                    SizedBox(height: 64.5),
                    loginForm,
                    SizedBox(height: 64),
                    CirillaDividerText(
                      width: widthDivider,
                      text: translate('login_text_or'),
                      background: background,
                    ),
                    SizedBox(height: 24),
                    socialLogin,
                    SizedBox(height: 16),
                    termText,
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
