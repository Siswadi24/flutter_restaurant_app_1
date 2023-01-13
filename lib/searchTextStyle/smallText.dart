import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String smallText;
  double size;
  double height;
  SmallText({
    Key? key,
    this.color = const Color(0xffccc7c5),
    required this.smallText,
    this.size = 12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      smallText,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
