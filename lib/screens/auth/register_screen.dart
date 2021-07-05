import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/auth/login_screen.dart';
import 'package:cirilla/screens/home/home.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';

///
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

///
import 'layout/register_screen_logo_top.dart';
import 'layout/register_screen_social_top.dart';
import 'layout/register_screen_image_header_top.dart';
import 'layout/register_screen_header_conner.dart';

///
import 'widgets/register_form.dart';
import 'widgets/social_login.dart';
import 'widgets/heading_text.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  final SettingStore store;

  const RegisterScreen({Key key, this.store}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with AppBarMixin, LoadingMixin, SnackMixin, Utility {
  AuthStore _authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore ??= Provider.of<AuthStore>(context);
  }

  void _handleLogin(Map<String, dynamic> queryParameters) async {
    try {
      await _authStore.loginStore.login(queryParameters);
      Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
    } catch (e) {
      showError(context, e);
    }
  }

  void _handleRegister(Map<String, dynamic> queryParameters) async {
    try {
      await _authStore.registerStore.register(queryParameters);
      Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
    } catch (e) {
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store.data == null || widget.store.data.screens['register'] == null) return Container();

    WidgetConfig widgetConfig = widget.store.data.screens['register'].widgets['register'];
    TranslateType translate = AppLocalizations.of(context).translate;

    // Get configs
    Map<String, dynamic> configsRegister = widget.store.data.screens['register'].configs;
    Color appbarColor =
        ConvertData.fromRGBA(get(configsRegister, ['appbarColor', widget.store.themeModeKey]), Colors.white);
    bool extendBodyBehindAppBar = get(configsRegister, ['extendBodyBehindAppBar'], false);

    // Get fields
    Map<String, dynamic> fields = widgetConfig.fields ?? {};
    bool titleAppBar = get(fields, ['titleAppBar'], false);

    // Get styles
    Map<String, dynamic> stylesRegister = widgetConfig.styles;
    Color background =
        ConvertData.fromRGBA(get(stylesRegister, ['background', widget.store.themeModeKey]), Colors.white);

    // Layout
    String layout = widgetConfig.layout ?? 'default';

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: titleAppBar ? Text(translate('register_txt_login')) : null,
        elevation: 0,
        leading: leading(),
      ),
      body: Observer(
        builder: (_) {
          return Stack(
            children: [
              buildLayout(layout, widgetConfig, background),
              if (_authStore.registerStore.loading)
                Align(
                  child: buildLoadingOverlay(context),
                  alignment: FractionalOffset.center,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget buildLayout(String layout, WidgetConfig widgetConfig, Color background) {
    String headerImage = get(widgetConfig.styles, ['headerImage'], Assets.noImageUrl);
    EdgeInsetsDirectional padding = ConvertData.space(get(widgetConfig.styles, ['padding']));

    bool registerFacebook = get(widgetConfig.fields, ['registerFacebook'], true);
    bool registerGoogle = get(widgetConfig.fields, ['registerGoogle'], true);
    bool registerApple = get(widgetConfig.fields, ['registerApple'], true);
    bool registerPhoneNumber = get(widgetConfig.fields, ['registerPhoneNumber'], true);

    String term = get(widgetConfig.fields, ['term', widget.store.languageKey], '');

    Map<String, bool> enable = {
      'facebook': registerFacebook,
      'google': registerGoogle,
      'sms': registerPhoneNumber,
      'apple': registerApple,
    };

    Widget social = SocialLogin(
      store: _authStore.loginStore,
      handleLogin: _handleLogin,
      enable: enable,
    );

    Widget registerForm = RegisterForm(
      handleRegister: _handleRegister,
      enableRegisterPhoneNumber: registerPhoneNumber,
      term: term,
    );
    EdgeInsetsDirectional paddingFooter = EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 20, end: 20);

    switch (layout) {
      case Strings.loginLayoutLogoTop:
        return RegisterScreenLogoTop(
          header: Image.network(headerImage, height: 48),
          registerForm: registerForm,
          socialLogin: social,
          loginText: _TextLogin(),
          padding: padding,
          paddingFooter: paddingFooter,
        );
        break;
      case Strings.loginLayoutImageHeaderTop:
        return RegisterScreenImageHeaderTop(
          header: Positioned.fill(
            child: Image.network(
              headerImage,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          title: HeadingText(title: 'Login Now'),
          registerForm: registerForm,
          socialLogin: social,
          loginText: _TextLogin(),
          padding: padding,
          paddingFooter: paddingFooter,
          background: background,
        );
        break;
      case Strings.loginLayoutImageHeaderCorner:
        return RegisterScreenImageHeaderConner(
          header: Image.network(
            headerImage,
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
          title: HeadingText(
            title: 'Login Now',
          ),
          registerForm: registerForm,
          socialLogin: social,
          loginText: _TextLogin(),
          background: background,
          padding: padding,
          paddingFooter: paddingFooter,
        );
        break;
      default:
        return RegisterScreenSocialTop(
          padding: padding,
          paddingFooter: paddingFooter,
          header: HeadingText.animated(title: 'Register', enable: enable),
          registerForm: registerForm,
          socialLogin: SocialLogin(
            store: _authStore.loginStore,
            handleLogin: _handleLogin,
            mainAxisAlignment: MainAxisAlignment.start,
            enable: enable,
          ),
          loginText: _TextLogin(),
        );
    }
  }
}

class _TextLogin extends StatelessWidget {
  const _TextLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
      child: Text("Already have an account ?"),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: textTheme.caption,
      ),
    );
  }
}
