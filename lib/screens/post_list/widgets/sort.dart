import 'package:cirilla/types/actions.dart';
import 'package:flutter/material.dart';

/// List sort data
const List listSortBy = [
  {
    'key': 'latest',
    'name': 'Latest',
    'query': {
      'order': 'desc',
      'orderby': 'date',
    }
  },
  {
    'key': 'oldest',
    'name': 'Oldest',
    'query': {
      'order': 'asc',
      'orderby': 'date',
    }
  },
];

class Sort extends StatelessWidget {
  final Map value;
  final onChangedBlogType onChanged;

  const Sort({Key key, @required this.value, @required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Sort By',
              style: theme.textTheme.subtitle1,
            ),
          ),
          ...List.generate(listSortBy.length, (index) {
            Map item = listSortBy[index];
            return Column(
              children: [
                ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: Radio(
                      value: item['key'],
                      groupValue: value['key'],
                      onChanged: (dynamic value) {
                        onChanged(sort: item);
                        Navigator.pop(context);
                      },
                      toggleable: true,
                      splashRadius: 0,
                    ),
                  ),
                  title: Text(
                    item['name'],
                    style: theme.textTheme.bodyText1,
                  ),
                  enabled: item['key'] != value['key'],
                  onTap: () {
                    onChanged(sort: item);
                    Navigator.pop(context);
                  },
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 36,
                  minVerticalPadding: 0,
                ),
                Divider(height: 1, thickness: 1),
              ],
            );
          }),
        ],
      ),
    );
  }
}
