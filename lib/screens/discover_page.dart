import 'package:flutter/material.dart';
import 'package:priority_soft_test_project/screens/product_detail_page.dart';
import 'package:provider/provider.dart';
import '../common/widgets/BrandIcon.dart';
import '../common/widgets/ProductCardWidget.dart';
import '../controllers/product_controller.dart';
import '../util/constraints/text.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void _showFilterDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          final productController = Provider.of<ProductController>(context, listen: false);

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text('Filter and Sort Options'),
                content: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Filter by brand
                        Text('Filter by Brand', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...productController.availableBrands.map((brand) {
                          return CheckboxListTile(
                            title: Text(brand),
                            value: productController.selectedBrands.contains(brand.toLowerCase()),
                            onChanged: (bool? value) {
                              if (value == true) {
                                setState(() => productController.addBrandFilter(brand));
                              } else {
                                setState(() => productController.removeBrandFilter(brand));
                              }
                            },
                          );
                        }).toList(),
                        Divider(),
                        // Filter by price range
                        Text('Filter by Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
                        RangeSlider(
                          values: productController.priceRange,
                          min: 0,
                          max: 500,
                          divisions: 10,
                          labels: RangeLabels(
                            '\$${productController.priceRange.start.round().toString()}',
                            '\$${productController.priceRange.end.round().toString()}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() => productController.setPriceRange(values));
                          },
                        ),
                        Divider(),
                        // Filter by color
                        Text('Filter by Color', style: TextStyle(fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: 10,
                          children: [
                            FilterChip(
                              label: Text('Black'),
                              selected: productController.selectedColors.contains(Colors.black),
                              onSelected: (bool selected) {
                                setState(() {
                                  productController.toggleColorFilter(Colors.black);
                                });
                              },
                              backgroundColor: Colors.black,
                              labelStyle: TextStyle(color: Colors.white),
                              selectedColor: Colors.black,
                              checkmarkColor: Colors.white,
                            ),
                            FilterChip(
                              label: Text('Blue'),
                              selected: productController.selectedColors.contains(Colors.blue),
                              onSelected: (bool selected) {
                                setState(() {
                                  productController.toggleColorFilter(Colors.blue);
                                });
                              },
                              backgroundColor: Colors.blue,
                              labelStyle: TextStyle(color: Colors.white),
                              selectedColor: Colors.blue,
                              checkmarkColor: Colors.white,
                            ),
                            FilterChip(
                              label: Text('Red'),
                              selected: productController.selectedColors.contains(Colors.red),
                              onSelected: (bool selected) {
                                setState(() {
                                  productController.toggleColorFilter(Colors.red);
                                });
                              },
                              backgroundColor: Colors.red,
                              labelStyle: TextStyle(color: Colors.white),
                              selectedColor: Colors.red,
                              checkmarkColor: Colors.white,
                            ),
                          ],
                        ),
                        Divider(),
                        // Sort options
                        Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
                        DropdownButton<String>(
                          value: productController.sortOption,
                          items: productController.sortOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => productController.setSortOption(newValue));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Apply', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      productController.applyFiltersAndSorting();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          if (productController.isLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blueAccent));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeaturedProduct(screenHeight, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildSectionTitle(context, AppText.brands, AppText.seeAll),
                  SizedBox(height: screenHeight * 0.02),
                  _buildBrandIcons(),
                  SizedBox(height: screenHeight * 0.02),
                  _buildSectionTitle(context, AppText.specialForYou, AppText.seeAll),
                  SizedBox(height: screenHeight * 0.02),
                  _buildProductGrid(screenHeight, screenWidth, productController, context),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _showFilterDialog,
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.search, color: Colors.black),
        onPressed: () {
          // Handle search action
        },
      ),
      title: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: AppText.searchHint,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {
            // Handle cart action
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedProduct(double screenHeight, double screenWidth) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'), // Replace with your image asset
          fit: BoxFit.cover, // Adjust the fit as needed
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01, // Horizontal padding
                  vertical: screenWidth * 0.005, // Vertical padding
                ),
              ),
              child: Text(
                AppText.newProduct,
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // Space between elements
            Text(
              AppText.productName,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppText.productPrice,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // Space between elements
            Row(
              children: [
                Container(
                  height: screenHeight * 0.005,
                  width: screenWidth * 0.1,
                  color: Colors.white,
                ),
                SizedBox(width: screenWidth * 0.02), // Space between bars
                Container(
                  height: screenHeight * 0.005,
                  width: screenWidth * 0.02,
                  color: Colors.white,
                ),
                SizedBox(width: screenWidth * 0.02), // Space between bars
                Container(
                  height: screenHeight * 0.005,
                  width: screenWidth * 0.01,
                  color: Colors.grey,
                ),
                SizedBox(width: screenWidth * 0.02), // Space between bars
                Container(
                  height: screenHeight * 0.005,
                  width: screenWidth * 0.01,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String actionText) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          actionText,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandIcons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BrandIcon(name: 'NIKE', image: 'assets/nike.png'),
          BrandIcon(name: 'Puma', image: 'assets/puma.png'),
          BrandIcon(name: 'Vans', image: 'assets/Vans.png'),
          BrandIcon(name: 'Adidas', image: 'assets/adidas.png'),
          BrandIcon(name: 'Reebok', image: 'assets/reebok.png'),
          BrandIcon(name: 'NIKE', image: 'assets/nike.png'),
          BrandIcon(name: 'Puma', image: 'assets/puma.png'),
        ],
      ),
    );
  }

  Widget _buildProductGrid(double screenHeight, double screenWidth, ProductController productController, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: productController.products.length,
      itemBuilder: (context, index) {
        final product = productController.products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: ProductCardWidget(
            image: product.imageUrl,
            name: product.name,
            price: '\$${product.price.toStringAsFixed(2)}',
            reviews: product.reviewCount,
            rating: product.averageRating,
          ),
        );
      },
    );
  }
}








