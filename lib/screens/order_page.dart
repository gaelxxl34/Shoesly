import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/order_ccontroller.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<OrderController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Orders', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.red,
            onPressed: () async {
              await AuthController().signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: orderController.refreshOrders,
        child: orderController.isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.blue))
            : orderController.orders.isEmpty
            ? Center(child: Text('No orders available.'))
            : ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return buildOrderItem(order);
          },
        ),
      ),
    );
  }

  Widget buildOrderItem(Map<String, dynamic> order) {
    final cartItems = order['cartItems'] as List<dynamic>;
    final totalAmount = order['totalAmount'] as double;
    final address = order['address'] as String;
    final paymentMethod = order['paymentMethod'] as String;

    return Card(
      color: Colors.white70,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Amount: ${totalAmount.toStringAsFixed(2)} \$'),
            SizedBox(height: 8.0),
            Text('Address: $address'),
            SizedBox(height: 8.0),
            Text('Payment Method: $paymentMethod'),
            Divider(),
            ...cartItems.map((item) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.network(
                  item['imageUrl'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item['name']),
                subtitle: Text('QTY: ${item['numberOfProducts'] ?? 1}'),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
