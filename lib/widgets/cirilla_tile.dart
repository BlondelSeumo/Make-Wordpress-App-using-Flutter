import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class CirillaTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final double height;
  final bool isChevron;
  final bool isDivider;
  final Color colorDivider;
  final double pad;
  final EdgeInsets padding;
  final GestureTapCallback onTap;

  CirillaTile({
    Key key,
    @required this.title,
    this.leading,
    this.trailing,
    this.height = 58,
    this.isChevron = true,
    this.isDivider = true,
    this.colorDivider,
    this.pad = 16,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: onTap is GestureTapCallback ? null : Colors.transparent,
      highlightColor: onTap is GestureTapCallback ? null : Colors.transparent,
      child: Container(
        height: height,
        padding: padding,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (leading is Widget)
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: pad),
                      child: leading,
                    ),
                  Expanded(child: title),
                  if (trailing is Widget)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: pad),
                      child: trailing,
                    ),
                  if (isChevron)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: pad),
                      child: Icon(
                        FeatherIcons.chevronRight,
                        size: 16,
                      ),
                    ),
                ],
              ),
            ),
            if (isDivider)
              Divider(
                height: 1,
                thickness: 1,
                color: colorDivider,
              ),
          ],
        ),
      ),
    );
  }
}
