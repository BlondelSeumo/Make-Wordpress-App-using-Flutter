import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class PostCategoryItemScreen extends StatelessWidget {
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
          title: Text('Category Post Item'),
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
              PostCategoryItemContained(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(55),
                  child: Image.network(
                    'https://p.bigstockphoto.com/GeFvQkBbSLaMdpKXF1Zv_bigstock-Aerial-View-Of-Blue-Lakes-And--227291596.jpg',
                    width: 109,
                    height: 109,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Lifestyle'),
                count: Container(
                  width: 26.0,
                  height: 26.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '12',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onClick: () => print('click'),
              ),
              SizedBox(
                height: 15,
              ),
              PostCategoryItemHorizontal(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    'https://p.bigstockphoto.com/GeFvQkBbSLaMdpKXF1Zv_bigstock-Aerial-View-Of-Blue-Lakes-And--227291596.jpg',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Lifestyle'),
                count: Text('6'),
                color: Colors.red,
                onClick: () {},
              ),
              SizedBox(
                height: 15,
              ),
              PostCategoryItemGradient(
                image: Image.network(
                  'https://p.bigstockphoto.com/GeFvQkBbSLaMdpKXF1Zv_bigstock-Aerial-View-Of-Blue-Lakes-And--227291596.jpg',
                  width: 245,
                  height: 109,
                  fit: BoxFit.cover,
                ),
                title: Text('Castiglione', style: TextStyle(color: Colors.white)),
                count: Text('43', style: TextStyle(color: Colors.white)),
                onClick: () {},
                width: 245,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
