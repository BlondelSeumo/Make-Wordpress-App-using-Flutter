import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class TimeCountItemScreen extends StatelessWidget {
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
        title: Text('Time Count Item'),
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
            TimeCount(
              times: ['4h', '26m', '6s'],
              textStyle: TextStyle(color: Color(0xFF0686F8)),
            ),
            SizedBox(height: 12),
            TimeCount(
              times: ['4h', '26m', '6s'],
              textStyle: TextStyle(color: Colors.white),
              color: Color(0xFF0686F8),
              borderRadius: BorderRadius.circular(4),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            ),
            SizedBox(height: 12),
            TimeCount.itemTime(
              times: ['4h', '26m', '6s'],
            ),
            SizedBox(height: 12),
            TimeCount.itemTime(
              times: ['4h', '26m', '6s'],
              textStyle: TextStyle(color: Color(0xFF0686F8)),
              symbolStyle: TextStyle(color: Color(0xFF647C9C)),
              border: Border.all(width: 2, color: Color(0xFFDEE2E6)),
            ),
            SizedBox(height: 12),
            TimeCount.itemTime(
              times: ['4h', '26m', '6s'],
              textStyle: TextStyle(color: Colors.white),
              symbolStyle: TextStyle(color: Color(0xFF647C9C)),
              color: Color(0xFF0686F8),
            ),
          ],
        ),
      ),
    );
  }
}
