import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class VendorItemScreen extends StatelessWidget {
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
          title: Text('Vendor Item'),
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
              VendorContainedItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 60,
                    height: 60,
                  ),
                ),
                name: Text('Name'),
                feature: Text('Featured'),
                rating: Text('Rating'),
                onClick: () {},
              ),
              VendorHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                    width: 60,
                    height: 60,
                  ),
                ),
                name: Text('Name'),
                feature: Text('Featured'),
                rating: Text('Rating'),
                onClick: () {},
              ),
            ],
          ),
        ));
  }
}
