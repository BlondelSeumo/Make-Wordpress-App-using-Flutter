import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class BadgeItemScreen extends StatelessWidget {
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
          title: Text('Badge Item'),
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
              Text('Badge text default'),
              Badge(
                text: Text("Fashion"),
                color: Color(0xFF21BA45),
              ),
              Text('Badge text & icon default'),
              Badge(
                text: Text("6"),
                icon: Icon(Icons.image_outlined),
                size: 23,
                onTap: () => print('aaa'),
                color: Colors.black.withOpacity(0.5),
              ),
              Text('Badge icon default'),
              BadgeIcon(
                icon: Icon(Icons.music_note),
                color: Colors.black.withOpacity(0.5),
              ),
              BadgeIcon(
                icon: Icon(Icons.pause_outlined),
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ));
  }
}
