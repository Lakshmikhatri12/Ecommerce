import 'package:flutter/material.dart';
import 'package:myapp/categories/bags.dart';
import 'package:myapp/categories/jeans.dart';
import 'package:myapp/categories/makeup.dart';
import 'package:myapp/categories/shirts.dart';
import 'package:myapp/categories/shoes.dart';
import 'package:myapp/categories/sunglasses.dart';
import 'package:myapp/categories/top.dart';
import 'package:myapp/categories/watch.dart';
import 'package:myapp/widgets.dart' as wd;

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List Category = [
    {"title": "Watch", "image": "assets/A1.jpg"},
    {"title": "Sunglases", "image": "assets/A2.jpg"},
    {"title": "Top", "image": "assets/A5.jpg"},
    {"title": "Shirts", "image": "assets/A4.jpg"},
    {"title": "Shoes", "image": "assets/A3.jpg"},
    {"title": "Jeans", "image": "assets/A7.jpg"},
    {"title": "Bags", "image": "assets/A6.jpg"},
    {"title": "MakeUp", "image": "assets/A8.jpg"},
  ];
  List Pages = [
    Watch(),
    Sunglasses(),
    Top(),
    Shirts(),
    Shoes(),
    Jeans(),
    Bags(),
    Makeup()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wd.customAppbar(context),
      bottomNavigationBar: wd.customBottomNavigation(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: Category.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pages[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      height: 340,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            opacity: 0.7,
                            fit: BoxFit.fill,
                            image: AssetImage(Category[index]["image"])),
                      ),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          Category[index]["title"],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
