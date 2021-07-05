import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/search/post_search.dart';
import 'package:cirilla/screens/search/product_search.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/cirilla_appbar.dart';
import 'package:cirilla/widgets/cirilla_cart_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:cirilla/mixins/utility_mixin.dart' show get;

import 'banner/banner.dart';
import 'button/button.dart';
import 'divider/divider.dart';
import 'post/post.dart';
import 'product-search/product_search.dart';
import 'post_search/post_search.dart';
import 'text/text.dart';
import 'testimonial/testimonial.dart';
import 'slideshow/slideshow.dart';
import 'post_category/post_category.dart';
import 'html/html.dart';
import 'post_archive/post_archive.dart';
import 'post_comment/post_comment.dart';
import 'post_author/post_author.dart';
import 'post_tag/post_tag.dart';
import 'post_tab/post_tab.dart';
import 'heading/heading.dart';
import 'subscribe/subscribe.dart';
import 'social/social.dart';
import 'product_newest/product_newest.dart';
import 'product_best_seller/product_best_seller.dart';
import 'product_top_rated/product_top_rated.dart';
import 'product_sale/product_sale.dart';
import 'product_featured/product_featured.dart';
import 'product_hand_picked/product_hand_picked.dart';
import 'product_tag/product_tag.dart';
import 'product_tab/product_tab.dart';
import 'product_by_category/product_by_category.dart';
import 'product-category/product-category.dart';
import 'countdown/countdown.dart';
import 'spacer/spacer.dart';
import 'icon_box/icon_box.dart';

class Widgets {
  static const String slideshow = 'slideshow';
  static const String divider = 'divider';
  static const String category = 'category';
  static const String banner = 'banner';
  static const String text = 'text';
  static const String button = 'button';
  static const String spacer = 'spacer';

  static const String productSearch = 'product-search';
  static const String postSearch = 'post-search';
  static const String product = 'product';
  static const String productCategory = 'product-category';
  static const String postCategory = 'post-category';
  static const String post = 'post';
  static const String testimonial = 'testimonial';
  static const String vendor = 'vendor';
  static const String countdown = 'countdown';
  static const String iconBox = 'icon-box';
  static const String html = 'html';
  static const String postArchive = 'post-archive';
  static const String postComment = 'post-comment';
  static const String postTag = 'post-tag';
  static const String postAuthor = 'post-author';
  static const String postTab = 'post-tab';
  static const String heading = 'heading';
  static const String subscribe = 'subscribe';
  static const String social = 'social';
  static const String productNewest = 'product-newest';
  static const String productBestSeller = 'product-best-seller';
  static const String productTopRated = 'product-top-rated';
  static const String productSale = 'product-sale';
  static const String productFeatured = 'product-featured';
  static const String productHandPicked = 'product-hand-picked';
  static const String productByCategory = 'product-by-category';
  static const String productTag = 'product-tag';
  static const String productTab = 'product-tab';

  dynamic buildAppBar(
    BuildContext context, {
    Data data,
    String type,
    bool isScrolledToTop = false,
    String themeModeKey = 'value',
    String languageKey = 'text',
  }) {
    // Appbar color on Top
    Color appbarColorOnTop =
        ConvertData.fromRGBA(get(data.configs, ['appbarColorOnTop', themeModeKey]), Colors.transparent);

    Color iconAppbarColorOnTop =
        ConvertData.fromRGBA(get(data.configs, ['iconAppbarColorOnTop', themeModeKey]), Colors.white);

    // Center title
    bool centerTitle = get(data.configs, ['centerLogo'], true);

    // Enable Logo
    bool enableLogo = get(data.configs, ['enableLogo'], true);

    // Logo Text
    String logoText = get(data.configs, ['logoText', languageKey], 'Home');

    // Logo Image
    String imageLogo = get(data.configs, ['imageLogo', 'src'], '');
    String imageLogoDark = get(data.configs, ['imageLogoDark', 'src'], '');
    String logo = themeModeKey == 'value' ? imageLogo : imageLogoDark;

    // Logo Width
    double logoWidth = ConvertData.stringToDouble(get(data.configs, ['logoWidth'], 122));

    // Logo Width
    double logoHeight = ConvertData.stringToDouble(get(data.configs, ['logoHeight'], 50));

    // Enable Sidebar
    bool enableSidebar = get(data.configs, ['enableSidebar'], true);

    // Sidebar icon
    String iconSideBar = get(data.configs, ['iconSideBar', 'name'], 'menu');

    // Sidebar image
    String imageSidebar = get(data.configs, ['imageSidebar', 'src'], '');

    // Enable/ Disable Blog search
    bool enableBlogSearch = get(data.configs, ['enableBlogSearch'], false);

    // Enable / Disable Blog search
    bool enableProductSearch = get(data.configs, ['enableProductSearch'], false);

    // Enable / Disable cart
    bool enableCart = get(data.configs, ['enableCart'], false);

    // Enable / Disable cart count
    bool enableCartCount = get(data.configs, ['enableNumberCart'], true);

    // Cart Icon
    String iconCart = get(data.configs, ['iconCart', 'name'], 'shopping-cart');

    // Cart Image
    String imageCart = get(data.configs, ['imageCart', 'src'], '');

    bool isDrawer = ZoomDrawer.of(context) != null;

    // ==== Leading
    Widget leading = imageSidebar != ""
        ? InkWell(
            onTap: () => isDrawer ? ZoomDrawer.of(context).toggle() : Navigator.of(context).pop(),
            child: Image.network(imageSidebar),
          )
        : IconButton(
            icon: isDrawer && iconSideBar == 'menu'
                ? AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: ZoomDrawer.of(context).animationController,
                  )
                : Icon(FeatherIconsMap[iconSideBar]),
            onPressed: () => isDrawer ? ZoomDrawer.of(context).toggle() : Navigator.of(context).pop(),
          );

