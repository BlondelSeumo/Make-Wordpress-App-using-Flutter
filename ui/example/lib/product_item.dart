import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ProductItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Product Item'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              ProductContainedItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  ),
                ),
                name: Text('Name'),
                price: Text('Price'),
                tagExtra: Text(
                  'Tax Extra',
                  style: TextStyle(color: Colors.white),
                ),
                wishlist: Text('wishlist'),
                addCard: Text('Button add', style: TextStyle(color: Colors.white)),
                rating: Text('rating'),
                onClick: () => print('product'),
              ),
              SizedBox(
                height: 15,
              ),
              ProductHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 70,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Name'),
                price: Text('Price'),
                tagExtra: Text('Tax Extra'),
                addCard: Text('Button add'),
                rating: Text('rating'),
                onClick: () => print('product'),
              ),
              SizedBox(
                height: 15,
              ),
              ProductCardItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 70,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Name'),
                price: Text('Price'),
                quantity: Text('quantity'),
                attribute: Text('attribute'),
                onClick: () => print('product'),
              ),
              ProductEmergeItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 160,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Name'),
                price: Text('Price'),
                category: Text('Category'),
                tagExtra: Text(
                  'Tax',
                  style: TextStyle(color: Colors.white),
                ),
                addCard: Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('A'),
                ),
                rating: Text('rating'),
                wishlist: Text('W'),
                onClick: () => print('product'),
                width: 160,
              ),
              SizedBox(height: 20),
              Text('ProductVerticalItem'),
              SizedBox(height: 12),
              ProductVerticalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 160,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Name'),
                price: Text('Price'),
                category: Text('Category'),
                tagExtra: Text(
                  'Tax',
                  style: TextStyle(color: Colors.white),
                ),
                addCard: Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('A'),
                ),
                rating: Text('rating'),
                wishlist: Text('W'),
                onClick: () => print('product'),
                width: 160,
              ),
              SizedBox(height: 20),
              Text('ProductVerticalItem center'),
              SizedBox(height: 12),
              ProductVerticalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 160,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Name'),
                price: Text('Price'),
                category: Text('Category'),
                tagExtra: Text(
                  'Tax',
                  style: TextStyle(color: Colors.white),
                ),
                addCard: Container(
                  height: 34,
                  width: 100,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text('A'),
                ),
                rating: Text('rating'),
                wishlist: Text('W'),
                onClick: () => print('product'),
                width: 160,
                type: ProductVerticalItemType.center,
              ),
            ],
          ),
        ));
  }
}
