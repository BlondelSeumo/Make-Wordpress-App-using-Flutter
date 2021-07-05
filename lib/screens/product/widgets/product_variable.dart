import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/product/variation_store.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductVariable extends StatelessWidget with LoadingMixin {
  final Product product;
  final VariationStore store;
  final TextAlign alignTitle;

  const ProductVariable({Key key, this.product, this.store, this.alignTitle = TextAlign.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (store.data == null) {
        return buildLoading(
          context,
          isLoading: store.loading,
        );
      }

      Map<String, String> labels = store.data['attribute_labels'];

      return Stack(
        children: [
          ListView.separated(
            itemBuilder: (_, int index) {
              return Attr(
                id: labels.keys.elementAt(index),
                label: labels[labels.keys.elementAt(index)],
                store: store,
                alignTitle: alignTitle,
              );
            },
            separatorBuilder: (_, int index) {
              return SizedBox(height: 24);
            },
            itemCount: labels.keys.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
          Positioned(
            child: InkWell(
              onTap: store.clear,
              child: Text(
                AppLocalizations.of(context).translate('product_clear_all'),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            top: 0,
            right: 0,
          ),
        ],
      );
    });
  }
}

class Attr extends StatelessWidget {
  final String id;
  final String label;
  final VariationStore store;
  final TextAlign alignTitle;

  const Attr({Key key, this.id, this.label, this.store, this.alignTitle = TextAlign.start}) : super(key: key);

  bool check(String option) {
    if (store.selected.isEmpty) return true;

    // Pre data if select the term
    Map<String, String> _selected = Map<String, String>.of(store.selected);
    if (_selected.containsKey(id)) {
      _selected.update(id, (value) => option);
    } else {
      _selected.putIfAbsent(id, () => option);
    }

    return store.data['variations'].any((element) {
      Map<String, String> attributes = Map<String, String>.from(element['attributes']);
      return _selected.keys.every(
        (el) {
          String key = "attribute_${el.toLowerCase()}";
          return attributes[key] == null || attributes[key] == '' || attributes[key] == _selected[el];
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Observer(
      builder: (_) {
        Map<String, List<String>> terms = store.data['attribute_terms'];
        Map<String, String> labels = store.data['attribute_terms_labels'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: RichText(
                textAlign: alignTitle,
                text: TextSpan(text: '$label: ', style: theme.textTheme.bodyText2, children: [
                  if (store.selected[id] != null)
                    TextSpan(
                      text: labels['${id}_${store.selected[id]}'],
                    )
                ]),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 38,
              child: ListView.separated(
                itemCount: terms[id].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Term(
                  label: labels['${id}_${terms[id][index]}'],
                  option: terms[id][index],
                  isSelected: terms[id][index] == store.selected[id],
                  canSelect: check(terms[id][index]),
                  onSelectTerm: () => store.selectTerm(key: id, value: terms[id][index]),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Term extends StatelessWidget {
  final String option;
  final String label;
  final bool isSelected;
  final bool canSelect;
  final Function onSelectTerm;

  const Term({
    Key key,
    this.option,
    this.label,
    this.isSelected,
    this.onSelectTerm,
    this.canSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle titleButton = theme.textTheme.bodyText2;
    if (isSelected) {
      return OutlinedButton(
        child: Text(label),
        onPressed: onSelectTerm,
        style: OutlinedButton.styleFrom(
          primary: theme.primaryColor,
          side: BorderSide(width: 2, color: theme.primaryColor),
          textStyle: titleButton,
          minimumSize: Size(40, 0),
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
      );
    }
    return OutlinedButton(
      child: Text(label),
      onPressed: !canSelect ? null : onSelectTerm,
      style: OutlinedButton.styleFrom(
        primary: titleButton.color,
        side: BorderSide(width: 1, color: theme.dividerColor),
        textStyle: titleButton,
        minimumSize: Size(40, 0),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
