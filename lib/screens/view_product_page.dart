import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/widgets/ProductCardWidget.dart';
import '../controllers/product_controller.dart';

class ViewProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('View Products', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          if (productController.isLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blueAccent,));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
            itemCount: productController.products.length ?? 0,
            itemBuilder: (context, index) {
              final product = productController.products[index];
              return ProductCardWidget(
                image: product.imageUrl ?? '',
                name: product.name ?? '',
                price: '\$${product.price.toStringAsFixed(2)}',
                reviews: product.reviewCount,
                rating: product.averageRating ?? 0.0,
              );
            },
          );
        },
      ),
    );
  }
}