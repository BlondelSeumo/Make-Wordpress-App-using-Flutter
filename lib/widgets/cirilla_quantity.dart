import 'package:flutter/material.dart';

class CirillaQuantity extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final double size;
  final Color color;
  final int min;
  final int max;
  final double radius;

  CirillaQuantity({
    Key key,
    this.value = 1,
    @required this.onChanged,
    this.size = 28,
    this.color,
    this.min = 1,
    this.max,
    this.radius = 4,
  })  : assert(size >= 28),
        assert(max == null || max > min),
        super(key: key);

  void clickQuantity(int newValue) {
    if (newValue >= min && (max == null || newValue <= max)) {
      onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => clickQuantity(value - 1),
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.remove_rounded,
                size: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(value.toString()),
          ),
          InkWell(
            onTap: () => clickQuantity(value + 1),
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.add_rounded,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
