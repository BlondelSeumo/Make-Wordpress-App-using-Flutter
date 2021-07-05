import 'package:flutter/material.dart';

abstract class Grid extends StatefulWidget {
  final int itemCount;
  final int crossAxisCount;
  final double axisSpacing;

  Grid({
    Key key,
    this.itemCount = 4,
    this.crossAxisCount = 2,
    this.axisSpacing = 0,
  })  : assert(crossAxisCount > 0),
        assert(axisSpacing >= 0),
        assert(itemCount > 0),
        super(key: key);

  @override
  _GridState createState() => _GridState();

  @protected
  Widget buildLayout(BuildContext context, int index, double width);
}

class _GridState extends State<Grid> {
  GlobalKey _keyContainer = GlobalKey();
  double widthView = 300;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(_getSizes);
    super.initState();
  }

  _getSizes(_) {
    final double width = _keyContainer.currentContext?.size?.width ?? 300;
    setState(() {
      widthView = width;
    });
  }

  @override
  Widget build(BuildContext context) {
    int col = (widget.itemCount / widget.crossAxisCount).ceil();
    double widthItem = (widthView - (widget.crossAxisCount - 1) * widget.axisSpacing) / widget.crossAxisCount;

    return Container(
      key: _keyContainer,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(col, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index < col - 1 ? widget.axisSpacing : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < widget.crossAxisCount; i++) ...[
                  if (i > 0)
                    SizedBox(
                      width: widget.axisSpacing,
                    ),
                  Expanded(
                    child: index * widget.crossAxisCount + i < widget.itemCount
                        ? widget.buildLayout(context, (index * widget.crossAxisCount) + i, widthItem)
                        : Container(),
                  ),
                ]
              ],
            ),
          );
        }),
      ),
    );
  }
}
