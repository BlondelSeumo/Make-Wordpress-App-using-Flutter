import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/utils/date_format.dart';
import 'package:cirilla/widgets/cirilla_shimmer.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

mixin PostMixin {
  Widget buildName(ThemeData theme, Post post, [Color color]) {
    if (post.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 24,
          width: 324,
          color: Colors.white,
        ),
      );
    }
    return Text(
      post.postTitle,
      style: theme.textTheme.subtitle1.copyWith(color: color),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildCategory(ThemeData theme, Post post, [bool isCenter = false, Color background, Color color]) {
    if (post.id == null) {
      return Container();
    }
    EdgeInsetsGeometry padding =
        isCenter == true ? EdgeInsets.symmetric(horizontal: 4) : EdgeInsetsDirectional.only(end: 8);
    return Wrap(
      children: List.generate(
        post.postCategories.length,
        (int index) => Padding(
          padding: padding,
          child: Badge(
            text: Text(
              post.postCategories[index].name.toUpperCase(),
              style: theme.textTheme.overline.copyWith(color: color ?? Colors.white),
            ),
            color: background ?? Color(0xFF21BA45),
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ).toList(),
    );
  }

  Widget buildDate(ThemeData theme, Post post, [Color color]) {
    if (post.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 16,
          width: 94,
          color: Colors.white,
        ),
      );
    }

    return Text(formatDate(date: post.date), style: theme.textTheme.caption.copyWith(color: color));
  }

  Widget buildAuthor(ThemeData theme, Post post, [Color color]) {
    if (post.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 16,
          width: 50,
          color: Colors.white,
        ),
      );
    }
    return InkWell(
      onTap: () => print('click author'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FeatherIcons.feather,
            size: 14,
            color: color,
          ),
          SizedBox(width: 8),
          Text(post.postAuthor, style: theme.textTheme.caption.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget buildComment(ThemeData theme, Post post, [Color color, double size]) {
    if (post.id == null) {
      return CirillaShimmer(
        child: Container(
          height: 16,
          width: 50,
          color: Colors.white,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          FeatherIcons.messageCircle,
          size: size ?? 14,
          color: color,
        ),
        SizedBox(width: 8),
        Text('${post.postCommentCount}', style: theme.textTheme.caption.copyWith(color: color)),
      ],
    );
  }

  Widget buildImage(
    Post post, {
    double width = 200,
    double height = 200,
    double borderRadius = 0,
    BoxFit fit = BoxFit.cover,
  }) {
    if (post.id == null) {
      return CirillaShimmer(
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: ImageLoading(
        post.thumbMedium,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
