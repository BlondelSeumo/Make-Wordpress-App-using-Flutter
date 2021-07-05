import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ImageItemScreen extends StatelessWidget {
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
        title: Text('Image Item'),
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
            Text('Style1 - ImageContainedItem'),
            SizedBox(height: 10),
            ImageFooterItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              title: Text('Title', style: TextStyle(color: Colors.red)),
              subTitle: Text('Subtitle', style: TextStyle(color: Colors.red)),
              footer: Text('Footer', style: TextStyle(color: Colors.red)),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style2 - ImageContainedItem'),
            SizedBox(height: 10),
            ImageFooterItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              footer: Text('Footer', style: TextStyle(color: Colors.red)),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style3 - ImageAlignmentItem'),
            SizedBox(height: 10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: TextStyle(color: Colors.red)),
              title: Text('title', style: TextStyle(color: Colors.red)),
              trailing: Text('trailing', style: TextStyle(color: Colors.red)),
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style4 - ImageAlignmentItem'),
            SizedBox(height: 10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: TextStyle(color: Colors.red)),
              trailing: Text('trailing', style: TextStyle(color: Colors.red)),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style5 - ImageAlignmentItem'),
            SizedBox(height: 10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: TextStyle(color: Colors.red)),
              title: Text('Title', style: TextStyle(color: Colors.red)),
              trailing: Text('trailing', style: TextStyle(color: Colors.red)),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style6 - ImageFooterItem'),
            SizedBox(height: 10),
            ImageFooterItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              title: Container(
                alignment: Alignment.centerRight,
                child: Text('Title', style: TextStyle(color: Colors.red)),
              ),
              footer: Text('Footer', style: TextStyle(color: Colors.red)),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style7 - ImageAlignmentItem'),
            SizedBox(height: 10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: TextStyle(color: Colors.red)),
              trailing: Text('trailing', style: TextStyle(color: Colors.red)),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              padding: EdgeInsets.all(24),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Style8 - ImageAlignmentItem'),
            SizedBox(height: 10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: TextStyle(color: Colors.red)),
              title: Text('title', style: TextStyle(color: Colors.red)),
              trailing: Container(
                alignment: Alignment.centerRight,
                child: Text('trailing', style: TextStyle(color: Colors.red)),
              ),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.all(24),
              onTap: () => print('click'),
            ),
            SizedBox(height: 30),
            Text('Slideshow style 1 - ImageAlignmentItem'),
            SizedBox(height: 10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: TextStyle(color: Colors.red)),
              title: Text('title', style: TextStyle(color: Colors.red)),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.all(24),
              onTap: () => print('click'),
            ),
            Text('Slideshow style 2 - ImageFooterItem'),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageFooterItem(
                image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
                title: Text('Title', style: TextStyle(color: Colors.red)),
                subTitle: Text('Subtitle', style: TextStyle(color: Colors.red)),
                footer: Text('Footer', style: TextStyle(color: Colors.red)),
                crossAxisAlignment: CrossAxisAlignment.start,
                onTap: () => print('click'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
