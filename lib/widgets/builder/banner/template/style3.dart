import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style3Item extends StatelessWidget with Utility {
  final Map<String, dynamic> item;
  final Size size;
  final Color background;
  final double radius;
  final Function(Map<String, dynamic> action) onClick;
  final String language;
  final String themeModeKey;

  Style3Item({
    Key key,
    @required this.item,
    @required this.onClick,
    this.language = 'en',
    this.themeModeKey = 'value',
    this.size = const Size(375, 330),
    this.background = Colors.transparent,
    this.radius = 0,
  }) : super(key: key);

  Widget buildContent({maxWidth: double, child}) {
    return SizedBox(
      width: maxWidth,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    dynamic image = get(item, ['image'], '');
    BoxFit fit = ConvertData.toBoxFit(get(item, ['imageSize'], 'cover'));
    bool enableButton = get(item, ['enableButton'], true);
    Map<String, dynamic> action = get(item, ['action'], {});

    String linkImage = ConvertData.imageFromConfigs(image, language);

    dynamic title = get(item, ['text1'], {});
    dynamic subTitle = get(item, ['text2'], {});
    dynamic button = get(item, ['textButton'], {});

    String textTitle = ConvertData.stringFromConfigs(title, language);
    String textSubTitle = ConvertData.stringFromConfigs(subTitle, language);
    String textButton = ConvertData.stringFromConfigs(button, language);

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle subtitleStyle = ConvertData.toTextStyle(subTitle, themeModeKey);
    TextStyle buttonStyle = ConvertData.toTextStyle(button, themeModeKey);

    String typeAction = get(action, ['type'], 'none');

    double maxWidth = size.width / 2;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ImageAlignmentItem(
        image: ImageItem(url: linkImage, size: size, fit: fit),
        title: buildContent(
          maxWidth: maxWidth,
          child: Text(
            textTitle,
            style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal, fontSize: 40).merge(titleStyle),
          ),
        ),
        trailing: enableButton
            ? Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                color: buttonStyle.backgroundColor,
                child: Text(
                  textButton,
                  style: theme.textTheme.bodyText1.merge(buttonStyle),
                ),
              )
            : null,
        leading: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: subtitleStyle?.backgroundColor ?? Colors.transparent,
          child: Text(
            textSubTitle,
            style: theme.textTheme.bodyText1.merge(subtitleStyle),
          ),
        ),
        crossAxisAlignment: CrossAxisAlignment.start,
        width: size.width,
        onTap: () => typeAction != 'none' ? onClick(action) : null,
      ),
    );
  }
}
