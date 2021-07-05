import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/screens/post/post.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

List<BoxShadow> defaultShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    offset: Offset(0, 4),
    blurRadius: 24,
    spreadRadius: 0,
  ),
];

class CirillaPostItem extends StatelessWidget with PostMixin, Utility {
  // Template item style
  final Map<String, dynamic> template;

  // Position item on list view
  final int index;

  final Post post;

  final double width;

  final double height;

  final Color background;

  final Color textColor;

  final Color subTextColor;

  final Color labelColor;

  final Color labelTextColor;

  final double radius;

  final List<BoxShadow> boxShadow;

  final Border border;

  const CirillaPostItem({
    Key key,
    this.template,
    this.index,
    this.post,
    this.width,
    this.height,
    this.background = Colors.transparent,
    this.textColor,
    this.subTextColor,
    this.labelColor,
    this.labelTextColor,
    this.boxShadow,
    this.border,
    this.radius,
  }) : super(key: key);

  void navigate(BuildContext context) {
    if (post.id == null) {
      return;
    }

    Navigator.of(context).pushNamed(PostScreen.routeName, arguments: {'post': post});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';

    if (template == null) return Container();

    String temp = get(template, ['template'], Strings.postItemContained);

    BoxFit fit = ConvertData.toBoxFit(get(template, ['data', 'imageSize'], 'fit'));
    // bool enableDescription = get(template, ['data', 'enableDescription'], true);
    bool enableCategory = get(template, ['data', 'enableCategory'], true);
    bool enableDate = get(template, ['data', 'enableDate'], true);
    bool enableAuthor = get(template, ['data', 'enableAuthor'], true);
    bool enableComments = get(template, ['data', 'enableComments'], true);

    switch (temp) {
      case Strings.postItemVertical:
        return PostVerticalItem(
          image: buildImage(post, width: width, height: height, fit: fit),
          name: buildName(theme, post, textColor),
          category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor) : null,
          width: width ?? 335,
          color: background,
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow ?? defaultShadow,
          onClick: () => navigate(context),
        );
        break;
      case Strings.postItemVerticalCenter:
        return PostVerticalCenterItem(
          image: buildImage(post, width: width, height: height, fit: fit),
          name: buildName(theme, post, textColor),
          category: enableCategory ? buildCategory(theme, post, true, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor) : null,
          width: width ?? 335,
          color: background,
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow ?? defaultShadow,
          onClick: () => navigate(context),
        );
        break;
      case Strings.postItemHorizontal:
        String alignment = get(template, ['data', 'alignment'], 'left');
        double widthImage = 120;
        double heightImage = (widthImage * height) / width;

        return Column(
          children: [
            PostHorizontalItem(
              image: buildImage(post, width: widthImage, height: heightImage, fit: fit, borderRadius: radius),
              name: buildName(theme, post, textColor),
              category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
              date: enableDate ? buildDate(theme, post, subTextColor) : null,
              author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
              comment: enableComments ? buildComment(theme, post, subTextColor) : null,
              padding: EdgeInsets.symmetric(vertical: 24),
              isRightImage: (alignment == 'zigzag' && index % 2 == 1) || alignment == 'right',
              color: background,
              border: border,
              borderRadius: BorderRadius.circular(radius ?? 0),
              boxShadow: boxShadow,
              onClick: () => navigate(context),
            ),
          ],
        );
        break;
      case Strings.postItemNumber:
        String strNumber = index > 8 ? {index + 1}.toString() : '0${index + 1}';

        return Column(
          children: [
            PostNumberItem(
              number: Text(
                strNumber,
                style: theme.textTheme.headline3.copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = theme.primaryColor,
                ),
              ),
              name: buildName(theme, post, textColor),
              category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
              date: enableDate ? buildDate(theme, post, subTextColor) : null,
              author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
              comment: enableComments ? buildComment(theme, post, subTextColor) : null,
              color: background,
              border: border,
              borderRadius: BorderRadius.circular(radius ?? 0),
              boxShadow: boxShadow,
              padding: EdgeInsets.symmetric(vertical: 24),
              onClick: () => navigate(context),
            ),
          ],
        );
        break;
      case Strings.postItemEmerge:
        return PostEmergeItem(
          image: buildImage(post, width: width, height: height, fit: fit),
          name: buildName(theme, post, textColor),
          category: enableCategory ? buildCategory(theme, post, true, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor) : null,
          width: width ?? 335,
          heightEmerge: height - 45,
          color: background,
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow ?? defaultShadow,
          onClick: () => navigate(context),
        );
        break;
      case Strings.postItemOverlay:
        Color colorLine =
            ConvertData.fromRGBA(get(template, ['data', 'colorLine', themeModeKey], {}), theme.dividerColor);
        Color color = ConvertData.fromRGBA(get(template, ['data', 'color', themeModeKey], {}), Colors.black);
        double opacity = ConvertData.stringToDouble(get(template, ['data', 'opacity'], 0.5));

