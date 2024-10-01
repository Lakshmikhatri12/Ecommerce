import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/items.dart' as it;
import 'package:myapp/screens/product_detail.dart';
import 'package:myapp/widgets.dart' as wd;

class Makeup extends StatefulWidget {
  const Makeup({super.key});

  @override
  State<Makeup> createState() => _MakeupState();
}

class _MakeupState extends State<Makeup> {
  void addToCart(Map<dynamic, dynamic> products) {
    it.Cart.add(products);
  }

  void navigateToProductDetail(product) {
    it.productDetail.add(product);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetail(
                  product: 0,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wd.customAppbar(context),
      bottomNavigationBar: wd.customBottomNavigation(context),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Makeup").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error fetching data"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No products available"));
            } else {
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_off_rounded,
                          color: Colors.grey,
                        ),
                        suffixIcon: Icon(Icons.filter_list),
                        hintText: "Search Products",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            width: 4,
                            color: Color.fromRGBO(101, 202, 245, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        itemCount: documents.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          var productdata =
                              documents[index].data() as Map<dynamic, dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateToProductDetail(productdata);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                product: 0,
                                              )));
                                },
                                child: Container(
                                  height: 280,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(productdata['image'])),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productdata['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        "Rs ${productdata['price'].toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(101, 202, 245, 1),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        addToCart(productdata);
                                      },
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
