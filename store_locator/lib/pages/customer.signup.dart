import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:developer' as dev;

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   TextEditingController _nameController = TextEditingController();
   TextEditingController _addressController = TextEditingController();
   TextEditingController _phoneNumberController = TextEditingController();
   TextEditingController _usernameController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      if (_nameController.text.isNotEmpty &&
          _addressController.text.isNotEmpty &&
          _phoneNumberController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        var regBody = {
          "email": _usernameController.text,
          "password": _passwordController.text,
          "userType": "customer"
        };

        var customerBody = {
          "name": _nameController.text,
          "address": _addressController.text,
          "phoneNumber": _phoneNumberController.text,
          "username": _usernameController.text,
        };

        var response = await http.post(Uri.parse(registration),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        var customerResponse = await http.post(Uri.parse(addCustomer),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(customerBody));

        var jsonresponse = jsonDecode(response.body);
        dev.log(jsonresponse.toString());
        var customerJsonResponse = jsonDecode(customerResponse.body);
        dev.log(customerJsonResponse.toString());

        if (jsonresponse['status'] == true &&
            customerJsonResponse['status'] == true) {
          dev.log("User Registered");
          Navigator.pushNamed(context, '/customer_dashboard');
        } else {
          dev.log("User Registration Failed");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle registration logic here
                    // Use the values from the controllers to create a customer account
                    registerUser();

                    // Perform registration API call or database operation
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/'); // Replace with your login page route
            },
            child: const Text('Already have an account? Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context,
                  '/shop_signup'); // Replace with your shop signup page route
            },
            child: const Text('Sign up as a shop'),
          ),
        ],
      ),
    );
  }
}
