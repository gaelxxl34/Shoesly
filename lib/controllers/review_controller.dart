import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _productReviews = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get productReviews => _productReviews;
  bool get isLoading => _isLoading;

  ReviewController() {
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      List<Map<String, dynamic>> allProductReviews = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String productImageUrl = data['imageUrl'] ?? '';
        String productName = data['name'] ?? 'Product Name';
        List<dynamic> reviews = [];

        if (data.containsKey('numberOfReviews') && data['numberOfReviews'] is Map<String, dynamic>) {
          reviews = data['numberOfReviews']['reviews'] ?? [];
        }

        allProductReviews.add({
          'imageUrl': productImageUrl,
          'name': productName,
          'reviews': reviews,
        });
      }

      _productReviews = allProductReviews;
      _productReviews.forEach((product) {
        product['reviews'].sort((a, b) => b['rating'].compareTo(a['rating']));
      });
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterReviewsByStars(int stars) {
    _productReviews = _productReviews.map((product) {
      return {
        'imageUrl': product['imageUrl'],
        'name': product['name'],
        'reviews': (product['reviews'] as List<dynamic>)
            .where((review) => review['rating'] == stars)
            .toList(),
      };
    }).toList();
    notifyListeners();
  }

  void clearFilter() {
    fetchReviews();
  }
}