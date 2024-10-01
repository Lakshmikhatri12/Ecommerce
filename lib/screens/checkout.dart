import 'package:flutter/material.dart';
import 'package:myapp/screens/confirmorder.dart';
import 'package:myapp/widgets.dart' as wd;

class CheckoutScreen extends StatefulWidget {
  final List<dynamic> cartItems;
  final List<int> quantities;

  const CheckoutScreen({
    Key? key,
    required this.cartItems,
    required this.quantities,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int deliveryCharges = 200;
  String? selectedPaymentMethod; // To track the selected payment method

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      double price =
          double.tryParse(widget.cartItems[i]['price'].toString()) ?? 0.0;
      totalPrice += price * widget.quantities[i];
    }
    return totalPrice + deliveryCharges;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wd.customAppbar(
        context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  widget.cartItems[index]['image'],
                                  height: 100,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.cartItems[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "RS ${widget.cartItems[index]['price']}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Qty: ${widget.quantities[index]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  // Shipping Address Section
                  Text(
                    "Shipping Address",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Shipping Address",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Payment Method Section
                  Text(
                    "Payment Method",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // Radio Buttons for Payment Method
                  RadioListTile<String>(
                    title: Text("Credit Card"),
                    value: "Credit Card",
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Debit Card"),
                    value: "Debit Card",
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Cash On Delivery"),
                    value: "Cash On Delivery",
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),

                  SizedBox(height: 20),

                  // Total Price & Summary
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Charges",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs $deliveryCharges",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs ${calculateTotalPrice().toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Place Order Button
                  ElevatedButton(
                    onPressed: selectedPaymentMethod == null
                        ? null // Disable button if no payment method is selected
                        : () {
                            // Handle order placement
                            print("Order placed with $selectedPaymentMethod");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderConfirmedScreen()));
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color.fromRGBO(101, 202, 245, 1),
                    ),
                    child: Text(
                      'Place Order',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
