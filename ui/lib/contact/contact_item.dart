import 'package:flutter/material.dart';

abstract class ContactItem extends StatefulWidget {
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;

  const ContactItem({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.color,
  }) : super(key: key);

  @override
  _ContactItemState createState() => _ContactItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColor,
      elevation: widget.elevation ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.color ?? Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}

// import 'package:flutter/material.dart';

// class ContactItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(
//         width: 100,
//         height: 100,
//         child: Center(
//           child: Text('Contact'),
//         ),
//       ),
//     );
//   }
// }
