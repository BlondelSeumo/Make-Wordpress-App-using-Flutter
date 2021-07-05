import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

String image =
    'https://dyl80ryjxr1ke.cloudfront.net/external_assets/hero_examples/hair_beach_v1785392215/original.jpeg';

class ProductCategoryItemScreen extends StatelessWidget {
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
          title: Text('Product Category Item'),
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProductCategoryContainedItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(image, width: 109, height: 109, fit: BoxFit.cover),
                ),
                name: Text('Contained', textAlign: TextAlign.center),
                onClick: () => print('click'),
                width: 109,
              ),
              ProductCategoryOverlayItem(
                image: Image.network(
                  image,
                  width: 160,
                  height: 160,
                ),
                name: Text(
                  'Overlay',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onClick: () => print('click'),
              ),
              ProductCategoryHorizontalItem(
                image: Image.network(
                  image,
                  width: 92,
                  height: 92,
                  fit: BoxFit.cover,
                ),
                name: Text('Horizontal'),
                count: Text('12 items'),
                color: Colors.orange,
                onClick: () => print('click'),
              ),
              ProductCategoryCardItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Card'),
                count: Text('12 items'),
                color: Colors.yellow,
                onClick: () => print('click'),
              ),
              ProductCategoryCardItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('Card'),
                count: Text('12 items'),
                color: Colors.yellow,
                type: 'block',
                onClick: () => print('click'),
              ),
              ProductCategoryBasicItem(
                // image: ClipRRect(
                //   borderRadius: BorderRadius.circular(30),
                //   child: Image.network(
                //     image,
                //     width: 60,
                //     height: 60,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                name: Text('Basic'),
                icon: Icon(Icons.bookmark),
                // count: Text('12 items'),
                // color: Colors.yellow,
                onClick: () => print('click'),
              ),
              ProductCategoryGridItem(
                name: Text('Grid'),
                action: TextButton(
                  onPressed: () => print('click'),
                  child: Text('Show all'),
                ),
                child: Text('Child category grid'),
              ),
              ProductCategoryTextCenterItem(
                onTap: () {},
                name: Text('text center'),
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ProductCategoryTextLeftItem(
                onTap: () {},
                name: Text('text center'),
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 200),
            ],
          ),
        ));
  }
}
