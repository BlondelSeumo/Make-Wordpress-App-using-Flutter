import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

String image =
    'https://img.freepik.com/free-photo/white-cube-product-stand-white-room-studio-scene-product-minimal-design-3d-rendering_184920-218.jpg?size=338&ext=jpg';

class PostItemScreen extends StatelessWidget {
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
          title: Text('Post Item'),
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
              PostContainedItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(image),
                ),
                name: Text('PostContainedItem'),
                category: Text(
                  'Category',
                  style: TextStyle(color: Colors.white),
                ),
                date: Text('date'),
                author: Text('author'),
                comment: Text('comment'),
                onClick: () => print('click'),
              ),
              PostContainedItem(
                image: Image.network(
                  image,
                ),
                name: Text('PostContainedItem'),
                date: Text('date'),
                author: Text('author'),
                comment: Text('comment'),
                onClick: () => print('click'),
                borderRadius: BorderRadius.circular(8),
                paddingContent: EdgeInsets.all(16),
              ),
              SizedBox(height: 20),
              PostHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                ),
                name: Text('Test PostHorizontalItem'),
                date: Text('10/02/1990'),
                author: Text('author'),
                comment: Text('comment'),
                category: Text('category'),
                onClick: () => print('click'),
                // elevation: 10,
              ),
              PostHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                ),
                name: Text('Test PostHorizontalItem'),
                date: Text('10/02/1990'),
                author: Text('author'),
                comment: Text('comment'),
                category: Text('category'),
                onClick: () => print('click'),
              ),
              PostHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                ),
                name: Text('Test PostHorizontalItem'),
                date: Text('10/02/1990'),
                author: Text('author'),
                comment: Text('comment'),
                category: Text('category'),
                onClick: () => print('click'),
                isRightImage: true,
              ),
              SizedBox(height: 20),
              // PostHorizontalItem(
              //   post: post,
              //   isLeftImage: false,
              // ),
              PostNumberItem(
                number: Text(
                  '01',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: Color(0xFF0686F8)),
                ),
                name: Text('Name PostNumberItem'),
                category: Text('category'),
                date: Text('10/02/1990'),
                author: Text('author'),
                comment: Text('comment'),
                onClick: () => print('click'),
              ),
              PostOverlayItem(
                image: Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                ),
                name: Text('PostOverlayItem', style: TextStyle(color: Colors.white)),
                category: Text('Category', style: TextStyle(color: Colors.white)),
                date: Text('date', style: TextStyle(color: Colors.white)),
                author: Text('author', style: TextStyle(color: Colors.white)),
                comment: Text('comment', style: TextStyle(color: Colors.white)),
                excerpt: Text('description', style: TextStyle(color: Colors.white)),
                onClick: () => print('click'),
              ),
              PostGradientItem(
                image: Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 400,
                ),
                name: Text('PostGradientItem', style: TextStyle(color: Colors.white)),
                category: Text('Category', style: TextStyle(color: Colors.white)),
                date: Text('date', style: TextStyle(color: Colors.white)),
                author: Text('author', style: TextStyle(color: Colors.white)),
                comment: Text('comment', style: TextStyle(color: Colors.white)),
                description: Text('description', style: TextStyle(color: Colors.white)),
                onClick: () => print('click'),
              ),
              PostVerticalItem(
                image: Image.network(
                  image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                name: Text('PostVerticalItem'),
                category: Text('Category'),
                date: Text('date'),
                author: Text('author'),
                comment: Text('comment'),
                excerpt: Text('description'),
                onClick: () => print('click'),
                width: 200,
              ),
              PostEmergeItem(
                image: Image.network(
                  image,
                  width: 335,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                name: Text('PostEmergeItem'),
                category: Text('Category'),
                date: Text('date'),
                author: Text('author'),
                comment: Text('comment'),
                excerpt: Text('description'),
                onClick: () => print('click'),
                width: 335,
              ),
              PostTimeLineItem(
                image: Image.network(
                  image,
                  width: 335,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                name: Text('PostTimeLineItem'),
                category: Text('Category'),
                headingInfo: Text('Heading'),
                left: Text('left'),
                description: Text('description'),
                onClick: () => print('click'),
              ),
              SizedBox(height: 20),
              PostTopNameItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 335,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                name: Text('PostTopNameItem'),
                category: Text('Category'),
                date: Text('date'),
                author: Text('author'),
                comment: Text('comment'),
                excerpt: Text('description'),
                onClick: () => print('click'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
