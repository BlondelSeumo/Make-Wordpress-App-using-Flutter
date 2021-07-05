import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

class ProductLayoutZoomSlideshow extends StatefulWidget {
  final Product product;
  final Widget appbar;
  final Widget bottomBar;
  final Widget slideshow;
  final List<Widget> productInfo;
  final bool extendBodyBehindAppBar;
  final double height;
  final String appBarType;

  final Widget cartIcon;
  final String cartIconType;
  final String floatingActionButtonLocation;

  const ProductLayoutZoomSlideshow({
    Key key,
    this.product,
    this.appbar,
    this.slideshow,
    this.productInfo,
    this.extendBodyBehindAppBar,
    this.height,
    this.appBarType,
    this.bottomBar,
    this.cartIcon,
    this.cartIconType,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  _ProductLayoutZoomSlideshowState createState() => _ProductLayoutZoomSlideshowState();
}

class _ProductLayoutZoomSlideshowState extends State<ProductLayoutZoomSlideshow> with AppBarMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: widget.bottomBar,
      floatingActionButtonLocation: ConvertData.floatingActionButtonLocation(widget.floatingActionButtonLocation),
      floatingActionButton: widget.cartIcon != null && widget.cartIconType == 'floating' ? widget.cartIcon : null,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: widget.appbar,
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: widget.height,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
              ],
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  widget.slideshow,
                  if (widget.cartIcon != null && widget.cartIconType == 'pinned')
                    Positioned(bottom: 20, right: 20, child: widget.cartIcon)
                ],
              ),
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
