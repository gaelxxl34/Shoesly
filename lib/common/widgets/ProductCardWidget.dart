import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final int reviews;
  final double rating;

  ProductCardWidget({
    required this.image,
    required this.name,
    required this.price,
    required this.reviews,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.45, // Adjust width based on screen width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.15, // Adjust height based on screen height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(image), // Use NetworkImage instead of AssetImage
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.025), // Adjust padding based on screen width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04, // Adjust font size based on screen width
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Adjust spacing based on screen height
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.035, // Adjust font size based on screen width
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Adjust spacing based on screen height
                Row(
                  children: [
                    ...buildStarRating(rating, screenWidth * 0.035), // Adjust star size based on screen width
                    SizedBox(width: screenWidth * 0.02), // Adjust spacing based on screen width
                    Flexible(
                      child: Text(
                        '${rating.toStringAsFixed(2)} ($reviews RV)',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.03, // Adjust font size based on screen width
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildStarRating(double rating, double starSize) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    int halfStars = ((rating - fullStars) * 2).round();

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow, size: starSize));
    }
    if (halfStars == 1) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow, size: starSize));
    }
    for (int i = fullStars + halfStars; i < 5; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow, size: starSize));
    }
    return stars;
  }
}
