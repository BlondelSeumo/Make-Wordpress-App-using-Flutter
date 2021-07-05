import 'package:cirilla/widgets/cirilla_rating.dart';
import 'package:flutter/material.dart';

class ProductVendor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        // border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        title: Text('Everlane Look'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Feature'),
            CirillaRating(
              count: 5,
              initialValue: 4,
            ),
          ],
        ),
        isThreeLine: true,
        trailing: Image.network(
          'https://grocery.rnlab.io/wp-content/uploads/2020/12/hoodie-with-logo-2.jpg',
          width: 60,
          height: 60,
        ),
      ),
    );
  }
}
