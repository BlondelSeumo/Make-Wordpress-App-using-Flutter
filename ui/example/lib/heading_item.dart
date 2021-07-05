import 'package:flutter/material.dart';

class HeadingItemScreen extends StatelessWidget {
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
        padding: EdgeInsets.all(4),
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
            ListTile(
              horizontalTitleGap: 8,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              title: Text('Love Brands'),
              trailing: Text('See All'),
            ),
            ListTile(
              horizontalTitleGap: 8,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              leading:  Icon(Icons.home),
              title: Text('Love Brands'),
              trailing: Text('See All'),
            ),
            ListTile(
              horizontalTitleGap: 8,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              title: Text('Love Brands'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              horizontalTitleGap: 8,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              leading: FlutterLogo(),
              title: Row(
                children:[
                  Text('One-line'),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.red.withOpacity(0.5)),
                          )
                        ),
                      ),
                    )
                  ),
                ]
              ),
              // trailing: Text('See All'),
              trailing: Icon(Icons.chevron_right),
              onTap: () { /* react to the tile being tapped */ }
            ),
            ListTile(
              horizontalTitleGap: 8,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              leading: FlutterLogo(),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.red.withOpacity(0.5)),
                        )
                      ),
                      child:  Text('One-line'),
                    ),
                  )
                ]
              ),
              trailing: Text('See All'),
              onTap: () { /* react to the tile being tapped */ }
            ),
            ListTile(
              horizontalTitleGap: 8,
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              leading: FlutterLogo(),
              title: Text('One-line'),
              trailing:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('See All'),
                  Icon(Icons.chevron_right),
                ],
              ),
              onTap: () { /* react to the tile being tapped */ }
            ),
          ],
        ),
      )
    );
  }
}