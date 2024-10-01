import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/categories/category.dart';
import 'package:myapp/screens/cart.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/profile.dart';

PreferredSizeWidget customAppbar(BuildContext context) {
  return AppBar(
    toolbarHeight: 35,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(101, 202, 245, 1),
        )),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.shopping_bag,
          color: Color.fromRGBO(101, 202, 245, 1),
        ),
      )
    ],
  );
}

Widget customBottomNavigation(BuildContext context) {
  return CurvedNavigationBar(
    backgroundColor: Color.fromRGBO(101, 202, 245, 1),
    items: <Widget>[
      InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: Icon(Icons.home, size: 30)),
      InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Category()));
          },
          child: Icon(Icons.category_rounded, size: 30)),
      InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
          child: Icon(Icons.person, size: 30)),
      InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyCart()));
          },
          child: Icon(Icons.shopping_bag_outlined, size: 30)),
    ],
    onTap: (index) {
      //Handle button tap
    },
  );
}
