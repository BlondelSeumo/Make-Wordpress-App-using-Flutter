import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

class ProductLayoutDefault extends StatefulWidget {
  final Product product;
  final Widget appbar;
  final Widget bottomBar;
  final Widget slideshow;
  final List<Widget> productInfo;
  final bool extendBodyBehindAppBar;

  final Widget cartIcon;
  final String cartIconType;
  final String floatingActionButtonLocation;

  const ProductLayoutDefault({
    Key key,
    this.product,
    this.appbar,
    this.bottomBar,
    this.slideshow,
    this.productInfo,
    this.extendBodyBehindAppBar,
    this.cartIcon,
    this.cartIconType,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  _ProductLayoutDefaultState createState() => _ProductLayoutDefaultState();
}

class _ProductLayoutDefaultState extends State<ProductLayoutDefault> with AppBarMixin, ScrollMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: ConvertData.floatingActionButtonLocation(widget.floatingActionButtonLocation),
      floatingActionButton: widget.cartIcon != null && widget.cartIconType == 'floating' ? widget.cartIcon : null,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      primary: true,
      bottomNavigationBar: widget.bottomBar,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: widget.appbar,
        backgroundColor: isScrolledToTop ? Colors.transparent : Theme.of(context).appBarTheme.backgroundColor,
        shadowColor: isScrolledToTop ? Colors.transparent : Theme.of(context).appBarTheme.shadowColor,
        elevation: 1,
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                widget.slideshow,
                if (widget.cartIcon != null && widget.cartIconType == 'pinned')
                  Positioned(bottom: 20, right: 20, child: widget.cartIcon)
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widget.productInfo[index];
              },
              childCount: widget.productInfo.length,
            ),
          ),
        ],
      ),
    );
  }
}
