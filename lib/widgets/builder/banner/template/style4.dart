import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style4Item extends StatelessWidget with Utility {
  final Map<String, dynamic> item;
  final Size size;
  final Color background;
  final double radius;
  final Function(Map<String, dynamic> action) onClick;
  final String language;
  final String themeModeKey;

  Style4Item({
    Key key,
    @required this.item,
    @required this.onClick,
    this.language = 'en',
    this.themeModeKey = 'value',
    this.size = const Size(375, 330),
    this.background = Colors.transparent,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    dynamic image = get(item, ['image'], '');
    BoxFit fit = ConvertData.toBoxFit(get(item, ['imageSize'], 'cover'));
    Map<String, dynamic> action = get(item, ['action'], {});

    String linkImage = ConvertData.imageFromConfigs(image, language);

    dynamic title = get(item, ['text1'], {});
    dynamic subTitle = get(item, ['text2'], {});

    String textTitle = ConvertData.stringFromConfigs(title, language);
    String textSubTitle = ConvertData.stringFromConfigs(subTitle, language);

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle subtitleStyle = ConvertData.toTextStyle(subTitle, themeModeKey);

    String typeAction = get(action, ['type'], 'none');

    return Container(
      width: size.width,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ImageAlignmentItem(
        image: ImageItem(url: linkImage, size: size, fit: fit),
        title: Text(
          textTitle,
          style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal).merge(titleStyle),
          textAlign: TextAlign.center,
        ),
        trailing: Text(
          textSubTitle,
          style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal).merge(subtitleStyle),
          textAlign: TextAlign.center,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        width: size.width,
        onTap: () => typeAction != 'none' ? onClick(action) : null,
      ),
    );
  }
}
