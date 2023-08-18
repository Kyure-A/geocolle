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
    return Container(
      child: Column(
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
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(image),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: rate / 100,
              backgroundColor: ThemeData().unselectedWidgetColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                ThemeData().primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
