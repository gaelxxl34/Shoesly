import 'package:flutter/material.dart';

import '../controllers/order_ccontroller.dart';

class CheckoutPage extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> cartItems;

  CheckoutPage({
    required this.totalAmount,
    required this.cartItems,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final OrderControllerStore _orderController = OrderControllerStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,

        title: Text('Place your order', style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            SizedBox(height: 16.0),
            _buildTextField(context, 'Enter promo code here', 'APPLY'),
            SizedBox(height: 16.0),
            _buildSectionTitle('PAYMENT METHOD', 'CHANGE'),
            _buildPaymentMethod(),
            SizedBox(height: 16.0),
            _buildSectionTitle('ADDRESS', 'CHANGE YOUR ADDRESS'),
            _buildAddress(),
            SizedBox(height: 16.0),
            _buildSectionTitle('DELIVERY', 'CHANGE'),
            _buildDeliveryDetails(),
            SizedBox(height: 16.0),
            _buildOrderDetails(),
            SizedBox(height: 16.0),
            _buildConfirmOrderButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CART SUMMARY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8.0),
        _buildSummaryRow('Item\'s total (${widget.cartItems.length})', 'UGX ${widget.totalAmount.toStringAsFixed(2)}'),
        _buildSummaryRow('Delivery fees', 'USD 5,9'), // Example static value
        Divider(),
        _buildSummaryRow('Total', 'USD ${(widget.totalAmount + 5).toStringAsFixed(2)}', isBold: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String hintText, String buttonText) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: () {
            // Handle apply action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          ),
          child: Text(buttonText, style: TextStyle(color: Colors.green),),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle change action
          },
          child: Text(
            actionText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.payment, color: Colors.red),
      title: Text('Pay on Delivery (Pay with Bank cards, MTN or Airtel)'),
    );
  }

  Widget _buildAddress() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.location_on, color: Colors.red),
      title: Text('Gael Bindu'),
      subtitle: Text('Lukuli road close to strom restaurant'),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.local_shipping, color: Colors.red),
          title: Text('Door Delivery'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery scheduled on 15 Jun'),
              SizedBox(height: 8.0),
              Text(
                'Save up to 13\$',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Handle change delivery method action
                },
                child: Text(
                  'Switch to a pickup station starting from 4.5\$',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipment 1',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final item = widget.cartItems[index];
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
          },
        ),
      ],
    );
  }

  Widget _buildConfirmOrderButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            await _orderController.createOrder(
              totalAmount: widget.totalAmount,
              cartItems: widget.cartItems,
              address: 'Lukuli road close to strom restaurant',
              paymentMethod: 'Pay on Delivery',
            );
            Navigator.pushNamed(context, '/main');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Order Confirmed', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10),
                    Icon(Icons.done_all, color: Colors.white),
                  ],
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Order Failed', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10),
                    Icon(Icons.error, color: Colors.white),
                  ],
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'CONFIRM ORDER',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}


