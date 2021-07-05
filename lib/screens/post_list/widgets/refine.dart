import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/post/post_category.dart';
import 'package:cirilla/store/post/post_store.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class Refine extends StatefulWidget {
  final PostStore store;

  const Refine({Key key, this.store}) : super(key: key);

  @override
  _RefineState createState() => _RefineState();
}

class _RefineState extends State<Refine> {
  List<PostCategory> _categorySelected = [];
  List<PostTag> _tagSelected = [];

  @override
  void didChangeDependencies() {
    setState(() {
      _categorySelected = widget.store.categorySelected;
      _tagSelected = widget.store.tagSelected;
    });

    super.didChangeDependencies();
  }

  void onChangeCategory({PostCategory postCategory, selected = false}) {
    List<PostCategory> categorySelected = List<PostCategory>.of(_categorySelected);

    if (selected) {
      categorySelected.add(postCategory);
    } else {
      categorySelected.removeWhere((e) => e.id == postCategory.id);
    }

    setState(() {
      _categorySelected = categorySelected;
    });
  }

  void onChangeTag({PostTag postTag, selected = false}) {
    List<PostTag> tagSelected = List<PostTag>.of(_tagSelected);

    if (selected) {
      tagSelected.add(postTag);
    } else {
      tagSelected.removeWhere((e) => e.id == postTag.id);
    }

    setState(() {
      _tagSelected = tagSelected;
    });
  }

  void clearAll() {
    setState(() {
      _tagSelected = List<PostTag>.of([]);
      _categorySelected = List<PostCategory>.of([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Stack(
                children: [
                  Center(child: Text('Refine', style: theme.textTheme.subtitle1)),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text('Clear all'),
                        onPressed: clearAll,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          textStyle: theme.textTheme.caption,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _Categories(
                    categories: widget.store.postCategoryStore.postCategories,
                    categorySelected: _categorySelected,
                    onChange: onChangeCategory,
                  ),
                  _Tags(
                    tags: widget.store.postTagStore.postTags,
                    tagSelected: _tagSelected,
                    onChange: onChangeTag,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: Text('Filter'),
                  onPressed: () => Navigator.pop(context, {'categories': _categorySelected, 'tags': _tagSelected}),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Categories extends StatefulWidget {
  final List<PostCategory> categories;
  final List<PostCategory> categorySelected;
  final Function onChange;

  const _Categories({
    Key key,
    this.categories,
    this.categorySelected,
    this.onChange,
  }) : super(key: key);

  @override
  __CategoriesState createState() => __CategoriesState();
}

class __CategoriesState extends State<_Categories> {
  bool _expand = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          title: Text('Categories', style: theme.textTheme.subtitle2),
          trailing: Icon(!_expand ? FeatherIcons.chevronRight : FeatherIcons.chevronDown, size: 16),
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          onTap: () => setState(() {
            _expand = !_expand;
          }),
        ),
        Divider(height: 1, thickness: 1),
        if (_expand)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Column(
              children: [
                for (var i = 0; i < widget.categories.length; i++) ...[
                  CheckboxListTile(
                    value: widget.categorySelected.indexWhere((e) => e.id == widget.categories[i].id) >= 0,
                    title: Text(widget.categories[i].name + " (${widget.categories[i].count})",
                        style: theme.textTheme.bodyText1),
                    onChanged: (value) => widget.onChange(postCategory: widget.categories[i], selected: value),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  Divider(height: 1, thickness: 1),
                ],
              ],
            ),
          )
      ],
    );
  }
}

class _Tags extends StatefulWidget {
  final List<PostTag> tags;
  final List<PostTag> tagSelected;
  final Function onChange;

  const _Tags({
    Key key,
    this.tags,
    this.tagSelected,
    this.onChange,
  }) : super(key: key);

  @override
  __TagsState createState() => __TagsState();
}

class __TagsState extends State<_Tags> {
  bool _expand = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          title: Text('Tags', style: theme.textTheme.subtitle2),
          trailing: Icon(!_expand ? FeatherIcons.chevronRight : FeatherIcons.chevronDown, size: 16),
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          onTap: () => setState(() {
            _expand = !_expand;
          }),
        ),
        Divider(height: 1, thickness: 1),
        if (_expand)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Column(
              children: [
                for (var i = 0; i < widget.tags.length; i++) ...[
                  CheckboxListTile(
                    value: widget.tagSelected.indexWhere((e) => e.id == widget.tags[i].id) >= 0,
                    title: Text(widget.tags[i].name + " (${widget.tags[i].count})", style: theme.textTheme.bodyText1),
                    onChanged: (value) => widget.onChange(postTag: widget.tags[i], selected: value),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  Divider(height: 1, thickness: 1),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
