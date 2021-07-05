import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

class ProductLayoutDraggableScrollableSheet extends StatefulWidget {
  final Product product;
  final Widget appbar;
  final Widget bottomBar;
  final Widget slideshow;
  final List<Widget> productInfo;
  final bool extendBodyBehindAppBar;
  final Function addToCart;
  final bool addToCartLoading;

  final Widget cartIcon;
  final String cartIconType;
  final String floatingActionButtonLocation;

  const ProductLayoutDraggableScrollableSheet({
    Key key,
    this.product,
    this.appbar,
    this.slideshow,
    this.productInfo,
    this.extendBodyBehindAppBar,
    this.addToCart,
    this.addToCartLoading,
    this.bottomBar,
    this.cartIcon,
    this.cartIconType,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  _ProductLayoutDraggableScrollableSheetState createState() => _ProductLayoutDraggableScrollableSheetState();
}

class _ProductLayoutDraggableScrollableSheetState extends State<ProductLayoutDraggableScrollableSheet>
    with AppBarMixin, ScrollMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: ConvertData.floatingActionButtonLocation(widget.floatingActionButtonLocation),
      floatingActionButton: widget.cartIcon != null && widget.cartIconType == 'floating' ? widget.cartIcon : null,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      bottomNavigationBar: widget.bottomBar,
      primary: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: widget.appbar,
        backgroundColor: isScrolledToTop ? Colors.transparent : Theme.of(context).appBarTheme.backgroundColor,
        shadowColor: isScrolledToTop ? Colors.transparent : Theme.of(context).appBarTheme.shadowColor,
        elevation: 1,
      ),
      body: Stack(
        children: [
          widget.slideshow,
          _Body(
            productInfo: widget.productInfo,
            addToCart: widget.addToCart,
            addToCartLoading: widget.addToCartLoading,
            cartIcon: widget.cartIcon,
            cartIconType: widget.cartIconType,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final double minChildSize;
  final Function addToCart;
  final bool addToCartLoading;

  final List<Widget> productInfo;

  final Widget cartIcon;
  final String cartIconType;
  final String floatingActionButtonLocation;

  const _Body({
    Key key,
    this.minChildSize = 0.4,
    this.productInfo,
    this.addToCart,
    this.addToCartLoading,
    this.cartIcon,
    this.cartIconType,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  double top = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      top = 1 - widget.minChildSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          top = 1 - notification.extent;
        });
        return true;
      },
      child: DraggableScrollableActuator(
        child: Stack(
          children: <Widget>[
            DraggableScrollableSheet(
              initialChildSize: widget.minChildSize,
              minChildSize: widget.minChildSize,
              maxChildSize: 0.85,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                return Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
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
              },
            ),
            // Positioned(
            //   top: screenHeight * top - 26,
            //   right: 24.0,
            //   child: SizedBox(
            //     height: 48,
            //     width: 48,
            //     child: FloatingActionButton(
            //       onPressed: widget.addToCart,
            //       child: Icon(Icons.shopping_cart),
            //     ),
            //   ),
            // ),
            if (widget.cartIcon != null && widget.cartIconType == 'pinned')
              Positioned(
                top: screenHeight * top - 26,
                right: 24.0,
                child: widget.cartIcon,
              ),
            Positioned(
              top: screenHeight * top + 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  height: 4,
                  width: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
