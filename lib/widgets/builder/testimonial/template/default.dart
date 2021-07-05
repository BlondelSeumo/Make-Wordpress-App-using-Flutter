import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Default extends StatelessWidget with Utility {
  final Map<String, dynamic> item;
  final ShapeBorder shape;
  final Color color;
  final String language;
  final String themeModeKey;

  Default({
    Key key,
    @required this.item,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    this.color,
    this.language = 'en',
    this.themeModeKey = 'value',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    dynamic image = get(item, ['image'], {});

    dynamic title = get(item, ['title'], {});
    dynamic description = get(item, ['description'], {});

    String linkImage = ConvertData.imageFromConfigs(image, language);

    String textTitle = ConvertData.stringFromConfigs(title, language);
    String textDescription = ConvertData.stringFromConfigs(description, language);

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle descriptionStyle = ConvertData.toTextStyle(description, themeModeKey);

    return TestimonialBasicItem(
      image: ImageItem(
        url: linkImage,
        size: Size(72, 72),
      ),
      title: Text(
        textTitle,
        style: theme.textTheme.bodyText1.merge(titleStyle),
      ),
      description: Text(
        textDescription,
        style: theme.textTheme.bodyText1.merge(descriptionStyle),
      ),
      width: 310,
      color: color,
      shape: shape,
    );
  }
}
