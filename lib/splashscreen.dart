import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:myapp/signin.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return Signin();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(101, 202, 245, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: _animationController, curve: Curves.easeOut)),
                child: Image.asset(
                  "assets/sp.png",
                  width: 180,
                  height: 180,
                ),
              ),
            ),
            ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeOut)),
              child: Text(
                "Shopaholic",
                style: TextStyle(
                    fontFamily: GoogleFonts.cedarvilleCursive().fontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
