import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialBoxFit {
  fill,
  outline,
}
enum SocialType { circle, square }

class CirillaButtonSocial extends StatelessWidget {
  final IconData icon;
  final double size;
  final double sizeIcon;
  final Color color;
  final VoidCallback onPressed;
  final SocialBoxFit boxFit;
  final SocialType type;
  final double wRadius;

  CirillaButtonSocial({
    Key key,
    @required this.icon,
    this.size = 48,
    this.sizeIcon = 18,
    this.color = Colors.black,
    this.onPressed,
    this.boxFit = SocialBoxFit.fill,
    this.type = SocialType.circle,
    this.wRadius = 4,
  }) : super(key: key);

  factory CirillaButtonSocial.facebook({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialFacebook;

  factory CirillaButtonSocial.google({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialGoogle;

  factory CirillaButtonSocial.sms({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialSms;

  factory CirillaButtonSocial.apple({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialApple;

  factory CirillaButtonSocial.twitter({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialTwitter;

  factory CirillaButtonSocial.pinterest({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialPinterest;

  factory CirillaButtonSocial.linkedIn({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialLinkedIn;

  factory CirillaButtonSocial.youtube({
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) = _CirillaButtonSocialYouTube;

  Widget buildContainer(
    BuildContext context, {
    double size,
    Color color,
    VoidCallback onPressed,
    SocialBoxFit boxFit,
    SocialType type,
    Widget icon,
  }) {
    ThemeData theme = Theme.of(context);
    Color background = boxFit == SocialBoxFit.outline ? Colors.transparent : color;

    double radius = type == SocialType.square ? wRadius : size / 2;

    BorderRadius borderRadius = BorderRadius.circular(radius);
    Decoration decoration = BoxDecoration(
      color: background,
      border: boxFit == SocialBoxFit.outline ? Border.all(width: 1, color: theme.dividerColor) : null,
      borderRadius: borderRadius,
    );

    return InkWell(
      borderRadius: borderRadius,
      onTap: () => onPressed(),
      child: Container(
        width: size,
        height: size,
        decoration: decoration,
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }

  Widget buildIcon({IconData icon, double size, Color color, SocialBoxFit boxFit}) {
    Color colorIcon = boxFit == SocialBoxFit.outline ? color : Colors.white;
    return Icon(
      icon,
      size: size,
      color: colorIcon,
    );
  }

  Widget builderIcon(BuildContext context, Color colorItem) {
    ThemeData theme = Theme.of(context);
    Color background = boxFit == SocialBoxFit.outline ? Colors.transparent : colorItem;
    Color colorIcon = boxFit == SocialBoxFit.outline ? colorItem : Colors.white;
    double radius = type == SocialType.square ? 4 : size / 2;
    Decoration decoration = BoxDecoration(
      color: background,
      border: boxFit == SocialBoxFit.outline ? Border.all(width: 1, color: theme.dividerColor) : null,
      borderRadius: BorderRadius.circular(radius),
    );

    return Ink(
      width: size,
      height: size,
      decoration: decoration,
      child: IconButton(
        icon: Icon(
          icon,
          size: sizeIcon,
          color: colorIcon,
        ),
        onPressed: onPressed,
        splashRadius: size / 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: color,
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: color, size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialFacebook extends CirillaButtonSocial {
  _CirillaButtonSocialFacebook({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon is IconData
              ? icon
              : boxFit == SocialBoxFit.outline
                  ? FontAwesomeIcons.facebookSquare
                  : FontAwesomeIcons.facebook,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xff3B5999),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xff3B5999), size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialGoogle extends CirillaButtonSocial {
  _CirillaButtonSocialGoogle({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon is IconData
              ? icon
              : boxFit == SocialBoxFit.outline
                  ? FontAwesomeIcons.googlePlusG
                  : FontAwesomeIcons.googlePlus,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xffDD4B39),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xffDD4B39), size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialSms extends CirillaButtonSocial {
  _CirillaButtonSocialSms({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.solidComment,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xff0686F8),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xff0686F8), size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialApple extends CirillaButtonSocial {
  _CirillaButtonSocialApple({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.apple,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Colors.black,
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Colors.black, size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialTwitter extends CirillaButtonSocial {
  _CirillaButtonSocialTwitter({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.twitter,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xFF1DA1F2),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xFF1DA1F2), size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialPinterest extends CirillaButtonSocial {
  _CirillaButtonSocialPinterest({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.pinterest,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xFFc8232c),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xFFc8232c), size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialLinkedIn extends CirillaButtonSocial {
  _CirillaButtonSocialLinkedIn({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.linkedin,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xFF0e76a8),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xFF0e76a8), size: sizeIcon, boxFit: boxFit),
    );
  }
}

class _CirillaButtonSocialYouTube extends CirillaButtonSocial {
  _CirillaButtonSocialYouTube({
    Key key,
    double size,
    double sizeIcon,
    VoidCallback onPressed,
    IconData icon,
    SocialBoxFit boxFit,
    SocialType type,
  }) : super(
          key: key,
          size: size ?? 48,
          sizeIcon: sizeIcon ?? 18,
          onPressed: onPressed,
          icon: icon ?? FontAwesomeIcons.youtube,
          boxFit: boxFit ?? SocialBoxFit.fill,
          type: type ?? SocialType.circle,
        );

  @override
  Widget build(BuildContext context) {
    return buildContainer(
      context,
      size: size,
      color: Color(0xFFfb0002),
      onPressed: onPressed,
      boxFit: boxFit,
      type: type,
      icon: buildIcon(icon: icon, color: Color(0xFFfb0002), size: sizeIcon, boxFit: boxFit),
    );
  }
}
