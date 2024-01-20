import 'dart:convert';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:store_locator/main.dart';

import 'dart:developer' as dev;
// ignore: depend_on_referenced_packages

//import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": usernameController.text,
        "password": passwordController.text
      };
      dev.log("\nrequest body >" + reqBody.toString());

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      dev.log("\nresponse body > \n" + response.body.toString());

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        var userType = jsonResponse['userType'];
        prefs.setString('token', myToken);
        if (userType == 'shop')
          Navigator.pushNamed(context, '/shop_dashboard',
              arguments: '65a9d9388ed17b6d45c3bb48');

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => Dashboard(token: myToken)));
        if (userType == 'customer')
          Navigator.pushNamed(context, '/customer_dashboard');
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => CDashboard(token: myToken)
        //     // Dashboard(token: myToken)
        //     ));
      } else {
        dev.log('Something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Handle login logic using a backend call to MongoDB
                // You'll need to implement this part based on your backend setup
                // It might involve making an HTTP request to an API endpoint
                // and handling the response accordingly
                loginUser();
                dev.log("login button pressed");
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to the platform?'),
                TextButton(
                  onPressed: () {
                    // Navigate to the register page
                    Navigator.pushNamed(context, '/customer_signup');
                  },
                  child: const Text('Sign up as a customer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