        return PostOverlayItem(
          image: buildImage(post, width: width, height: height, fit: fit),
          name: buildName(theme, post, textColor ?? Colors.white),
          category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor ?? Colors.white) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor ?? Colors.white) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor ?? Colors.white) : null,
          background: color,
          colorLine: colorLine,
          opacity: opacity,
          color: background,
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow,
          onClick: () => navigate(context),
        );
        break;
      case Strings.postItemTopName:
        double widthImage = width - 32;
        double heightImage = (widthImage * height) / width;

        return PostTopNameItem(
          image: buildImage(post, width: widthImage, height: heightImage, fit: fit, borderRadius: radius),
          name: buildName(theme, post, textColor),
          category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor) : null,
          padding: EdgeInsets.all(16),
          color: background,
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow ?? defaultShadow,
          width: width,
          onClick: () => navigate(context),
        );
        break;
      case Strings.postItemTimeLine:
        bool enableImageAuthor = get(template, ['data', 'enableImageAuthor'], true);
        double widthImage = width - PostTimeLineItem.widthLeft - 32;
        double heightImage = (widthImage * height) / width;

        return PostTimeLineItem(
          image: buildImage(post, width: widthImage, height: heightImage, fit: fit, borderRadius: radius),
          name: buildName(theme, post, textColor),
          category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
          headingInfo: Row(
            children: [
              if (enableImageAuthor) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(Assets.noImageUrl, width: 40, height: 40),
                ),
                SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (post.author != null)
                      Text(post.postAuthor,
                          style: theme.textTheme.subtitle2.copyWith(color: textColor, fontWeight: FontWeight.w500)),
                    enableDate ? buildDate(theme, post, subTextColor) : null,
                  ],
                ),
              )
            ],
          ),
          left: Padding(
            padding: EdgeInsetsDirectional.only(start: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    enableComments ? buildComment(theme, post, null, 20) : null,
                    SizedBox(height: 24),
                    Icon(FeatherIcons.bookmark, size: 20),
                    SizedBox(height: 24),
                    Icon(FeatherIcons.upload, size: 20),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 102,
                  width: 1,
                  color: theme.dividerColor,
                  margin: EdgeInsetsDirectional.only(start: 10),
                ),
              ],
            ),
          ),
          color: background,
          border: border,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(radius ?? 8), bottomLeft: Radius.circular(radius ?? 8)),
          boxShadow: boxShadow ?? defaultShadow,
          onClick: () => navigate(context),
        );
        break;
      case Strings.postItemGradient:
        Color colorBegin =
            ConvertData.fromRGBA(get(template, ['data', 'colorBegin', themeModeKey], {}), Colors.transparent);
        Color colorEnd = ConvertData.fromRGBA(get(template, ['data', 'colorEnd', themeModeKey], {}), Colors.black);
        Alignment begin = ConvertData.toAlignment(get(template, ['data', 'begin'], 'top-center'));
        Alignment end = ConvertData.toAlignment(get(template, ['data', 'end'], 'bottom-center'));
        double opacity = ConvertData.stringToDouble(get(template, ['data', 'opacity'], 0.9));

        LinearGradient gradient = LinearGradient(
          begin: begin,
          end: end, // 10% of the width, so there are ten blinds.
          colors: <Color>[colorBegin, colorEnd], // red to yellowepeats the gradient over the canvas
        );

        return PostGradientItem(
          image: buildImage(post, width: width, height: height, fit: fit),
          name: buildName(theme, post, textColor ?? Colors.white),
          category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor ?? Colors.white) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor ?? Colors.white) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor ?? Colors.white) : null,
          gradient: gradient,
          opacity: opacity,
          color: background,
          border: border,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: boxShadow,
          onClick: () => navigate(context),
        );
        break;
      default:
        return PostContainedItem(
          image: buildImage(post, width: width, height: height, fit: fit, borderRadius: radius),
          name: buildName(theme, post, textColor),
          category: enableCategory ? buildCategory(theme, post, false, labelColor, labelTextColor) : null,
          date: enableDate ? buildDate(theme, post, subTextColor) : null,
          author: enableAuthor ? buildAuthor(theme, post, subTextColor) : null,
          comment: enableComments ? buildComment(theme, post, subTextColor) : null,
          width: width ?? 335,
          color: background,
          boxShadow: boxShadow,
          border: border,
          onClick: () => navigate(context),
        );
    }
  }
}
