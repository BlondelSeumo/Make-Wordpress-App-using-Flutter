import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Color? color;

  const Header({Key? key, this.leading, this.trailing, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [leading ?? Container(), trailing ?? Container()],
      ),
    );
  }
}
