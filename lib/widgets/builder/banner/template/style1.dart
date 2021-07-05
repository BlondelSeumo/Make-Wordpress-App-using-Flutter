import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style1Item extends StatelessWidget with Utility {
  final Map<String, dynamic> item;
  final Size size;
  final Color background;
  final double radius;
  final Function(Map<String, dynamic> action) onClick;
  final String language;
  final String themeModeKey;

  Style1Item({
    Key key,
    @required this.item,
    @required this.onClick,
    this.size = const Size(375, 330),
    this.background = Colors.transparent,
    this.radius = 0,
    this.language = 'en',
    this.themeModeKey = 'value',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    dynamic image = get(item, ['image'], '');
    bool enableButton = get(item, ['enableButton'], true);
    BoxFit fit = ConvertData.toBoxFit(get(item, ['imageSize'], 'cover'));

    dynamic title = get(item, ['text1'], {});
    dynamic subTitle = get(item, ['text2'], {});
    dynamic button = get(item, ['textButton'], {});
    Map<String, dynamic> action = get(item, ['action'], {});

    String linkImage = ConvertData.imageFromConfigs(image, language);

    String textTitle = ConvertData.stringFromConfigs(title, language);
    String textSubTitle = ConvertData.stringFromConfigs(subTitle, language);
    String textButton = ConvertData.stringFromConfigs(button, language);

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle subtitleStyle = ConvertData.toTextStyle(subTitle, themeModeKey);
    TextStyle buttonStyle = ConvertData.toTextStyle(button, themeModeKey);

    String typeAction = get(action, ['type'], 'none');

    return Container(
      width: size.width,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ImageFooterItem(
        image: ImageItem(url: linkImage, size: size, fit: fit),
        title: title.length > 0
            ? Text(
                textTitle,
                style: theme.textTheme.bodyText1.merge(titleStyle),
                textAlign: TextAlign.center,
              )
            : null,
        subTitle: Text(
          textSubTitle,
          style: theme.textTheme.bodyText1.merge(subtitleStyle),
          textAlign: TextAlign.center,
        ),
        footer: enableButton
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                color: buttonStyle?.backgroundColor ?? Colors.black,
                child: Text(
                  textButton,
                  style: theme.textTheme.bodyText1.merge(buttonStyle),
                ),
              )
            : Container(),
        width: size.width,
        onTap: () => typeAction != 'none' ? onClick(action) : null,
      ),
    );
  }
}
