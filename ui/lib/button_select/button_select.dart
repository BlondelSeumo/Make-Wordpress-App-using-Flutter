import 'package:flutter/material.dart';
import 'dart:ui';

class ButtonSelect extends StatelessWidget {
  final Widget? child;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final GestureTapCallback? onTap;
  final Color color;
  final Color colorSelect;
  final bool isSelect;

  ButtonSelect({
    Key? key,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.color = const Color(0xFFDEE2E6),
    this.colorSelect = const Color(0xFF0686F8),
    this.isSelect = false,
    this.onTap,
  }) : super(key: key);

  factory ButtonSelect.icon({
    Key? key,
    EdgeInsets padding,
    BorderRadius borderRadius,
    Color color,
    Color colorSelect,
    bool isSelect,
    GestureTapCallback? onTap,
    IconData nameIcon,
    Color colorIcon,
    Widget? child,
  }) = _ButtonSelectIcon;

  factory ButtonSelect.filter({
    Key? key,
    EdgeInsets padding,
    BorderRadius borderRadius,
    Color color,
    Color colorSelect,
    bool isSelect,
    GestureTapCallback? onTap,
    IconData nameIcon,
    Color colorIcon,
    Widget? child,
  }) = _ButtonSelectFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: buildContent(),
    );
  }

  Widget buildContent() {
    double widthBorder = isSelect ? 2 : 1;
    Color colorBorder = isSelect ? colorSelect : color;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(width: widthBorder, color: colorBorder),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _ButtonSelectIcon extends ButtonSelect {
  final IconData nameIcon;
  final Color colorIcon;

  _ButtonSelectIcon({
    Key? key,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    Color color = const Color(0xFFDEE2E6),
    Color colorSelect = const Color(0xFF0686F8),
    bool isSelect = false,
    GestureTapCallback? onTap,
    Widget? child,
    this.nameIcon = Icons.check,
    this.colorIcon = Colors.white,
  }) : super(
          key: key,
          padding: padding,
          borderRadius: borderRadius,
          color: color,
          colorSelect: colorSelect,
          isSelect: isSelect,
          onTap: onTap,
          child: child,
        );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isSelect ? buildIconCheck(child: buildContent()) : buildContent(),
    );
  }

  Widget buildIconCheck({Widget? child}) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12, right: 12),
          child: child,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorSelect,
              shape: BoxShape.circle,
            ),
            child: Icon(
              nameIcon,
              color: colorIcon,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonSelectFilter extends ButtonSelect {
  final IconData nameIcon;
  final Color colorIcon;

  _ButtonSelectFilter({
    Key? key,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
    Color color = const Color(0xFFFF4F4F4),
    Color colorSelect = const Color(0xFF0686F8),
    bool isSelect = false,
    GestureTapCallback? onTap,
    Widget? child,
    this.nameIcon = Icons.close,
    this.colorIcon = Colors.white,
  }) : super(
          key: key,
          padding: padding,
          borderRadius: borderRadius,
          color: color,
          colorSelect: colorSelect,
          isSelect: isSelect,
          onTap: onTap,
          child: child,
        );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: isSelect ? buildIconCheck(child: buildContent()) : buildContent(),
      ),
    );
  }

  Widget buildContent() {
    Color colorBorder = isSelect ? colorSelect : color;
    Color background = isSelect ? Colors.transparent : color;

    return Container(
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        border: Border.all(width: 1, color: colorBorder),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }

  Widget buildIconCheck({required Widget child}) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 1,
          right: 1,
          child: CustomPaint(
            size: Size(24, 24),
            painter: DrawTriangleShape(color: colorSelect),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Icon(
                  nameIcon,
                  size: 12,
                  color: colorIcon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  // Paint painter;
  Color color;

  DrawTriangleShape({
    this.color = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
