class ProductModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final Map<String, dynamic> numberOfReviews;
  final double averageRating;
  final String brand;
  final DateTime addedTime;
  final String imageUrl1;
  final String imageUrl2;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.brand,
    required this.addedTime,
    required this.imageUrl1,
    required this.imageUrl2,
    this.numberOfReviews = const {'reviews': []},
    this.averageRating = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'numberOfReviews': numberOfReviews,
      'averageRating': averageRating,
      'brand': brand,
      'addedTime': addedTime.toIso8601String(),
      'imageUrl1': imageUrl1,
      'imageUrl2': imageUrl2,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? 'No description available.',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      numberOfReviews: map.containsKey('numberOfReviews') && map['numberOfReviews'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(map['numberOfReviews'])
          : {'reviews': []},
      averageRating: (map['averageRating'] ?? 0.0).toDouble(),
      brand: map['brand'] ?? '',
      addedTime: DateTime.parse(map['addedTime'] ?? DateTime.now().toIso8601String()),
      imageUrl1: map['imageUrl1'] ?? '',
      imageUrl2: map['imageUrl2'] ?? '',
    );
  }

  int get reviewCount {
    final reviews = numberOfReviews['reviews'] as List<dynamic>;
    return reviews.length;
  }
}

