import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/forgotpass.dart';
import 'package:myapp/screens/createaccount.dart';
import 'package:myapp/screens/home.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // If successful, navigate to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Color.fromRGBO(101, 202, 245, 1),
              content: Text('You don\'t have an account, please sign up.')),
        );
      } else if (e is FirebaseAuthException && e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Color.fromRGBO(101, 202, 245, 1),
              content: Text('Incorrect password. Please try again.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Color.fromRGBO(101, 202, 245, 1),
              content: Text('Don\'t have account signup to create account')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.5,
                image: AssetImage("assets/bg1.jpg"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.message)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Your email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Your Password';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Forgotpass()));
                  },
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                        decorationStyle: TextDecorationStyle.wavy,
                        color: Colors.black),
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(101, 202, 245, 1)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _signin();
                      }
                    },
                    child: Text(
                      "SignIn",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Createaccount()));
                  },
                  child: Text("SignUp",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
