import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  final TextEditingController _email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An email for password reset has been sent"),
          backgroundColor: Color.fromRGBO(101, 202, 245, 1),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Reset Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Enter your email so we can send reset password option to it",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color.fromARGB(154, 29, 28, 28),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Enter your email",
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(101, 202, 245, 1),
              ),
              onPressed: () {
                final email = _email.text;
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter an email address"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  sendPasswordResetLink(email);
                }
              },
              child: Text(
                "Send verification email",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
