import 'package:flutter/material.dart';
import 'package:myapp/categories/watch.dart';
import 'package:myapp/screens/checkout.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          storageBucket: "ecommerce-app-321ec.appspot.com",
          apiKey: "AIzaSyDKNYwgasAydBemXY_AwK6-Up0qlAZDf1Q",
          appId: "1:995957835713:android:1460f41542eee9a44e9140",
          messagingSenderId: "995957835713",
          projectId: "ecommerce-app-321ec"));
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
