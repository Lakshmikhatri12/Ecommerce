import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets.dart' as wd;
import 'package:myapp/items.dart' as it;

class ProductDetail extends StatefulWidget {
  final int product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _currentSlide = 0;
  void addToCart(Map<dynamic, dynamic> products) {
    it.Cart.add(products);
  }

  @override
  Widget build(BuildContext context) {
    final product = it.productDetail[widget.product];
    final List<String> _image = [
      it.productDetail[widget.product]["image"],
      it.productDetail[widget.product]["image2"],
      it.productDetail[widget.product]['image3']
    ];
    return Scaffold(
      bottomNavigationBar: wd.customBottomNavigation(context),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 139, 107, 0.91),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CarouselSlider(
                items: _image.map((image) {
                  return Builder(builder: (context) {
                    return Image.network(
                      image,
                      fit: BoxFit.cover,
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                    height: 280,
                    enlargeCenterPage: true,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentSlide = index;
                      });
                    })),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "Rs${product["price"].toString()}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  textAlign: TextAlign.start,
                  "Product Description",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  product["description"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
              ),
            ]),
            SizedBox(
              height: 50,
            ),
            Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF65CAF5),
                  ),
                  onPressed: () {
                    addToCart(product);
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
