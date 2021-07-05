import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/screens/post/widgets/post_action.dart';
import 'package:cirilla/screens/post/widgets/post_image.dart';
import 'package:flutter/material.dart';

import '../widgets/post_name.dart';
import '../widgets/post_category.dart';
import '../widgets/post_date.dart';
import '../widgets/post_author.dart';
import '../widgets/post_comment_count.dart';
import '../widgets/post_content.dart';
import '../widgets/post_tag.dart';
import '../widgets/post_comments.dart';

class LayoutStack extends StatelessWidget with AppBarMixin {
  final Post post;

  LayoutStack({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildAppbar(context),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, top: 24, bottom: 16),
          sliver: SliverToBoxAdapter(
            child: PostCategory(post: post),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, bottom: 16),
          sliver: SliverToBoxAdapter(child: PostName(post: post)),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, bottom: 32),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  children: [
                    PostAuthor(post: post),
                    PostCommentCount(post: post),
                    PostDate(post: post),
                  ],
                ),
                SizedBox(height: 24),
                Divider(height: 1, thickness: 1),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: layoutPadding, right: layoutPadding, bottom: 24),
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

  Widget buildAppbar(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;

    double widthLeft = 92;
    double widthImage = width - widthLeft;
    double heightImage = (widthImage * 292) / 284;

    return SliverAppBar(
      expandedHeight: heightImage - paddingTop,
      stretch: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
        ],
        centerTitle: true,
        background: Container(
          width: width,
          height: heightImage,
          child: Row(
            children: [
              Container(
                width: widthLeft,
                child: Column(
                  children: [
                    SizedBox(height: 44),
                    leadingPined(),
                    SizedBox(height: 32),
                    PostAction(post: post, axis: Axis.vertical),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
                  child: PostImage(post: post, width: widthImage, height: double.infinity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
