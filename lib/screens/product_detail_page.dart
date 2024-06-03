// product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:priority_soft_test_project/screens/cart_page.dart';
import 'package:priority_soft_test_project/screens/view_product_page.dart';
import 'package:provider/provider.dart';

import '../common/widgets/ReviewDialog.dart';
import '../controllers/cart_controller.dart';
import '../data/models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSizeIndex = -1;
  int selectedColorIndex = 0;
  final CartControllerStore _cartController = CartControllerStore();

  final List<String> sizes = ['39', '39.5', '40', '40.5', '41'];
  final List<Color> colors = [Colors.blue, Colors.black, Colors.red];

  late List<List<String>> colorImageUrls;

  @override
  void initState() {
    super.initState();
    colorImageUrls = [
      [widget.product.imageUrl], // Black color images
      [widget.product.imageUrl1], // Blue color images
      [widget.product.imageUrl2], // Blue Grey color images
    ];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProductImage(),
              SizedBox(height: 16),
              buildProductName(),
              buildRatingAndAddReview(),
              SizedBox(height: 16),
              buildSizeSelection(),
              SizedBox(height: 16),
              buildDescription(),
              SizedBox(height: 16),
              buildProductRatingAndReview(),
              SizedBox(height: 16),
              buildPriceAndAddToCart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  colorImageUrls[selectedColorIndex][0] ??
                      'assets/placeholder.png',
                  // Display the first image of the selected color
                  height: 250,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildColorDots(),
                buildColorSelection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductName() {
    return Text(
      widget.product.name,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildRatingAndAddReview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                '${widget.product.averageRating.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 5),
              ...buildStarRating(widget.product.averageRating),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  '(${widget.product.reviewCount} Reviews)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ReviewDialog(productId: widget.product.id),
            );
          },
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.green),
              Text('Add Review', style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: sizes.map((size) {
            int index = sizes.indexOf(size);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSizeIndex = index;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedSizeIndex == index ? Colors.black : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                ),
                alignment: Alignment.center,
                child: Text(
                  size,
                  style: TextStyle(
                    color: selectedSizeIndex == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.product.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildProductRatingAndReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Rating and Review',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        if (widget.product.numberOfReviews['reviews'].isEmpty)
          Text(
            'No reviews yet. Be the first to add a review!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          )
        else
          ...buildTopReviews(widget.product),
      ],
    );
  }

  Widget buildPriceAndAddToCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedSizeIndex == -1) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Text('Please select a size.', style: TextStyle(color: Colors.red),),
                ),
              );
              return;
            }

            final selectedSize = sizes[selectedSizeIndex];
            _cartController.addToCart(
              imageUrl: colorImageUrls[selectedColorIndex][0],
              name: widget.product.name,
              description: widget.product.description,
              size: selectedSize,
              price: widget.product.price,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Added to cart', style: TextStyle(color: Colors.white),),
                    SizedBox(width: 10,),
                    Icon(Icons.done_all)
                  ],
                ),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
          ),
          child: Text(
            'ADD TO CART',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildColorDots() {
    return Row(
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedColorIndex == index ? Colors.black : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget buildColorSelection() {
    return Row(
      children: List.generate(colors.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColorIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors[index],
              border: Border.all(
                color: selectedColorIndex == index ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
            width: 24,
            height: 24,
            child: selectedColorIndex == index
                ? Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            )
                : null,
          ),
        );
      }),
    );
  }

  List<Widget> buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    int halfStars = ((rating - fullStars) * 2).round();

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber, size: 16));
    }
    if (halfStars == 1) {
      stars.add(Icon(Icons.star_half, color: Colors.amber, size: 16));
    }
    for (int i = fullStars + halfStars; i < 5; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.amber, size: 16));
    }
    return stars;
  }

  List<Widget> buildTopReviews(ProductModel product) {
    final reviews = product.numberOfReviews['reviews'] as List<dynamic>;
    final topReviews = reviews.take(3).toList();

    return topReviews.map((review) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review['userEmail'] ?? 'anonymous',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                ...buildStarRating(review['rating']),
                SizedBox(width: 5),
                Text(
                  '${review['rating'].toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(
              review['text'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
