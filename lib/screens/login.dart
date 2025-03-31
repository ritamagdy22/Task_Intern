import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rita_firebase/screens/Products.dart';

import '../firebase_details/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //created object from class Authservices to be able to access function SignInByGoogle
  final _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Gmail SignIn by firebase"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black26,
              ),
              onPressed: () {
                _auth.SignInByGoogle();
              },
              child: Text('Gmail Sign In '),
            ),
            const SizedBox(height: 20, width: 30,),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black26,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductScreen()),
                );
              },
              child: const Text('Product screen'),
            ),
          ],
        ),
      ),
    );
  }
}
