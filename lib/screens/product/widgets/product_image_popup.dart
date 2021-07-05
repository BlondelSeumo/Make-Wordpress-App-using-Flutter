import 'package:cirilla/models/product/product_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProductImagesPopupArguments {
  final int current;
  final SwiperController controller;

  ProductImagesPopupArguments(this.current, this.controller);
}

class ProductImagesPopup extends StatefulWidget {
  final List<ProductImage> images;
  final ProductImagesPopupArguments arguments;

  ProductImagesPopup({this.images, this.arguments});

  @override
  _ProductImagesPopupState createState() => _ProductImagesPopupState();
}

class _ProductImagesPopupState extends State<ProductImagesPopup> {
  int _current = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _current = widget.arguments.current;
    });
    pageController = PageController(initialPage: widget.arguments.current);
  }

  void onPageChanged(int index) {
    setState(() {
      _current = index;
    });
    widget.arguments.controller.move(index);
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.images.length,
              onPageChanged: onPageChanged,
              pageController: pageController,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                  ),
                ),
              ),
            ),
            Positioned(
              top: top - 18 > 0 ? top - 18 : top,
              right: 10,
              left: 10,
              child: Row(
                children: [
                  Container(
                    width: 48,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${_current + 1}/${widget.images.length}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        FeatherIcons.x,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    ProductImage image = widget.images[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(image.src),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: "product_images_${image.id}"),
    );
  }
}
