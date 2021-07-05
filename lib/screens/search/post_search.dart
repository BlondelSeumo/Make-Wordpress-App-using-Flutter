import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/models/post/post_search.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/app_store.dart';
import 'package:cirilla/store/post/post_store.dart';
import 'package:dio/dio.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostSearchDelegate extends SearchDelegate<String> {
  PostSearchDelegate() : super(searchFieldLabel: "Search Post");

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query == "") return Container();
    return Search(search: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    AppStore appStore = Provider.of<AppStore>(context);
    PostStore postStore;

    if (appStore.getStoreByKey('post_search_$query') == null) {
      postStore = PostStore(Provider.of<RequestHelper>(context), search: query, key: 'post_search_$query');
    } else {
      postStore = appStore.getStoreByKey('post_search_$query');
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(postStore.posts[index].title.rendered),
            onTap: () {
              // close(context, snapshot.data[index].id);
              Navigator.pushNamed(context, PostScreen.routeName, arguments: {'post': postStore.posts[index]});
            },
          );
        },
        itemCount: postStore.posts.length,
      );
    }

    return FutureBuilder<List<Post>>(
      future: postStore.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data[index].title.rendered),
                onTap: () {
                  // close(context, snapshot.data[index].id);
                  Navigator.pushNamed(context, PostScreen.routeName, arguments: {'post': snapshot.data[index]});
                },
              );
            },
            itemCount: snapshot.data.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  void close(BuildContext context, String result) {
    super.close(context, result);
  }
}

class Search extends StatefulWidget {
  final String search;

  const Search({Key key, this.search}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PostSearch> _data = [];
  CancelToken _token;

  @override
  void dispose() {
    _token?.cancel('cancelled');
    super.dispose();
  }

  Future<void> search(CancelToken token) async {
    try {
      PostStore _postStore = PostStore(Provider.of<RequestHelper>(context));
      List<PostSearch> data = await _postStore.search(queryParameters: {
        'search': widget.search,
        'type': 'post',
        'subtype': 'post',
      }, cancelToken: token);
      setState(() {
        _data = List<PostSearch>.of(data);
      });
    } catch (e) {
      print('Cancel fetch');
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (_token != null) {
      _token?.cancel('cancelled');
    }

    setState(() {
      _token = CancelToken();
    });

    search(_token);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.pushNamed(context, PostScreen.routeName, arguments: {'id': _data[index].id});
          },
          leading: Icon(FeatherIcons.search),
          title: Text(_data[index].title),
        ),
        itemCount: _data.length,
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
