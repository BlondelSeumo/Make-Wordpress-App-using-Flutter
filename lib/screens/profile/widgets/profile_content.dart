import 'package:flutter/material.dart';

abstract class ProfileContent extends StatefulWidget {
  final String phone;
  final Widget footer;

  const ProfileContent({
    Key key,
    this.phone,
    this.footer,
  }) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();

  @protected
  Widget buildInfo(
    BuildContext context, {
    @required String title,
    @required Widget child,
  }) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.subtitle2),
          if (child is Widget)
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: child,
            ),
        ],
      ),
    );
  }

  @protected
  Widget buildLayout(BuildContext context);
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.buildLayout(context),
        if (widget.footer is Widget)
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: widget.footer,
          ),
        SizedBox(height: 24),
      ],
    );
  }
}
