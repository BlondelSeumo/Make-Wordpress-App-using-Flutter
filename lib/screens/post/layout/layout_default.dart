import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/post_action.dart';
import '../widgets/post_name.dart';
import '../widgets/post_category.dart';
import '../widgets/post_date.dart';
import '../widgets/post_author.dart';
import '../widgets/post_comment_count.dart';
import '../widgets/post_image.dart';
import '../widgets/post_content.dart';
import '../widgets/post_tag.dart';
import '../widgets/post_comments.dart';

class LayoutDefault extends StatelessWidget with AppBarMixin {
  final Post post;

  LayoutDefault({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * 0.8;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          elevation: 0,
          leading: leading(),
          titleSpacing: 20,
          actions: [PostAction(post: post), SizedBox(width: layoutPadding)],
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: layoutPadding, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: PostCategory(post: post),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, bottom: 8),
          sliver: SliverToBoxAdapter(
            child: PostName(post: post),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, bottom: 24),
          sliver: SliverToBoxAdapter(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              children: [
                PostAuthor(post: post),
                PostCommentCount(post: post),
                PostDate(post: post),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: PostImage(post: post, width: width, height: height)),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, top: 32, bottom: 24),
          sliver: PostContent(post: post),
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 48),
          sliver: SliverToBoxAdapter(
            child: PostTagWidget(post: post, paddingHorizontal: layoutPadding),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, bottom: 24),
          sliver: PostComments(post: post),
        ),
      ],
    );
  }
}
