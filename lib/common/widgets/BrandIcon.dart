import 'package:flutter/material.dart';

class BrandIcon extends StatelessWidget {
  final String name;
  final String image;

  BrandIcon({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(image),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 5),
          Text(name),
        ],
      ),
    );
  }
}