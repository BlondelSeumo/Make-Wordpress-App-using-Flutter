import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:dio/dio.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:provider/provider.dart';

class SubscribeWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;
  SubscribeWidget({
    Key key,
    @required this.widgetConfig,
  }) : super(key: key);

  @override
  _SubscribeWidgetState createState() => _SubscribeWidgetState();
}

class _SubscribeWidgetState extends State<SubscribeWidget> with Utility, NavigationMixin, SnackMixin, LoadingMixin {
  final _emailController = TextEditingController();
  bool _loading = false;
  bool _validateEmail = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String lang = settingStore?.locale ?? 'en';

    /// Config general
    Map<String, dynamic> headingData = widget.widgetConfig?.fields ?? {};
    String text = ConvertData.stringFromConfigs(get(headingData, ['title'], ''), lang);
    TextStyle titleStyle = ConvertData.toTextStyle(get(headingData, ['title'], ''), themeModeKey);
    String description = ConvertData.stringFromConfigs(get(headingData, ['description'], ''), lang);
    TextStyle descriptionStyle = ConvertData.toTextStyle(get(headingData, ['description'], ''), themeModeKey);
    String placeHolder = ConvertData.stringFromConfigs(get(headingData, ['placeholder'], ''), lang);
    String textButton = ConvertData.stringFromConfigs(get(headingData, ['txtButton', 'text'], ''), lang);

    String formId = get(headingData, ['formId'], '');

    /// Styles
    Map<String, dynamic> styles = widget.widgetConfig?.styles ?? {};
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    Map padding = get(styles, ['padding'], {});
    Map margin = get(styles, ['margin'], {});
    String image = styles['image'] ?? '';

    RequestHelper requestHelper = Provider.of<RequestHelper>(context);

    return Container(
        padding: ConvertData.space(padding, 'padding'),
        margin: ConvertData.space(margin, 'padding'),
        height: MediaQuery.of(context).size.width * 0.88,
        decoration: BoxDecoration(
          color: background,
          image: image != ''
              ? DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        width: double.infinity,
        child: SubscribeItem(
          icon: Icon(
            FeatherIcons.mail,
            size: 20,
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.headline6.merge(titleStyle),
          ),
          content: Text(
            description,
            style: Theme.of(context).textTheme.bodyText2.merge(descriptionStyle),
            textAlign: TextAlign.center,
          ),
          textField: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: placeHolder,
              errorText: _validateEmail ? 'email is required' : null,
              filled: true,
              // fillColor: Colors.white,
              labelStyle: Theme.of(context).textTheme.bodyText1,
              contentPadding: EdgeInsetsDirectional.only(start: 16, bottom: 2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
          ),
          elevatedButton: ElevatedButton(
            onPressed: () async {
              setState(() {
                _loading = true;
              });
              try {
                Map<String, dynamic> res = await requestHelper.sendContact(queryParameters: {
                  'your-email': _emailController.text,
                }, formId: formId);
                if (res['status'] != 'mail_sent') {
                  showError(context, res['message']);
                } else {
                  showSuccess(context, res['message']);
                }
                setState(() {
                  _emailController.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                  _emailController.clear();
                  _loading = false;
                });
              } on DioError catch (e) {
                showError(context, e);
                setState(() {
                  _loading = false;
                });
              }
            },
            child: _loading ? entryLoading(context, color: Theme.of(context).colorScheme.onPrimary) : Text(textButton),
          ),
        ));
  }
}
