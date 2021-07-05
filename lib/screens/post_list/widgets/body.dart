import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/post/post.dart';
import 'package:cirilla/models/post/post_category.dart';
import 'package:cirilla/screens/post/post.dart';
import 'package:cirilla/screens/search/post_search.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:cirilla/store/post/post_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

const List select = [
  {
    'value': 1,
    'icon': FeatherIcons.square,
  },
  {
    'value': 2,
    'icon': FeatherIcons.list,
  },
];

class Body extends StatefulWidget {
  final PostStore store;
  final Widget sort;
  final Widget refine;
  final bool loading;

  const Body({
    Key key,
    this.store,
    this.sort,
    this.refine,
    this.loading,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with LoadingMixin, AppBarMixin {
  final PostSearchDelegate _delegate = PostSearchDelegate();

  int type = 2;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void updateType(int value) {
    setState(() {
      type = value;
    });
  }

  void _onScroll() {
    if (!_controller.hasClients || widget.loading || !widget.store.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      widget.store.getPosts();
    }
  }

  void removeSelectedCategory(PostCategory category) {
    List<PostCategory> selected = List<PostCategory>.of(widget.store.categorySelected);
    selected.removeWhere((element) => element.id == category.id);
    widget.store.onChanged(categorySelected: selected);
  }

  void removeSelectedTag(PostTag tag) {
    List<PostTag> selected = List<PostTag>.of(widget.store.tagSelected);
    selected.removeWhere((element) => element.id == tag.id);
    widget.store.onChanged(tagSelected: selected);
  }

  void clearAll() {
    widget.store.onChanged(tagSelected: [], categorySelected: []);
  }

  @override
  Widget build(BuildContext context) {
    List<Post> posts = widget.store.posts;

    bool isFilter = widget.store.categorySelected.length > 0 || widget.store.tagSelected.length > 0;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      slivers: <Widget>[
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          leading: leading(),
          title: Text('Latest News'),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                icon: Icon(FeatherIcons.search),
                iconSize: 20,
                onPressed: () async {
                  final String selected = await showSearch<String>(
                    context: context,
                    delegate: _delegate,
                  );
                  print(selected);
                },
              ),
            )
          ],
          pinned: false,
          floating: false,
        ),

        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: StickyTabBarDelegate(
            child: buildHeader(),
          ),
        ),

        if (isFilter)
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: StickyTabBarDelegate(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: ListView(
                    padding: EdgeInsetsDirectional.only(start: 20, end: 12),
                    scrollDirection: Axis.horizontal,
                    children: [
                      InputChip(
                        label: Text('Clear all'),
                        deleteIcon: Icon(FeatherIcons.x, size: 16),
                        onDeleted: clearAll,
                        backgroundColor: Theme.of(context).primaryColor,
                        deleteIconColor: Theme.of(context).colorScheme.onPrimary,
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      SizedBox(width: 8),
                      ...List.generate(widget.store.categorySelected.length, (index) {
                        PostCategory cat = widget.store.categorySelected[index];

                        return Padding(
                          padding: EdgeInsetsDirectional.only(end: 8),
                          child: InputChip(
                            label: Text(cat.name),
                            deleteIcon: Icon(Icons.clear, size: 16),
                            onDeleted: () => removeSelectedCategory(cat),
                          ),
                        );
                      }).toList(),
                      ...List.generate(widget.store.tagSelected.length, (index) {
                        PostTag tag = widget.store.tagSelected[index];
                        return Padding(
                          padding: EdgeInsetsDirectional.only(end: 8),
                          child: InputChip(
                            label: Text(tag.name),
                            deleteIcon: Icon(Icons.clear, size: 16),
                            onDeleted: () => removeSelectedTag(tag),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),

        CupertinoSliverRefreshControl(
          onRefresh: widget.store.refresh,
          builder: buildAppRefreshIndicator,
        ),

        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: isFilter ? 0 : 20),
          sliver: SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              (context, index) => _Post(
                post: widget.loading && posts.length == 0 ? Post() : posts[index],
                type: type,
              ),
              childCount: widget.loading && posts.length == 0 ? 10 : posts.length,
            ),
          ),
        ),

        if (widget.loading)
          SliverToBoxAdapter(
            child: buildLoading(context, isLoading: widget.store.canLoadMore),
          ),
      ],
    );
  }

  Widget buildHeader() {
    ButtonStyle styleButtonLeft = TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 12),
      minimumSize: Size(0, 59),
      textStyle: Theme.of(context).textTheme.bodyText2,
    );

    return Header(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            TextButton(
              child: Row(
                children: [Icon(FeatherIcons.barChart2, size: 20), SizedBox(width: 8), Text('Sort')],
              ),
              onPressed: () {
                showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  builder: (context) {
                    // Using Wrap makes the bottom sheet height the height of the content.
                    // Otherwise, the height will be half the height of the screen.
                    return widget.sort;
                  },
                );
              },
              style: styleButtonLeft,
            ),
            TextButton(
              child: Row(
                children: [Icon(FeatherIcons.sliders, size: 20), SizedBox(width: 8), Text('Refine')],
              ),
              onPressed: () async {
                Map<String, dynamic> data = await showModalBottomSheet<Map<String, dynamic>>(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  builder: (context) {
                    // Using Wrap makes the bottom sheet height the height of the content.
                    // Otherwise, the height will be half the height of the screen.
                    return widget.refine;
                  },
                );
                if (data == null) return;

                widget.store.onChanged(
                  categorySelected: data['categories'],
                  tagSelected: data['tags'],
                );
              },
              style: styleButtonLeft,
            ),
          ],
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: select
              .map(
                (item) => IconButton(
                  icon: Icon(item['icon']),
                  iconSize: 20,
                  color: item['value'] == type ? Theme.of(context).primaryColor : null,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(maxWidth: 36, minWidth: 36),
                  splashRadius: 18,
                  onPressed: () => updateType(item['value']),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget with PostMixin {
  final Post post;
  final int type;

  const _Post({Key key, this.post, this.type = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double widthScreen = MediaQuery.of(context).size.width - 40;

    double width = 335;
    double height = 260;

    return Column(
      children: [
        if (type == 2)
          PostHorizontalItem(
            image: buildImage(post, width: 120, height: 120, fit: BoxFit.cover),
            name: buildName(theme, post),
            date: buildDate(theme, post),
            category: buildCategory(theme, post),
            author: buildAuthor(theme, post),
            comment: buildComment(theme, post),
            color: Colors.transparent,
            onClick: () => Navigator.pushNamed(context, PostScreen.routeName, arguments: {'post': post}),
          )
        else
          PostContainedItem(
            width: widthScreen,
            image: buildImage(post, width: widthScreen, height: (widthScreen * height) / width, fit: BoxFit.cover),
            name: buildName(theme, post),
            date: buildDate(theme, post),
            category: buildCategory(theme, post),
            author: buildAuthor(theme, post),
            comment: buildComment(theme, post),
            color: Colors.transparent,
            onClick: () => Navigator.pushNamed(context, PostScreen.routeName, arguments: {'post': post}),
          ),
        Divider(
          height: 40,
          thickness: 1,
        ),
      ],
    );
  }
}
