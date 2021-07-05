import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialWidget extends StatelessWidget with Utility {
  final WidgetConfig widgetConfig;

  SocialWidget({
    Key key,
    @required this.widgetConfig,
  }) : super(key: key);

  void share(String url) {
    if (url is String && url != '') {
      launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';

    // Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map<String, dynamic> margin = get(styles, ['margin'], {});
    Map<String, dynamic> padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);

    // General config
    Map<String, dynamic> fields = widgetConfig?.fields ?? {};
    String alignment = get(fields, ['alignment'], 'center');
    double pad = ConvertData.stringToDouble(get(fields, ['pad'], 0));
    List items = get(fields, ['socials'], []);

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      color: background,
      child: Wrap(
        spacing: pad,
        runSpacing: pad,
        alignment: wrapAlignment(alignment),
        children: List.generate(items.length, (index) {
          Map item = items[index];
          String type = get(item, ['data', 'typeSocial'], 'facebook');
          String url = ConvertData.stringFromConfigs(get(item, ['data', 'linkSocial'], ''));
          bool enableRound = get(item, ['data', 'enableRound'], true);
          bool enableOutLine = get(item, ['data', 'enableOutLine'], true);

          SocialBoxFit boxFit = enableOutLine ? SocialBoxFit.outline : SocialBoxFit.fill;
          SocialType typeButton = enableRound ? SocialType.circle : SocialType.square;

          switch (type) {
            case 'google':
              return CirillaButtonSocial.google(
                size: 34,
                sizeIcon: 14,
                boxFit: boxFit,
                type: typeButton,
                onPressed: () => share(url),
              );
            case 'twitter':
              return CirillaButtonSocial.twitter(
                size: 34,
                sizeIcon: 14,
                boxFit: boxFit,
                type: typeButton,
                onPressed: () => share(url),
              );
            case 'linkedin':
              return CirillaButtonSocial.linkedIn(
                size: 34,
                sizeIcon: 14,
                boxFit: boxFit,
                type: typeButton,
                onPressed: () => share(url),
              );
            case 'youtube':
              return CirillaButtonSocial.youtube(
                size: 34,
                sizeIcon: 14,
                boxFit: boxFit,
                type: typeButton,
                onPressed: () => share(url),
              );
            case 'pinterest':
              return CirillaButtonSocial.pinterest(
                size: 34,
                sizeIcon: 14,
                boxFit: boxFit,
                type: typeButton,
                onPressed: () => share(url),
              );
            default:
              return CirillaButtonSocial.facebook(
                size: 34,
                sizeIcon: 14,
                boxFit: boxFit,
                type: typeButton,
                onPressed: () => share(url),
              );
          }
        }),
      ),
    );
  }

  WrapAlignment wrapAlignment(String type) {
    switch (type) {
      case 'left':
        return WrapAlignment.start;
      case 'right':
        return WrapAlignment.end;
      default:
        return WrapAlignment.center;
    }
  }
}
