import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:cirilla/models/post/post_comment.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/post_comment/post_comment_store.dart';
import 'package:cirilla/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ui/ui.dart';

import 'comment_form.dart';

class Comments extends StatefulWidget {
  final int post;
  final PostComment parent;
  final top;
  final RequestHelper requestHelper;

  Comments({Key key, this.post, this.parent, this.requestHelper, this.top}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  PostCommentStore _commentStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentStore = PostCommentStore(
      widget.requestHelper,
      post: widget.post,
      parent: widget.parent != null ? widget.parent.id : 0,
    )..getPostComments();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_commentStore.loading) {
          return buildLoading(top: widget.top, context: context);
        }

        List<PostComment> _comments = _commentStore.postComments;

        if (widget.top == 0) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Render button Read more and Comments
                if (index == _comments.length) {
                  return buildMore(top: widget.top);
                }

                // Render comment Item
                final comment = _comments[index];
                return buildItem(comment: comment, first: index == 0);
              },
              childCount: _comments.length + 1,
            ),
          );
        }

        return Container(
          child: _comments.length > 0
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _a1, _a2) => CommentsModal(
                          requestHelper: widget.requestHelper,
                          post: widget.post,
                          parent: widget.parent,
                        ),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Row(children: [
                    Icon(Icons.subdirectory_arrow_right_rounded),
                    Text("${_comments.length} Feedback"),
                  ]),
                )
              : Container(),
        );
      },
    );
  }

  Widget buildLoading({BuildContext context, int top}) {
    if (widget.top == 0) {
      return SliverToBoxAdapter(
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 30.0,
        ),
      );
    }

    return SpinKitThreeBounce(
      color: Theme.of(context).primaryColor,
      size: 30.0,
    );
  }

  Widget buildMore({int top = 0}) {
    return Container(
      padding: EdgeInsetsDirectional.only(end: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_commentStore.canLoadMore)
            OutlinedButton(
              onPressed: () => _commentStore.getPostComments(),
              child: Text('Show more'),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              ),
            ),
          if (_commentStore.canLoadMore) SizedBox(width: 16),
          CommentForm(commentStore: _commentStore),
        ],
      ),
    );
  }

  Widget buildItem({PostComment comment, bool first}) {
    return Container(
      child: Column(
        children: [
          first ? Divider(height: 24) : Divider(height: 24),
          CommentHorizontalItem(
            name: Text(
              comment.authorName,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            image: comment.avatar.large,
            onClick: () => {},
            comment: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Html(
                data: comment.content.rendered,
              ),
            ),
            date: Text(formatDate(date: comment.date), style: Theme.of(context).textTheme.caption),
            reply: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommentForm(type: 'text', commentStore: _commentStore, parent: comment.id),
                if (comment.children)
                  Comments(
                    post: comment.post,
                    requestHelper: widget.requestHelper,
                    parent: comment,
                    top: 1,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentsModal extends StatelessWidget with AppBarMixin {
  final int post;
  final PostComment parent;
  final RequestHelper requestHelper;

  const CommentsModal({Key key, this.post, this.parent, this.requestHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: leading(),
              title: Text("Comment"),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: layoutPadding),
                child: CommentHorizontalItem(
                  name: Text(
                    parent.authorName,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  image: parent.avatar.large,
                  onClick: () => {},
                  comment: Html(
                    data: parent.content.rendered,
                  ),
                  date: Text(
                    parent.date,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsDirectional.only(start: itemPadding * 5, end: layoutPadding),
              sliver: Comments(
                requestHelper: requestHelper,
                post: post,
                parent: parent,
                top: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
