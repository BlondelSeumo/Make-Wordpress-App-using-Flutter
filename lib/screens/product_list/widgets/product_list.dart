import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/widgets/cirilla_product_item.dart';
import 'package:flutter/material.dart';

abstract class ProductLayout extends StatelessWidget {
  // List product
  final List<Product> products;

  // Layout product
  final String layout;

  // Template product item
  final String templateItem;

  // Pad items
  final double pad;

  // Enable divider
  final bool isDivider;

  // Size Image
  final Size size;

  const ProductLayout({
    Key key,
    @required this.products,
    this.layout = Strings.layoutProductGrid,
    this.templateItem = Strings.productItemCard,
    this.pad = 24,
    this.isDivider = false,
    this.size = const Size(160, 190),
  }) : super(key: key);

  Widget buildLayout(
    BuildContext context, {
    String layout,
    Function itemBuilder,
    List<Product> products,
    String templateItem,
    double pad,
    bool isDivider,
    Size size,
  });

  // Build Item product
  static Widget buildItem(
    BuildContext context,
    Product product,
    String templateItem,
    double pad,
    bool isDivider,
    Size size,
  ) {
    return Column(
      children: [
        CirillaProductItem(
          product: product,
          template: templateItem,
          width: size.width,
          height: size.height,
        ),
        if (isDivider)
          Divider(
            height: 48,
            thickness: 1,
          )
        else
          SizedBox(height: pad)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildLayout(
      context,
      layout: layout,
      itemBuilder: buildItem,
      products: products,
      templateItem: templateItem,
      pad: pad,
      isDivider: isDivider,
      size: size,
    );
  }
}

/// Build Product Layout List
class ProductListLayout extends ProductLayout {
  const ProductListLayout({
    Key key,
    List<Product> products,
    String layout,
    String templateItem,
    double pad,
    bool isDivider,
    Size size,
  }) : super(
          key: key,
          products: products,
          layout: layout,
          templateItem: templateItem,
          pad: pad,
          isDivider: isDivider,
          size: size,
        );

  @override
  Widget buildLayout(
    BuildContext context, {
    String layout,
    Function itemBuilder,
    List<Product> products,
    String templateItem,
    double pad,
    bool isDivider,
    Size size,
  }) {
    double width = MediaQuery.of(context).size.width;
    if (layout == 'grid') {
      double widthView = width - (2 * 20);
      double spacing = 16;
      int col = 2;
      int length = products.length;
      int countRow = (length / col).ceil();

      double widthItem = (widthView - (col - 1) * spacing) / col;
      double widthImage = widthItem;
      double heightImage = (widthImage * size.height) / size.width;

      Size sizeImage = Size(widthImage, heightImage);

      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverToBoxAdapter(
          child: Column(
            children: List.generate(countRow, (index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < col; i++) ...[
                    if (i > 0) SizedBox(width: spacing),
                    Expanded(
                      child: (index * col) + i < products.length
                          ? itemBuilder(context, products[(index * col) + i], templateItem, pad, isDivider, sizeImage)
                          : Container(),
                    )
                  ]
                ],
              );
            }),
          ),
        ),
      );
    }

    double widthView = width - (2 * 20);
    double widthImage = widthView;
    double heightImage = (widthImage * size.height) / size.width;

    Size sizeImage = Size(widthImage, heightImage);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return itemBuilder(context, products[index], templateItem, pad, isDivider, sizeImage);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
