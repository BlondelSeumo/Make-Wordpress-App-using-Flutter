import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/post_comment/post_comment_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CommentForm extends StatelessWidget {
  final PostCommentStore commentStore;

  final String type;

  final int parent;

  const CommentForm({Key key, this.type = 'button', this.commentStore, this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 'text') {
      return TextButton(
        child: const Text('Reply'),
        onPressed: () => showModal(context),
        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      );
    }

    return ElevatedButton(
      child: const Text('Comments'),
      onPressed: () => showModal(context),
    );
  }

  void showModal(BuildContext context) async {
    print("Parent: $parent");
    bool success = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (
        BuildContext context,
      ) {
        return ModalReply(commentStore: commentStore, parent: parent);
      },
    );

    if (success != null && success) {
      commentStore.getPostComments();
    }
  }
}

class ModalReply extends StatefulWidget {
  final PostCommentStore commentStore;
  final int parent;

  const ModalReply({Key key, this.commentStore, this.parent}) : super(key: key);

  @override
  _ModalReplyState createState() => _ModalReplyState();
}

class _ModalReplyState extends State<ModalReply> with SnackMixin {
  String _error;
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();
  final txtContent = TextEditingController();

  AuthStore _authStore;

  @override
  void didChangeDependencies() {
    _authStore = Provider.of<AuthStore>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    txtContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 32, bottom: 8),
                      child: Text(
                        'Leave a Reply',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      'Your email address will not be published.\n\nRequired fields are marked *',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: double.infinity,
                        height: 53,
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Your comment is awaiting moderation.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 24)),
                    TextFormField(
                      controller: txtContent,
                      minLines: 5,
                      maxLines: 10,
                      decoration: InputDecoration(labelText: 'Your Comments', alignLabelWithHint: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    if (!_authStore.isLogin)
                      SizedBox(
                        height: 16,
                      ),
                    if (!_authStore.isLogin)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name*',
                        ),
                      ),
                    if (!_authStore.isLogin)
                      SizedBox(
                        height: 16,
                      ),
                    if (!_authStore.isLogin)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email*',
                        ),
                      ),
                    if (!_authStore.isLogin)
                      SizedBox(
                        height: 16,
                      ),
                    if (!_authStore.isLogin)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Website*',
                        ),
                      ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        child: _loading ? CircularProgressIndicator() : const Text('Post Comments'),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                              _error = null;
                            });
                            try {
                              // Write comment
                              await widget.commentStore.writeComment(
                                content: txtContent.text,
                                parent: widget.parent,
                              );
                              setState(() {
                                _loading = false;
                              });
                              Navigator.pop(context, true);
                            } on DioError catch (e) {
                              _error = e.response != null && e.response.data != null
                                  ? e.response.data['message']
                                  : e.message;
                              setState(() {
                                _loading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    if (_error != null) Text(_error, style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            ));
  }
}
