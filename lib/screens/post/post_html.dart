import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:flutter/material.dart';

import 'layout/layout_default.dart';
import 'layout/layout_curve_top.dart';
import 'layout/layout_curve_bottom.dart';
import 'layout/layout_overlay.dart';
import 'layout/layout_gradient.dart';
import 'layout/layout_stack.dart';
import 'layout/layout_layer.dart';

class PostHtml extends StatelessWidget {
  final Post post;
  final String layout;

  const PostHtml({Key key, @required this.post, this.layout = Strings.postDetailLayoutDefault}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (layout) {
      case Strings.postDetailLayoutCurveTop:
        return LayoutCurveTop(post: post);
        break;
      case Strings.postDetailLayoutCurveBottom:
        return LayoutCurveBottom(post: post);
        break;
      case Strings.postDetailLayoutOverlay:
        return LayoutOverlay(post: post);
        break;
      case Strings.postDetailLayoutGradient:
        return LayoutGradient(post: post);
        break;
      case Strings.postDetailLayoutStack:
        return LayoutStack(post: post);
        break;
      case Strings.postDetailLayoutLayer:
        return LayoutLayer(post: post);
        break;
      default:
        return LayoutDefault(post: post);
    }
  }
}
