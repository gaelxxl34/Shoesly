import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/product_controller.dart';

class ReviewDialog extends StatelessWidget {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final String productId;
  final ProductControllerStore _productControllerStore = ProductControllerStore();

  ReviewDialog({required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _reviewController,
            decoration: InputDecoration(hintText: 'Write your review...'),
          ),
          TextField(
            controller: _ratingController,
            decoration: InputDecoration(hintText: 'Rate from 1 to 5'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            final reviewText = _reviewController.text;
            final ratingText = _ratingController.text;
            final rating = double.tryParse(ratingText) ?? 0.0;
            final userEmail = user?.email ?? 'anonymous';

            if (reviewText.isNotEmpty && rating > 0 && rating <= 5) {
              await _productControllerStore.addReview(productId, reviewText, rating, userEmail);
              print('Submitted review: $reviewText with rating: $rating by $userEmail');
            }
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Submit', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
