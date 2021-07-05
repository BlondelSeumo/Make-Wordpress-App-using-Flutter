import 'package:flutter/material.dart';

class ProductBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        title: Row(
          children: [Text('Brand:'), TextButton(onPressed: () => print('1'), child: Text('Zaza'))],
        ),
        // isThreeLine: true,
        trailing: Image.network(
          'https://grocery.rnlab.io/wp-content/uploads/2020/12/hoodie-with-logo-2.jpg',
          width: 60,
          height: 34,
        ),
      ),
    );
  }
}
