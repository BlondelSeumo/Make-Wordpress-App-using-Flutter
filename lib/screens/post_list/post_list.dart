import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/post/post_category.dart';
import 'package:cirilla/store/post/post_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'widgets/body.dart';
import 'widgets/refine.dart';
import 'widgets/sort.dart';

class PostListScreen extends StatefulWidget {
  static const routeName = '/post_list';

  final SettingStore store;
  final Map<String, dynamic> args;

  const PostListScreen({Key key, this.store, this.args}) : super(key: key);

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PostStore _postStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _postStore = PostStore(widget.store.requestHelper);

    if (widget.args != null && widget.args['id'] != null && widget.args['name'] != null) {
      _postStore.onChanged(
        categorySelected: [PostCategory(id: widget.args['id'], name: widget.args['name'])],
        silent: true,
      );
    }

    if (widget.args != null && widget.args['category'] != null && widget.args['category'].runtimeType == PostCategory) {
      _postStore.onChanged(categorySelected: [widget.args['category']], silent: true);
    }

    if (widget.args != null && widget.args['tag'] != null && widget.args['tag'].runtimeType == PostTag) {
      _postStore.onChanged(tagSelected: [widget.args['tag']], silent: true);
    }

    if (!_postStore.loading) {
      _postStore.getPosts();
    }

    if (!_postStore.postCategoryStore.loading) {
      _postStore.postCategoryStore.getPostCategories();
    }

    if (!_postStore.postTagStore.loading) {
      _postStore.postTagStore.getPostTags();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Observer(
          builder: (_) => Body(
            store: _postStore,
            loading: _postStore.loading,
            sort: Sort(
              value: _postStore.sort,
              onChanged: _postStore.onChanged,
            ),
            refine: Refine(store: _postStore),
          ),
        ),
      ),
    );
  }
}
