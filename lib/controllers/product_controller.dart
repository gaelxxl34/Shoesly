import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/models/product_model.dart';

class ProductControllerStore {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').doc(product.id).set(product.toMap());
  }

  Future<void> addReview(String productId, String reviewText, double rating, String userEmail) async {
    final productRef = _firestore.collection('products').doc(productId);

    final productSnapshot = await productRef.get();

    if (productSnapshot.exists) {
      final data = productSnapshot.data() as Map<String, dynamic>;
      final numberOfReviews = data['numberOfReviews'];
      List<dynamic> reviews = [];

      if (numberOfReviews is Map<String, dynamic>) {
        reviews = numberOfReviews['reviews'] as List<dynamic>;
      } else {
        // Initialize the numberOfReviews field as a map if it's not already one
        await productRef.update({
          'numberOfReviews': {
            'reviews': [],
          },
        });
      }

      // Add the new review to the reviews array
      reviews.add({
        'text': reviewText,
        'rating': rating,
        'userEmail': userEmail,
      });

      // Calculate the new average rating
      double totalRating = reviews.fold(0, (sum, item) => sum + item['rating']);
      double averageRating = totalRating / reviews.length;

      // Update the product document with the new review and average rating
      await productRef.update({
        'numberOfReviews.reviews': reviews,
        'averageRating': averageRating,
      });
    }
  }
}

class ProductController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;

  List<String> availableBrands = ['NIKE', 'Puma', 'Adidas', 'Reebok'];
  Set<String> selectedBrands = {};
  Set<Color> selectedColors = {};
  RangeValues priceRange = RangeValues(0, 500);
  String sortOption = 'Most Recent';
  List<String> sortOptions = ['Most Recent', 'Lowest Price', 'Highest Reviews', 'Gender'];

  List<ProductModel> get products => _filteredProducts;
  bool get isLoading => _isLoading;

  ProductController() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore.collection('products').get();
      _products = snapshot.docs.map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      _filteredProducts = List.from(_products);
      applyFiltersAndSorting();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addBrandFilter(String brand) {
    selectedBrands.add(brand.toLowerCase());
    notifyListeners();
    applyFiltersAndSorting();
  }

  void removeBrandFilter(String brand) {
    selectedBrands.remove(brand.toLowerCase());
    notifyListeners();
    applyFiltersAndSorting();
  }

  void toggleColorFilter(Color color) {
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
    } else {
      selectedColors.add(color);
    }
    notifyListeners();
    applyFiltersAndSorting();
  }

  void setPriceRange(RangeValues range) {
    priceRange = range;
    notifyListeners();
    applyFiltersAndSorting();
  }

  void setSortOption(String option) {
    sortOption = option;
    notifyListeners();
    applyFiltersAndSorting();
  }

  void applyFiltersAndSorting() {
    _filteredProducts = List.from(_products);

    // Apply brand filter
    if (selectedBrands.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        return selectedBrands.any((brand) => product.name.toLowerCase().contains(brand));
      }).toList();
    }

    // Apply price range filter
    _filteredProducts = _filteredProducts.where((product) {
      return product.price >= priceRange.start && product.price <= priceRange.end;
    }).toList();

    // Apply color filter
    if (selectedColors.isNotEmpty) {
      _filteredProducts = _filteredProducts.where((product) {
        return (selectedColors.contains(Colors.black) && product.imageUrl.isNotEmpty) ||
            (selectedColors.contains(Colors.blue) && product.imageUrl1.isNotEmpty) ||
            (selectedColors.contains(Colors.red) && product.imageUrl2.isNotEmpty);
      }).toList();
    }

    // Apply sorting
    if (sortOption == 'Lowest Price') {
      _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Highest Reviews') {
      _filteredProducts.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    } else if (sortOption == 'Most Recent') {
      _filteredProducts.sort((a, b) => b.addedTime.compareTo(a.addedTime)); // Assuming you have an addedTime field
    }

    notifyListeners();
  }
}



