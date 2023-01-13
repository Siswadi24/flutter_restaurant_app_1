import 'package:flutter/material.dart';
import 'package:restaurant_app/searchTextStyle/smallText.dart';

class IconsAndTextHomePage extends StatelessWidget {
  final IconData DataIcon;
  final String text;
  final Color iconColor;
  const IconsAndTextHomePage(
      {Key? key,
      required this.DataIcon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          DataIcon,
          color: iconColor,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          smallText: text,
        ),
      ],
    );
  }
}
