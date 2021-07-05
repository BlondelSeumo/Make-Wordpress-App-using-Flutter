import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/attributes.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/store/product/filter_store.dart';
import 'package:cirilla/store/product_category/product_category_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:ui/ui.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Refine extends StatefulWidget {
  final ProductCategory category;

  // Product list store
  final FilterStore filterStore;

  final Function clearAll;

  final Function onSubmit;

  final double min;

  final double max;

  final String refineItemStyle;

  const Refine({
    Key key,
    this.category,
    this.filterStore,
    this.clearAll,
    this.onSubmit,
    this.min = 0.8,
    this.max = 1,
    this.refineItemStyle,
  }) : super(key: key);

  @override
  _RefineState createState() => _RefineState();
}

class _RefineState extends State<Refine> with CategoryMixin, LoadingMixin, CategoryMixin {
  List<ProductCategory> _categories = List<ProductCategory>.of([]);
  bool _categoryExpand = true;

  @override
  void didChangeDependencies() {
    print('didChangeDependencies Refine');

    ProductCategoryStore productCategoryStore = Provider.of<ProductCategoryStore>(context);
    setState(() {
      _categories = parent(
        categories: productCategoryStore.categories,
        parentId: widget.category != null ? widget.category.id : 0,
      );
    });
    // widget.clearAll();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: widget.min,
        minChildSize: widget.min,
        maxChildSize: widget.max,
        builder: (_, controller) {
          return Observer(builder: (_) {
            return Stack(
              children: [
                ListView(
                  controller: controller,
                  children: [
                    _buildHeader(),
                    _buildInStock(),
                    _buildDivider(),
                    _buildOnSale(),
                    _buildDivider(),
                    _buildFeatured(),
                    _buildDivider(),
                    if (_categories.length > 0) _buildCategories(width: constraints.maxWidth),
                    if (widget.filterStore.attributes.length > 0) _buildAttributes(width: constraints.maxWidth),
                    if (widget.filterStore.productPrices.minPrice != widget.filterStore.productPrices.maxPrice)
                      _buildRangesPrice(),
                    _buildApplyButton(context),
                  ],
                ),
                if (widget.filterStore.loadingAttributes) Center(child: buildLoadingOverlay(context)),
              ],
            );
          });
        },
      );
    });
  }

  Widget _buildDivider() {
    return Divider(indent: 20, endIndent: 20);
  }

  Widget _buildHeader() {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 80),
          Text(translate('product_list_filters'), style: Theme.of(context).textTheme.subtitle1),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 20),
            child: TextButton(
              onPressed: () => widget.clearAll(),
              child: Text(translate('product_list_clear_all'), style: Theme.of(context).textTheme.caption),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInStock() {
    return ListTile(
      title: CirillaText(AppLocalizations.of(context).translate('product_list_in_stock')),
      trailing: CupertinoSwitch(
        activeColor: Theme.of(context).primaryColor,
        value: widget.filterStore.inStock,
        onChanged: (value) => widget.filterStore.onChange(inStock: value),
      ),
    );
  }

  Widget _buildOnSale() {
    return ListTile(
      title: CirillaText(AppLocalizations.of(context).translate('product_list_on_sale')),
      trailing: CupertinoSwitch(
        activeColor: Theme.of(context).primaryColor,
        value: widget.filterStore.onSale,
        onChanged: (value) => widget.filterStore.onChange(onSale: value),
      ),
    );
  }

  Widget _buildFeatured() {
    return ListTile(
      title: CirillaText(AppLocalizations.of(context).translate('product_list_featured')),
      trailing: CupertinoSwitch(
        activeColor: Theme.of(context).primaryColor,
        value: widget.filterStore.featured,
        onChanged: (value) => widget.filterStore.onChange(featured: value),
      ),
    );
  }

  Widget _buildCategories({double width}) {
    double itemWidth = (width - 40 - 8) / 2;

    List<ProductCategory> data =
        widget.refineItemStyle == Strings.refineItemStyleCard ? flatten(categories: _categories) : _categories;

    List<Widget> categories = List.generate(
      data.length + 1,
      (int index) {
        if (index == data.length) {
          if (widget.category == null) return Container();
          return _Category(
            category: ProductCategory(
              id: widget.category?.id,
              categories: [],
              name: AppLocalizations.of(context).translate('product_list_view_all'),
              count: widget.category?.count,
            ),
            filterStore: widget.filterStore,
            refineItemStyle: widget.refineItemStyle,
            width: itemWidth,
          );
        }
        return _Category(
          category: data[index],
          filterStore: widget.filterStore,
          refineItemStyle: widget.refineItemStyle,
          width: itemWidth,
        );
      },
    );

    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              _categoryExpand = !_categoryExpand;
            });
          },
          title: CirillaText(AppLocalizations.of(context).translate('product_list_categories')),
          trailing: _IconButton(
            active: _categoryExpand,
            onPressed: () {
              setState(() {
                _categoryExpand = !_categoryExpand;
              });
            },
          ),
        ),
        _buildDivider(),
        if (_categoryExpand && widget.refineItemStyle != Strings.refineItemStyleCard) ...categories,
        if (_categoryExpand && widget.refineItemStyle == Strings.refineItemStyleCard)
          Wrap(
            children: categories,
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 8.0, // gap between lines
          ),
      ],
    );
  }

  Widget _buildAttributes({double width}) {
    return Observer(
      builder: (_) => Column(
        children: List.generate(
          widget.filterStore.attributes.length,
          (i) => widget.filterStore.attributes[i].terms.options.length > 0
              ? _Attribute(
                  filterStore: widget.filterStore,
                  attribute: widget.filterStore.attributes[i],
                  width: width,
                  refineItemStyle: widget.refineItemStyle,
                )
              : SizedBox(),
        ),
      ),
    );
  }

  Widget _buildRangesPrice() {
    bool expand = widget.filterStore.itemExpand['ranges_price'] != null;

    return Column(children: [
      ListTile(
        onTap: () => widget.filterStore.expand('ranges_price'),
        title: CirillaText(AppLocalizations.of(context).translate('product_list_ranges_price')),
        trailing: _IconButton(
          active: expand,
          onPressed: () => widget.filterStore.expand('ranges_price'),
        ),
      ),
      _buildDivider(),
      if (expand) _RangePrice(filterStore: widget.filterStore),
    ]);
  }

  Widget _buildApplyButton(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
        child: Text(AppLocalizations.of(context).translate('product_list_apply')),
        onPressed: () {
          widget.onSubmit(widget.filterStore);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Function onPressed;
  final bool active;

  const _IconButton({Key key, this.onPressed, this.active = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).textTheme.headline1.color;
    Color activeColor = Theme.of(context).primaryColor;
    return IconButton(
      icon: Icon(
        active ? FeatherIcons.chevronDown : FeatherIcons.chevronRight,
        color: active ? activeColor : color,
        size: 16,
      ),
      onPressed: onPressed,
    );
  }
}

class _Attribute extends StatelessWidget {
  final Attribute attribute;
  final FilterStore filterStore;
  final double width;
  final String refineItemStyle;

  const _Attribute({
    Key key,
    this.attribute,
    this.filterStore,
    this.width,
    this.refineItemStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          ListTile(
            onTap: () => filterStore.expand(attribute.slug),
            title: CirillaText(attribute.name),
            trailing: _IconButton(
              active: filterStore.itemExpand[attribute.slug] != null,
              onPressed: () => filterStore.expand(attribute.slug),
            ),
          ),
          Divider(indent: 20, endIndent: 20),
          if (filterStore.itemExpand[attribute.slug] != null)
            refineItemStyle == Strings.refineItemStyleCard ? _buildCardOptions(context) : _buildOptions(),
        ],
      ),
    );
  }

  onSelected(Option option) {
    filterStore.selectAttribute(
      ItemAttributeSelected(
        taxonomy: option.taxonomy,
        field: 'term_id',
        terms: option.termId,
        title: '${attribute.name}: ${option.name}',
      ),
    );
  }

  Widget _buildCardOptions(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: List.generate(attribute.terms.options.length, (i) {
        Option option = attribute.terms.options[i];

        bool isSelected = filterStore.attributeSelected
                .indexWhere((ItemAttributeSelected s) => s.taxonomy == option.taxonomy && s.terms == option.termId) >=
            0;

        return Container(
          width: (width - 40 - 8) / 2,
          child: ButtonSelect.filter(
            child: Text(
              "${option.name} (${option.count})",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
            isSelect: isSelected,
            colorSelect: Theme.of(context).primaryColor,
            color: Theme.of(context).dividerColor,
            onTap: () => onSelected(option),
          ),
        );
      }),
    );
  }

  Widget _buildOptions() {
    Widget trailing = SizedBox();

    return Column(
      children: List.generate(attribute.terms.options.length, (i) {
        Option option = attribute.terms.options[i];

        bool isSelected = filterStore.attributeSelected
                .indexWhere((ItemAttributeSelected s) => s.taxonomy == option.taxonomy && s.terms == option.termId) >=
            0;

        if (attribute.type == 'color') {
          trailing = Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: ConvertData.fromHex(option.value, Colors.transparent),
              borderRadius: BorderRadius.circular(11),
            ),
          );
        }

        if (attribute.type == 'image') {
          trailing = ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Image.network(
              option.value,
              width: 22,
              height: 22,
            ),
          );
        }

        return Column(
          children: [
            ListTile(
              onTap: () => onSelected(option),
              leading: Checkbox(
                value: isSelected,
                onChanged: (bool check) => onSelected(option),
              ),
              title: CirillaSubText("${option.name} (${option.count})", active: isSelected),
              trailing: trailing,
            ),
            Divider(indent: 20, endIndent: 20),
          ],
        );
      }),
    );
  }
}

