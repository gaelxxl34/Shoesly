import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/review_controller.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reviewController = Provider.of<ReviewController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Reviews', style: TextStyle(color: Colors.white),),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 0) {
                reviewController.clearFilter();
              } else {
                reviewController.filterReviewsByStars(value);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('All Stars')),
              PopupMenuItem(value: 5, child: Text('5 Stars')),
              PopupMenuItem(value: 4, child: Text('4 Stars')),
              PopupMenuItem(value: 3, child: Text('3 Stars')),
              PopupMenuItem(value: 2, child: Text('2 Stars')),
              PopupMenuItem(value: 1, child: Text('1 Star')),
            ],
          ),
        ],
      ),
      body: reviewController.isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blueAccent,))
          : ListView.builder(
        itemCount: reviewController.productReviews.length,
        itemBuilder: (context, index) {
          final product = reviewController.productReviews[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.network(
                  product['imageUrl'],
                  width: 60,
                  height: 60,
                ),
                title: Text(
                  product['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...buildReviewTiles(product['reviews']),
            ],
          );
        },
      ),
    );
  }

  List<Widget> buildReviewTiles(List<dynamic> reviews) {
    if (reviews.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'No reviews yet. Be the first to add a review!',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ),
      ];
    }

    return reviews.map((review) {
      return ListTile(
        title: Text(review['userEmail'] ?? 'Anonymous'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (starIndex) {
                return Icon(
                  starIndex < review['rating'] ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                );
              }),
            ),
            SizedBox(height: 5),
            Text(review['text'] ?? ''),
            SizedBox(height: 5),
            Text(
              'by ${review['userEmail'] ?? 'Anonymous'}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }).toList();
  }
}