import 'package:cirilla/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CirillaShimmer extends StatelessWidget {
  final Widget child;

  const CirillaShimmer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    if (isWeb) {
      Container c = child;

      return Container(
        width: c.constraints.minWidth,
        height: c.constraints.minHeight,
        color: color,
      );
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: child,
    );
  }
}
