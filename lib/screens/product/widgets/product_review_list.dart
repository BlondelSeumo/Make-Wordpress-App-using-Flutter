import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product_review/product_review.dart';
import 'package:cirilla/store/product/review_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/utils/date_format.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ui/image/image_loading.dart';
import 'package:ui/ui.dart';
import 'product_review_form.dart';

class ProductReviewList extends StatefulWidget {
  final Product product;
  final ProductReviewStore store;

  const ProductReviewList({Key key, this.product, this.store}) : super(key: key);

  @override
  _ProductReviewListState createState() => _ProductReviewListState();
}

class _ProductReviewListState extends State<ProductReviewList> with TransitionMixin, ScrollMixin, LoadingMixin {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients || widget.store.loading || !widget.store.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      widget.store.getReviews();
    }
  }

  @override
  void didChangeDependencies() {
    widget.store.getReviews();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;

    return Observer(builder: (_) {
      return Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 70,
          alignment: Alignment.center,
          child: SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, _a1, _a2) => ProductReviewForm(
                      store: widget.store,
                      productId: widget.product.id,
                      product: BasicProductReview(
                        product: widget.product,
                      ),
                    ),
                    transitionsBuilder: slideTransition,
                  ),
                );
              },
              child: Text(translate('product_write_review')),
            ),
          ),
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              centerTitle: true,
              elevation: 0,
              floating: true,
              pinned: true,
              title: Text(translate('product_reviews'), style: Theme.of(context).textTheme.subtitle1),
            ),
            SliverToBoxAdapter(
              child: BasicProductReview(
                product: widget.product,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: BasicInfoReview(
                      product: widget.product,
                      store: widget.store,
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildItem(context, review: widget.store.reviews[index]);
                  },
                  childCount: widget.store.reviews.length,
                ),
              ),
            ),
            if (widget.store.loading)
              SliverToBoxAdapter(
                child: buildLoading(context, isLoading: widget.store.canLoadMore),
              ),
          ],
        ),
      );
    });
  }

  Widget buildItem(BuildContext context, {ProductReview review}) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: CommentContainedItem(
            image: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: ImageLoading(
                review.reviewerAvatarUrls['48'] ?? Assets.noImageUrl,
                width: 48,
                height: 48,
              ),
            ),
            name: Text(review.reviewer, style: theme.textTheme.subtitle2),
            comment: Html(
              data: review.review,
            ),
            date: Text(formatDate(date: review.dateCreated), style: theme.textTheme.caption),
            rating: CirillaRating(initialValue: review.rating * 1.0),
            onClick: () {},
          ),
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}

class BasicInfoReview extends StatefulWidget {
  final Product product;
  final ProductReviewStore store;

  const BasicInfoReview({Key key, this.product, this.store}) : super(key: key);

  @override
  _BasicInfoReviewState createState() => _BasicInfoReviewState();
}

class _BasicInfoReviewState extends State<BasicInfoReview> with SnackMixin {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;

    return Observer(
      builder: (_) {
        double rating = ConvertData.stringToDouble(widget.product.averageRating);
        int ratingCount = widget.product.ratingCount;
        int r1 = widget.store.ratingCount.r1;
        int r2 = widget.store.ratingCount.r2;
        int r3 = widget.store.ratingCount.r3;
        int r4 = widget.store.ratingCount.r4;
        int r5 = widget.store.ratingCount.r5;

        List data = [
          {
            'star': 5,
            'reviews': r5,
            'percent': ratingCount > 0 ? (r5 / ratingCount) * 100 : 0,
          },
          {
            'star': 4,
            'reviews': r4,
            'percent': ratingCount > 0 ? (r4 / ratingCount) * 100 : 0,
          },
          {
            'star': 3,
            'reviews': r3,
            'percent': ratingCount > 0 ? (r3 / ratingCount) * 100 : 0,
          },
          {
            'star': 2,
            'reviews': r2,
            'percent': ratingCount > 0 ? (r2 / ratingCount) * 100 : 0,
          },
          {
            'star': 1,
            'reviews': r1,
            'percent': ratingCount > 0 ? (r1 / ratingCount) * 100 : 0,
          },
        ];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: theme.primaryColor),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(rating.toString(), style: theme.textTheme.headline4.copyWith(color: theme.primaryColor)),
                ),
                SizedBox(height: 8),
                Text(
                  ratingCount > 1
                      ? translate('product_count_reviews', {'count': ratingCount.toString()})
                      : translate('product_count_review', {'count': ratingCount.toString()}),
                  style: theme.textTheme.caption,
                ),
                CirillaRating(initialValue: rating),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: FlexColumnWidth(),
                  3: IntrinsicColumnWidth(),
                  4: IntrinsicColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  for (var i = 0; i < data.length; i++) ...[
                    TableRow(
                      children: [
                        Container(
                          child: Text(translate('product_star_review', {'visit': '${data[i]['star']}'}),
                              style: theme.textTheme.caption),
                        ),
                        SizedBox(width: 16),
                        // Text('aaa'),
                        CirillaRating.line(
                          defaultRating: data[i]['reviews'],
                          count: ratingCount,
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Text('${(data[i]['percent']).round()}%', style: theme.textTheme.caption),
                        ),
                      ],
                    ),
                    if (i < data.length - 1)
                      TableRow(
                        children: [
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                        ],
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class BasicProductReview extends StatelessWidget with ProductMixin {
  final Product product;

  const BasicProductReview({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: theme.dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: buildImage(context, product: product, width: 50, height: 60),
                ),
                SizedBox(width: 18),
                Expanded(child: Text(product.name, style: theme.textTheme.bodyText2)),
                SizedBox(width: 18),
                buildPrice(context, product: product),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }
}
