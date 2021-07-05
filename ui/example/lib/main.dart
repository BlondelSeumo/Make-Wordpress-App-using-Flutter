import 'package:example/badge_item.dart';
import 'package:example/button_select_item.dart';
import 'package:example/comment_item.dart';
import 'package:example/heading_item.dart';
import 'package:example/image_item.dart';
import 'package:example/post_category_item.dart';
import 'package:example/post_item.dart';
import 'package:example/product_category_item.dart';
import 'package:example/product_item.dart';
import 'package:example/search.dart';
import 'package:example/testimonial_icon_item.dart';
import 'package:example/time_count_item.dart';
import 'package:example/vendor_item.dart';
import 'package:example/list_title_item.dart';
import 'package:example/user_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Home'),

        // Post Item
        '/post_item': (context) => PostItemScreen(),

        // Post category item
        '/post_category_item': (context) => PostCategoryItemScreen(),

        '/category_item': (context) => ProductCategoryItemScreen(),

        // Comment item
        '/comment_item': (context) => CommentHorizontalItemScreen(),

        // Product item
        '/product_item': (context) => ProductItemScreen(),

        // Heading item
        '/heading_item': (context) => HeadingItemScreen(),

        // Badge item
        '/badge_item': (context) => BadgeItemScreen(),

        // Button select item
        '/button_select_item': (context) => ButtonSelectItemScreen(),

        // Vendor item
        '/vendor_item': (context) => VendorItemScreen(),

        // Search item
        '/search_item': (context) => SearchItemScreen(),

        // Image item
        '/image_item': (context) => ImageItemScreen(),

        // Time count item
        '/time_count_item': (context) => TimeCountItemScreen(),

        // Testimonial and icon box item
        '/testimonial_icon_item': (context) => TestimonialItemScreen(),

        '/list_title_item': (context) => ListTitleItemScreen(),

        '/user_item': (context) => UserItemScreen(),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
    });
  }

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
        title: Text(widget.title!),
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
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/post_item'), child: Text('Blog Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/post_category_item'),
                child: Text('Category Blog Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/comment_item'), child: Text('Comment Blog Item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/product_item'), child: Text('Product Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/category_item'), child: Text('Category Item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/heading_item'), child: Text('heading Item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/badge_item'), child: Text('Badge Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/button_select_item'),
                child: Text('Button Select Item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/vendor_item'), child: Text('Vendor Item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/search_item'), child: Text('Search Item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/image_item'), child: Text('Image Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/time_count_item'), child: Text('Time count Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/testimonial_icon_item'),
                child: Text('Testimonial & Icon box Item')),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/list_title_item'), child: Text('List title item')),
            TextButton(onPressed: () => Navigator.of(context).pushNamed('/user_item'), child: Text('User item')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
