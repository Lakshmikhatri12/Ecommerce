import 'package:flutter/material.dart';
import 'package:myapp/screens/checkout.dart';
import 'package:myapp/widgets.dart' as wd;
import 'package:myapp/items.dart' as it;

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<int> quantities = [];

  @override
  void initState() {
    super.initState();
    // Initialize quantities list to 1 for each item in the cart
    quantities = List<int>.generate(it.Cart.length, (index) => 1);
  }

  int deliveryCharges = 200;
  void incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrementQuantity(int index) {
    if (quantities[index] > 1) {
      setState(() {
        quantities[index]--;
      });
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < it.Cart.length; i++) {
      // Convert price to double
      double price = double.tryParse(it.Cart[i]['price'].toString()) ?? 0.0;
      totalPrice += price * quantities[i] + deliveryCharges;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wd.customAppbar(context),
        bottomNavigationBar: wd.customBottomNavigation(context),
        body: Container(
          child: it.Cart.isEmpty
              ? Column(
                  children: [
                    Image.asset(
                      height: MediaQuery.of(context).size.height * 0.7,
                      "assets/cart.jpg",
                      fit: BoxFit.cover,
                    ),
                    Center(
                        child: Text(
                      "Your cart is empty",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ))
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: it.Cart.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: Container(
                                  child: Row(
                                    children: [
                                      Image.network(
                                        it.Cart[index]['image'],
                                        fit: BoxFit.fill,
                                        height: 100,
                                        width: 60,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.left,
                                                  it.Cart[index]["name"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    textAlign: TextAlign.left,
                                                    "RS ${it.Cart[index]["price"].toString()}"),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  decrementQuantity(index);
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                )),
                                            Text(
                                              quantities[index].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  incrementQuantity(index);
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 15,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  it.Cart.removeAt(index);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Color.fromRGBO(
                                                      2, 139, 107, 0.91),
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                              "\Rs $deliveryCharges",
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
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(101, 202, 245, 1)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                  cartItems: it.Cart,
                                  quantities: quantities,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Proceed To Checkout",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}
