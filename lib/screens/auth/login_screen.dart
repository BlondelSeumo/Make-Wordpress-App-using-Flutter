import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/auth/forgot_screen.dart';
import 'package:cirilla/screens/auth/register_screen.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:html/dom.dart' as dom;

///
import 'package:flutter/material.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

///
import 'layout/login_screen_logo_top.dart';
import 'layout/login_screen_social_top.dart';
import 'layout/login_screen_image_header_top.dart';
import 'layout/login_screen_header_conner.dart';

///
import 'widgets/login_form.dart';
import 'widgets/social_login.dart';
import 'widgets/heading_text.dart';
import 'widgets/term_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  final SettingStore store;

  const LoginScreen({Key key, this.store}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AppBarMixin, LoadingMixin, SnackMixin, Utility {
  AuthStore _authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore ??= Provider.of<AuthStore>(context);
  }

  void _onLinkTab(
    String url,
    RenderContext renderContext,
    Map<String, String> attributes,
    dom.Element element,
  ) {
    if (url.isNotEmpty && url.contains("lost-password")) {
      Navigator.pushNamed(context, ForgotScreen.routeName);
    }
  }

  void _handleLogin(Map<String, dynamic> queryParameters) async {
    try {
      await _authStore.loginStore.login(queryParameters);
      final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
      ShowMessageType showMessage = args['showMessage'];
      if (showMessage != null) {
        showMessage(message: 'Logged!');
      }
      Navigator.pop(context);
    } catch (e) {
      showError(context, e, onLinkTap: _onLinkTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Observer(builder: (_) {
      // Login screen config
      WidgetConfig widgetConfig = widget.store.data.screens['login'].widgets['login'];

      // Get configs
      Map<String, dynamic> configsLogin = widget.store.data.screens['login'].configs;
      Color appbarColor =
          ConvertData.fromRGBA(get(configsLogin, ['appbarColor', widget.store.themeModeKey]), Colors.white);
      bool extendBodyBehindAppBar = get(configsLogin, ['extendBodyBehindAppBar'], false);

      // Get fields
      Map<String, dynamic> fields = widgetConfig.fields ?? {};
      bool titleAppBar = get(fields, ['titleAppBar'], false);

      // Get styles
      Map<String, dynamic> stylesLogin = widgetConfig.styles;
      Color background =
          ConvertData.fromRGBA(get(stylesLogin, ['background', widget.store.themeModeKey]), Colors.white);

      // Layout
      // String layout = widgetConfig.layout ?? 'default';
      String layout = Strings.loginLayoutImageHeaderTop;

      return Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: titleAppBar ? Text(translate('login_txt_login')) : null,
          elevation: 0,
          centerTitle: true,
          leading: leading(),
        ),
        body: Stack(
          children: [
            buildLayout(layout, widgetConfig, background),
            if (_authStore.loginStore.loading)
              Align(
                child: buildLoadingOverlay(context),
                alignment: FractionalOffset.center,
              ),
          ],
        ),
      );
    });
  }

  Widget buildLayout(String layout, WidgetConfig widgetConfig, Color background) {
    String headerImage = get(widgetConfig.styles, ['headerImage'], Assets.noImageUrl);
    EdgeInsetsDirectional padding = ConvertData.space(get(widgetConfig.styles, ['padding']));

    bool loginFacebook = get(widgetConfig.fields, ['loginFacebook'], true);
    bool loginGoogle = get(widgetConfig.fields, ['loginGoogle'], true);
    bool loginApple = get(widgetConfig.fields, ['loginApple'], true);
    bool loginPhoneNumber = get(widgetConfig.fields, ['loginPhoneNumber'], true);

    String term = get(widgetConfig.fields, ['term', widget.store.languageKey], '');

    Map<String, bool> enable = {
      'facebook': loginFacebook,
      'google': loginGoogle,
      'sms': loginPhoneNumber,
      'apple': loginApple,
    };

    Widget social = SocialLogin(
      store: _authStore.loginStore,
      handleLogin: _handleLogin,
      enable: enable,
    );

    switch (layout) {
      case Strings.loginLayoutLogoTop:
        return LoginScreenLogoTop(
          header: Image.network(headerImage, height: 48),
          loginForm: LoginForm(handleLogin: _handleLogin),
          socialLogin: social,
          registerText: _TextRegister(),
          termText: TermText(html: term),
          padding: padding,
          paddingFooter: EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 20, end: 20),
          background: background,
        );
        break;
      case Strings.loginLayoutImageHeaderTop:
        return LoginScreenImageHeaderTop(
          header: Positioned.fill(
            child: Image.network(
              headerImage,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          title: HeadingText(title: 'Login Now'),
          loginForm: LoginForm(handleLogin: _handleLogin),
          socialLogin: social,
          registerText: _TextRegister(),
          termText: TermText(html: term),
          background: background,
          padding: padding,
          paddingFooter: EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 20, end: 20),
        );
        break;
      case Strings.loginLayoutImageHeaderCorner:
        return LoginScreenImageHeaderConner(
          header: Image.network(
            headerImage,
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
          title: HeadingText(title: 'Login Now'),
          loginForm: LoginForm(handleLogin: _handleLogin),
          socialLogin: social,
          registerText: _TextRegister(),
          termText: TermText(html: term),
          padding: padding,
          paddingFooter: EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 20, end: 20),
          background: background,
        );
        break;
      default:
        return LoginScreenSocialTop(
          padding: padding,
          paddingFooter: EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 20, end: 20),
          header: HeadingText.animated(title: 'Login', enable: enable),
          loginForm: LoginForm(handleLogin: _handleLogin),
          socialLogin: SocialLogin(
            store: _authStore.loginStore,
            handleLogin: _handleLogin,
            mainAxisAlignment: MainAxisAlignment.start,
            enable: enable,
          ),
          termText: TermText(mainAxisAlignment: MainAxisAlignment.start, html: term),
          registerText: _TextRegister(),
        );
    }
  }
}

class _TextRegister extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;

  const _TextRegister({Key key, this.mainAxisAlignment = MainAxisAlignment.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text("Don't have an account ?", style: textTheme.caption),
        SizedBox(width: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
          child: Text("Register Now"),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: textTheme.caption,
          ),
        )
      ],
    );
  }
}
