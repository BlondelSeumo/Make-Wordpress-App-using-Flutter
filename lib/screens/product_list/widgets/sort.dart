import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_text.dart';
import 'package:flutter/material.dart';

/// List sort data
const List listSortBy = [
  {'key': 'title'},
  {
    'key': 'product_list_default',
    'name': 'Default Sorting',
    'query': {
      'orderby': 'menu_order',
      'order': 'asc',
    }
  },
  {
    'key': 'product_list_popular',
    'name': 'Popular',
    'query': {
      'orderby': 'popularity',
      'order': 'desc',
    },
  },
  {
    'key': 'product_list_rating',
    'name': 'Rating',
    'query': {
      'orderby': 'rating',
      'order': 'desc',
    }
  },
  {
    'key': 'product_list_latest',
    'name': 'Latest',
    'query': {
      'orderby': 'date',
      'order': 'desc',
    }
  },
  {
    'key': 'product_list_low_to_high',
    'name': 'Low to high',
    'query': {
      'orderby': 'price',
      'order': 'asc',
    }
  },
  {
    'key': 'product_list_high_to_low',
    'name': 'High to Low',
    'query': {
      'orderby': 'price',
      'order': 'desc',
    }
  },
  {'key': 'button'},
];

class Sort extends StatefulWidget {
  final Map<String, dynamic> value;

  const Sort({Key key, this.value}) : super(key: key);

  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> with AppBarMixin, ShapeMixin {
  Map<String, dynamic> _sort;

  @override
  void didChangeDependencies() {
    setState(() {
      _sort = widget.value;
    });
    super.didChangeDependencies();
  }

  _onChanged(value) {
    setState(() {
      _sort = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.8,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return ListView.separated(
          controller: controller,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> item = listSortBy[index];

            if (item['key'] == 'title') {
              return Container(
                height: 48,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    translate('product_list_sort'),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              );
            }

            if (item['key'] == 'button') {
              return Container(
                height: 48,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _sort),
                  child: Text(translate("product_list_select")),
                ),
              );
            }

            return ListTile(
              leading: Radio(
                value: item['key'],
                groupValue: _sort['key'],
                onChanged: (key) => _onChanged(item),
              ),
              title: CirillaSubText(translate(item['key']), active: _sort['key'] == item['key']),
              onTap: () {
                _onChanged(item);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => index == 0
              ? SizedBox()
              : Divider(
                  indent: 20,
                  endIndent: 20,
                ),
          itemCount: listSortBy.length,
        );
      },
    );
  }
}
