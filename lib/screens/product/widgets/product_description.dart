import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class ProductDescription extends StatelessWidget with TransitionMixin {
  final Product product;
  final bool expand;
  final String align;

  const ProductDescription({Key key, this.product, this.expand, this.align = 'left'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;

    if (expand) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              translate('product_description'),
              textAlign: ConvertData.toTextAlign(align),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          buildContent(description: product.description),
        ],
      );
    }
    return CirillaTile(
      title: Text(translate('product_description'), style: theme.textTheme.subtitle2),
      isDivider: false,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _a1, _a2) => ProductDescriptionModal(
              description: product.description,
              content: buildContent(description: product.description),
            ),
            transitionsBuilder: slideTransition,
          ),
        );
      },
    );
  }

  buildContent({String description}) {
    return Html(
      data: description,
      style: {
        'p': Style(
          lineHeight: LineHeight(1.8),
          fontSize: FontSize(15),
        ),
        'div': Style(
          lineHeight: LineHeight(1.8),
          fontSize: FontSize(15),
        ),
        'img': Style(
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
      },
    );
  }
}

class ProductDescriptionModal extends StatelessWidget with AppBarMixin, TransitionMixin {
  final String description;
  final Widget content;

  const ProductDescriptionModal({Key key, this.description, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          translate('product_description'),
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FeatherIcons.x,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [content],
      ),
    );
  }
}
