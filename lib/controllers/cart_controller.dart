import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartControllerStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String imageUrl,
    required String name,
    required String description,
    required String size,
    required double price,
  }) async {
    try {
      await _firestore.collection('cart').add({
        'imageUrl': imageUrl,
        'name': name,
        'description': description,
        'size': size,
        'price': price,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> fetchReviews(String productId) async {
    try {
      DocumentSnapshot productDoc = await _firestore.collection('products').doc(productId).get();
      Map<String, dynamic> data = productDoc.data() as Map<String, dynamic>;
      List<dynamic> reviews = data['numberOfReviews']['reviews'] ?? [];

      return reviews.map((review) => review as Map<String, dynamic>).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}


class CartController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  CartController() {
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('cart').get();
      _cartItems = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  double get totalAmount {
    return _cartItems.fold(0, (sum, item) => sum + item['price'] * (item['numberOfProducts'] ?? 1));
  }

  Future<void> incrementProductQuantity(String docId) async {
    try {
      final docRef = _firestore.collection('cart').doc(docId);
      await docRef.update({
        'numberOfProducts': FieldValue.increment(1),
      });
      fetchCartItems();
    } catch (e) {
      print(e);
    }
  }

  Future<void> decrementProductQuantity(String docId, int currentQuantity) async {
    try {
      final docRef = _firestore.collection('cart').doc(docId);
      if (currentQuantity <= 1) {
        await docRef.delete();
      } else {
        await docRef.update({
          'numberOfProducts': FieldValue.increment(-1),
        });
      }
      fetchCartItems();
    } catch (e) {
      print(e);
    }
  }
}