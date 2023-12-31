import 'package:flutter/material.dart';

class CollectItem extends StatelessWidget {
  const CollectItem({
    Key? key,
    required this.name,
    required this.image,
    required this.rate,
  }) : super(key: key);

  final String name;
  final String image;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ThemeData().unselectedWidgetColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Image.network(
            image,
            width: 48,
            height: 48,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: rate / 10,
            backgroundColor: ThemeData().unselectedWidgetColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              ThemeData().primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