    //  ==== Title
    Widget title = logo != null && logo != ''
        ? Image.network(
            logo,
            width: logoWidth,
            height: logoHeight,
            fit: BoxFit.contain,
          )
        : Text(logoText);

    // ==== Actions
    List<Widget> actions = [
      if (enableBlogSearch)
        IconButton(
          icon: Icon(FeatherIcons.search),
          onPressed: () async {
            await showSearch<String>(
              context: context,
              delegate: PostSearchDelegate(),
            );
          },
        ),
      if (enableProductSearch)
        IconButton(
          icon: Icon(FeatherIcons.search),
          onPressed: () async {
            await showSearch<String>(
              context: context,
              delegate: ProductSearchDelegate(),
            );
          },
        ),
      if (enableCart)
        CirillaCartIcon(
          icon: Icon(FeatherIconsMap[iconCart]),
          enableCount: enableCartCount,
          cartImage: imageCart.isNotEmpty ? Image.network(imageCart) : null,
          color: Colors.transparent,
        ),
    ];

    TextTheme appbarTextTheme = Theme.of(context).appBarTheme.textTheme ?? Theme.of(context).textTheme;

    switch (type) {
      case Strings.appbarFixed:
        return CirillaAppbar(
          color: appbarColorOnTop,
          isScrolledToTop: isScrolledToTop,
          child: AppBar(
            automaticallyImplyLeading: true,
            iconTheme:
                isScrolledToTop ? IconThemeData(color: iconAppbarColorOnTop) : Theme.of(context).appBarTheme.iconTheme,
            textTheme: isScrolledToTop
                ? appbarTextTheme.copyWith(headline6: appbarTextTheme.headline6.copyWith(color: iconAppbarColorOnTop))
                : appbarTextTheme,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: enableSidebar ? leading : null,
            title: enableLogo ? title : null,
            centerTitle: centerTitle,
            actions: actions,
          ),
        );
      default:
        return SliverAppBar(
          floating: type == Strings.appbarFloating,
          elevation: 0,
          primary: true,
          centerTitle: centerTitle,
          title: enableLogo ? title : null,
          leading: enableSidebar ? leading : null,
          actions: actions,
        );
    }
  }

  SliverList buildWidgets(BuildContext context, {List<String> widgetIds, Map<String, WidgetConfig> widgets}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          String id = widgetIds[index];
          WidgetConfig widget = widgets[id];
          return buildWidget(widget);
        },
        childCount: widgetIds.length,
      ),
    );
  }

  Widget buildWidget(WidgetConfig widget) {
    switch (widget.type) {
      case postCategory:
        return PostCategoryWidget(
          widgetConfig: widget,
        );
      case post:
        return PostWidget(
          widgetConfig: widget,
        );
      case text:
        return TextWidget(
          widgetConfig: widget,
        );
      case button:
        return ButtonWidget(
          widgetConfig: widget,
        );
      case banner:
        return BannerWidget(
          widgetConfig: widget,
        );
      case divider:
        return DividerWidget(
          widgetConfig: widget,
        );
      case productSearch:
        return ProductSearchWidget(
          widgetConfig: widget,
        );
      case postSearch:
        return PostSearchWidget(
          widgetConfig: widget,
        );
      case testimonial:
        return TestimonialWidget(
          widgetConfig: widget,
        );
      case slideshow:
        return SlideshowWidget(
          widgetConfig: widget,
        );
      case html:
        return HtmlWidget(
          widgetConfig: widget,
        );
      case postArchive:
        return PostArchiveWidget(
          widgetConfig: widget,
        );
      case postComment:
        return PostCommentWidget(
          widgetConfig: widget,
        );
      case postTag:
        return PostTagWidget(
          widgetConfig: widget,
        );
      case postAuthor:
        return PostAuthorWidget(
          widgetConfig: widget,
        );
      case postTab:
        return PostTabWidget(
          widgetConfig: widget,
        );
      case heading:
        return HeadingWidget(
          widgetConfig: widget,
        );
      case subscribe:
        return SubscribeWidget(
          widgetConfig: widget,
        );
      case social:
        return SocialWidget(
          widgetConfig: widget,
        );
      case productNewest:
        return ProductNewestWidget(
          widgetConfig: widget,
        );
      case productTab:
        return ProductTabWidget(
          widgetConfig: widget,
        );
      case productCategory:
        return ProductCategoryWidget(
          widgetConfig: widget,
        );
      case productBestSeller:
        return ProductBestSellerWidget(
          widgetConfig: widget,
        );
      case productTopRated:
        return ProductTopRatedWidget(
          widgetConfig: widget,
        );
      case productSale:
        return ProductSaleWidget(
          widgetConfig: widget,
        );
      case productFeatured:
        return ProductFeaturedWidget(
          widgetConfig: widget,
        );
      case productHandPicked:
        return ProductHandPickedWidget(
          widgetConfig: widget,
        );
      case productTag:
        return ProductTagWidget(
          widgetConfig: widget,
        );
      case productByCategory:
        return ProductByCategoryWidget(
          widgetConfig: widget,
        );
      case countdown:
        return CountdownWidget(
          widgetConfig: widget,
        );
      case spacer:
        return SpacerWidget(
          widgetConfig: widget,
        );
      case iconBox:
        return IconBoxWidget(
          widgetConfig: widget,
        );
      default:
        return Container(
          child: Text(widget.type),
        );
    }
  }
}
