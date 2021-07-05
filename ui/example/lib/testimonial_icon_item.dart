import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class TestimonialItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
        title: Text('Testimonial & Icon box Item'),
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
            Text('TestimonialBasicItem'),
            TestimonialBasicItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle2),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 72,
                  height: 72,
                ),
              ),
              width: 310,
            ),
            SizedBox(height: 20),
            TestimonialBasicItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle2),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 72,
                  height: 72,
                ),
              ),
              width: 310,
              color: Color(0xFFF4F4F4),
            ),
            SizedBox(height: 20),
            TestimonialBasicItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle2),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 72,
                  height: 72,
                ),
              ),
              width: 310,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(height: 20),
            TestimonialBasicItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle2),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 72,
                  height: 72,
                ),
              ),
              width: 310,
              elevation: 5,
            ),
            SizedBox(height: 20),
            Text('TestimonialContainedItem'),
            TestimonialContainedItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              user: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(isCenter: true),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              job: Text('Product Designer', style: theme.textTheme.caption),
              width: 301,
            ),
            SizedBox(height: 20),
            TestimonialContainedItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              user: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(isCenter: true),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              job: Text('Product Designer', style: theme.textTheme.caption),
              width: 301,
              color: Color(0xFFF4F4F4),
            ),
            SizedBox(height: 20),
            TestimonialContainedItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              user: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(isCenter: true),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              job: Text('Product Designer', style: theme.textTheme.caption),
              width: 301,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(height: 20),
            TestimonialContainedItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              user: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(isCenter: true),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              job: Text('Product Designer', style: theme.textTheme.caption),
              width: 301,
              elevation: 5,
            ),
            SizedBox(height: 20),
            Text('TestimonialHorizontalItem'),
            TestimonialHorizontalItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              subtitle: Text('Product Designer', style: theme.textTheme.caption),
              width: 377,
            ),
            SizedBox(height: 20),
            TestimonialHorizontalItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              subtitle: Text('Product Designer', style: theme.textTheme.caption),
              width: 377,
              color: Color(0xFFF4F4F4),
            ),
            SizedBox(height: 20),
            TestimonialHorizontalItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              subtitle: Text('Product Designer', style: theme.textTheme.caption),
              width: 377,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(height: 20),
            TestimonialHorizontalItem(
              description: Text(
                'Using Ollie made it easy to experiment with different layouts and design combinations. Within minutes, we were building a production-ready site.',
                style: theme.textTheme.bodyText1,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              rating: buildRating(),
              image: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
              subtitle: Text('Product Designer', style: theme.textTheme.caption),
              width: 377,
              elevation: 5,
            ),
            SizedBox(height: 20),
            Text('IconBoxContainedItem'),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
                textAlign: TextAlign.center,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
              alignment: CrossAxisAlignment.center,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
                textAlign: TextAlign.right,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
              alignment: CrossAxisAlignment.end,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xFF0686F8), shape: BoxShape.circle),
                child: Icon(
                  Icons.anchor,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
                textAlign: TextAlign.center,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF0686F8)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.anchor,
                  size: 22,
                  color: Color(0xFF0686F8),
                ),
              ),
              width: 280,
              alignment: CrossAxisAlignment.center,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
                textAlign: TextAlign.right,
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xFF0686F8), shape: BoxShape.circle),
                child: Icon(
                  Icons.anchor,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              width: 280,
              alignment: CrossAxisAlignment.end,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF0686F8)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.anchor,
                  size: 22,
                  color: Color(0xFF0686F8),
                ),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxContainedItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF0686F8)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.anchor,
                  size: 22,
                  color: Color(0xFF0686F8),
                ),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            Text('IconBoxHorizontalItem'),
            IconBoxHorizontalItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxHorizontalItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            IconBoxHorizontalItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
            ),
            SizedBox(height: 20),
            Text('IconBoxHorizontalItem type2'),
            IconBoxHorizontalItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
              type: IconBoxHorizontalItemType.style2,
            ),
            SizedBox(height: 20),
            IconBoxHorizontalItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
              type: IconBoxHorizontalItemType.style2,
            ),
            SizedBox(height: 20),
            IconBoxHorizontalItem(
              description: Text(
                'A wealth of styles and elements makes Ollie perfect for building websites for small',
                style: theme.textTheme.bodyText1?.copyWith(color: Color(0xFF647C9C)),
              ),
              title: Text('Sarah Jones', style: theme.textTheme.subtitle1),
              icon: Icon(
                Icons.anchor,
                size: 36,
                color: Color(0xFF0686F8),
              ),
              width: 280,
              type: IconBoxHorizontalItemType.style2,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildRating({bool isCenter = false}) {
    return Row(
      mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          size: 12,
          color: Color(0xFFFFA200),
        ),
        Icon(
          Icons.star,
          size: 12,
          color: Color(0xFFFFA200),
        ),
        Icon(
          Icons.star,
          size: 12,
          color: Color(0xFFFFA200),
        ),
        Icon(
          Icons.star_border,
          size: 12,
          color: Color(0xFF9FADC0),
        ),
        Icon(
          Icons.star_border,
          size: 12,
          color: Color(0xFF9FADC0),
        ),
      ],
    );
  }
}
