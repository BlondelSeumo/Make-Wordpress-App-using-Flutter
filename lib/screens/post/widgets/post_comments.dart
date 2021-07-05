import 'package:cirilla/models/models.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../comments.dart';

class PostComments extends StatelessWidget {
  final Post post;

  PostComments({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Comments(
      post: post.id,
      requestHelper: Provider.of<RequestHelper>(context),
      top: 0,
    );
  }
}
