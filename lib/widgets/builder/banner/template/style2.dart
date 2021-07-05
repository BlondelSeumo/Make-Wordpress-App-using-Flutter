import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style2Item extends StatelessWidget with Utility {
  final Map<String, dynamic> item;
  final Size size;
  final Color background;
  final double radius;
  final Function(Map<String, dynamic> action) onClick;
  final String language;
  final String themeModeKey;

  Style2Item({
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
    dynamic title = get(item, ['text1'], {});
    Map<String, dynamic> action = get(item, ['action'], {});

    String linkImage = ConvertData.imageFromConfigs(image, language);

    String textTitle = ConvertData.stringFromConfigs(title, language);
    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);

    String typeAction = get(action, ['type'], 'none');

    return Container(
      width: size.width,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ImageFooterItem(
        image: ImageItem(url: linkImage, size: size, fit: fit),
        footer: Text(
          textTitle,
          style: theme.textTheme.bodyText1.merge(titleStyle),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: size.width,
        onTap: () => typeAction != 'none' ? onClick(action) : null,
      ),
    );
  }
}
