import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder_item/image_item.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Style2 extends StatelessWidget with Utility {
  final Map<String, dynamic> item;
  final ShapeBorder shape;
  final Color color;
  final String language;
  final String themeModeKey;

  Style2({
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
    dynamic subtitle = get(item, ['subtitle'], {});
    dynamic description = get(item, ['description'], {});
    dynamic rating = get(item, ['rating'], 0);

    String linkImage = ConvertData.imageFromConfigs(image, language);
    double valueRating = ConvertData.stringToDouble(rating);

    String textTitle = ConvertData.stringFromConfigs(title, language);
    String textSubtitle = ConvertData.stringFromConfigs(subtitle, language);
    String textDescription = ConvertData.stringFromConfigs(description, language);

    TextStyle titleStyle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle subtitleStyle = ConvertData.toTextStyle(textSubtitle, themeModeKey);
    TextStyle descriptionStyle = ConvertData.toTextStyle(description, themeModeKey);

    return TestimonialHorizontalItem(
      image: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ImageItem(
          url: linkImage,
          size: Size(60, 60),
        ),
      ),
      title: Text(
        textTitle,
        style: theme.textTheme.bodyText1.merge(titleStyle),
      ),
      description: Text(
        textDescription,
        style: theme.textTheme.bodyText1.merge(descriptionStyle),
      ),
      subtitle: Text(
        textSubtitle,
        style: theme.textTheme.bodyText1.merge(subtitleStyle),
      ),
      rating: CirillaRating(initialValue: valueRating),
      width: 310,
      color: color,
      shape: shape,
    );
  }
}
