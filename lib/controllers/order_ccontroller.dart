import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderControllerStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOrder({
    required double totalAmount,
    required List<Map<String, dynamic>> cartItems,
    required String address,
    required String paymentMethod,
  }) async {
    try {
      // Create order document
      await _firestore.collection('orders').add({
        'totalAmount': totalAmount,
        'cartItems': cartItems,
        'address': address,
        'paymentMethod': paymentMethod,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Delete items from cart
      WriteBatch batch = _firestore.batch();
      for (var item in cartItems) {
        batch.delete(_firestore.collection('cart').doc(item['id']));
      }
      await batch.commit();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class OrderController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get orders => _orders;
  bool get isLoading => _isLoading;

  OrderController() {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore.collection('orders').get();
      _orders = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshOrders() async {
    await fetchOrders();
  }
}