class _Category extends StatelessWidget {
  final ProductCategory category;
  final FilterStore filterStore;
  final String refineItemStyle;
  final double width;

  const _Category({
    Key key,
    this.category,
    this.filterStore,
    this.refineItemStyle,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSub = category.categories.length > 0;
    return Observer(builder: (_) {
      String key = "category_${category.id}";
      bool expand = filterStore.itemExpand[key] != null;
      return refineItemStyle == Strings.refineItemStyleCard
          ? _buildCard(context, key: key, isSub: isSub, expand: expand)
          : _buildListTitle(key: key, isSub: isSub, expand: expand);
    });
  }

  Widget _buildCard(BuildContext context, {bool isSub, bool expand, String key}) {
    bool isActive = filterStore.category != null && filterStore.category.id == category.id;

    return Container(
      constraints: BoxConstraints(maxWidth: width),
      child: SizedBox(
        child: ButtonSelect.filter(
          child: Text(
            "${category.name} (${category.count})",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
          isSelect: isActive,
          colorSelect: Theme.of(context).primaryColor,
          color: Theme.of(context).dividerColor,
          onTap: () => filterStore.onChange(category: category),
        ),
        width: double.infinity,
      ),
    );
  }

  Widget _buildListTitle({bool isSub, bool expand, String key}) {
    return Column(
      children: [
        ListTile(
          onTap: () => filterStore.onChange(category: category),
          leading: Radio(
            value: filterStore.category.id,
            groupValue: category.id,
            onChanged: (dynamic value) => filterStore.onChange(category: category),
          ),
          title: CirillaSubText("${category.name} (${category.count})", active: filterStore.category.id == category.id),
          trailing: isSub
              ? _IconButton(
                  active: expand,
                  onPressed: () => filterStore.expand(key),
                )
              : null,
        ),
        Divider(indent: 20, endIndent: 20),
        if (expand && category.categories.length > 0)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Column(
              children: List.generate(
                category.categories.length,
                (int index) => _Category(
                  category: category.categories[index],
                  filterStore: filterStore,
                ),
              ),
            ),
          )
      ],
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class _RangePrice extends StatelessWidget {
  final FilterStore filterStore;

  const _RangePrice({Key key, this.filterStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              child: Center(child: Text(formatCurrency(context, price: filterStore.productPrices.minPrice.toString()))),
            ),
            Expanded(
              child: RangeSlider(
                values: filterStore.rangePrices,
                min: filterStore.productPrices.minPrice,
                max: filterStore.productPrices.maxPrice,
                divisions: (filterStore.productPrices.maxPrice - filterStore.productPrices.minPrice).toInt(),
                labels: RangeLabels(
                  formatCurrency(context, price: filterStore.rangePrices.start.round().toString()),
                  formatCurrency(context, price: filterStore.rangePrices.end.round().toString()),
                ),
                onChanged: (RangeValues values) {
                  filterStore.setMinMaxPrice(values.start, values.end);
                },
              ),
            ),
            Container(
              // width: 60,
              child: Center(child: Text(formatCurrency(context, price: filterStore.productPrices.maxPrice.toString()))),
            )
          ],
        ),
      ),
    );
  }
}
