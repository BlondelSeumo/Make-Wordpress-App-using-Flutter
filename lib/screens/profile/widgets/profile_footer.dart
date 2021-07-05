import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_button_social.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileFooter extends StatelessWidget with Utility {
  final String copyright;
  final List socials;
  final String lang;

  const ProfileFooter({Key key, this.copyright, this.socials, this.lang}) : super(key: key);

  void share(String url) {
    if (url is String && url != '') {
      launch(url);
    }
  }

  Widget buildSocial({String url, String type, bool enableRound, bool enableOutLine}) {
    SocialType typeButton = enableRound ? SocialType.circle : SocialType.square;
    SocialBoxFit boxFitButton = enableOutLine ? SocialBoxFit.outline : SocialBoxFit.fill;

    switch (type) {
      case 'google':
        return CirillaButtonSocial.google(
          size: 34,
          sizeIcon: 14,
          type: typeButton,
          boxFit: boxFitButton,
          onPressed: () => share(url),
        );
        break;
      case 'twitter':
        return CirillaButtonSocial.twitter(
          size: 34,
          sizeIcon: 14,
          type: typeButton,
          boxFit: boxFitButton,
          onPressed: () => share(url),
        );
        break;
      case 'pinterest':
        return CirillaButtonSocial.pinterest(
          size: 34,
          sizeIcon: 14,
          type: typeButton,
          boxFit: boxFitButton,
          onPressed: () => share(url),
        );
        break;
      case 'linkedin':
        return CirillaButtonSocial.linkedIn(
          size: 34,
          sizeIcon: 14,
          type: typeButton,
          boxFit: boxFitButton,
          onPressed: () => share(url),
        );
        break;
      case 'youtube':
        return CirillaButtonSocial.youtube(
          size: 34,
          sizeIcon: 14,
          type: typeButton,
          boxFit: boxFitButton,
          onPressed: () => share(url),
        );
        break;
      default:
        return CirillaButtonSocial.facebook(
          size: 34,
          sizeIcon: 14,
          type: typeButton,
          boxFit: boxFitButton,
          onPressed: () => share(url),
        );
    }
  }

  Widget buildItem({Map item, int index, int length}) {
    String url = ConvertData.stringFromConfigs(get(item, ['data', 'linkSocial'], ''), lang);
    String type = get(item, ['data', 'typeSocial'], 'facebook');
    bool enableRound = get(item, ['data', 'enableRound'], false);
    bool enableOutLine = get(item, ['data', 'enableOutLine'], true);

    return Padding(
      padding: EdgeInsetsDirectional.only(start: index != 0 ? 16 : 0),
      child: buildSocial(
        url: url,
        type: type,
        enableRound: enableRound,
        enableOutLine: enableOutLine,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(child: Text(copyright, style: theme.textTheme.caption)),
          if (socials.length > 0) ...[
            SizedBox(width: 16),
            Wrap(
              children: List.generate(
                socials.length,
                (index) => buildItem(item: socials[index], index: index, length: socials.length),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
