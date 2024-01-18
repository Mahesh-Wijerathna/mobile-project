import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart'; //
//dev.log
import 'dart:developer' as dev;

class ShopRegisterPage extends StatefulWidget {
  const ShopRegisterPage({Key? key}) : super(key: key);

  @override
  State<ShopRegisterPage> createState() => _ShopRegisterPageState();
}

class _ShopRegisterPageState extends State<ShopRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  final int _photoCount = 0;
  final LatLng? _selectedLocation = null;

  /*

  void registerUser() async {
    dev.log("email > " + _emailController.text.toString());
    dev.log("password > " + _passwordController.text.toString());

    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _categoriesController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _businessTypeController.text.isNotEmpty &&
        _openingTimeController.text.isNotEmpty &&
        _closingTimeController.text.isNotEmpty) {
      var regBody = {
        "email": _emailController.text,
        "password": _passwordController.text
      };

      var shopBody = {
        "ownerName": _nameController.text,
        "shopName": _locationController.text,
        "address": _categoriesController.text,
        "phoneNumber": _descriptionController.text,
        "longitude": _businessTypeController.text,
        "latitude": _openingTimeController.text,
      };

      dev.log(Uri.parse(registration).toString());
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var shopResponse = await http.post(Uri.parse(addShop),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(shopBody));

      dev.log("request for registration sent successfully");

      var jsonResponse = jsonDecode(response.body);
      var jsonShopResponse = jsonDecode(shopResponse.body);
      dev.log("response body > " + jsonResponse.toString());

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      } else {
        print("Something Went Wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }*/
  void registerShop() async {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _categoriesController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _businessTypeController.text.isNotEmpty &&
        _openingTimeController.text.isNotEmpty &&
        _closingTimeController.text.isNotEmpty) {
      // Create a shop account
    }
    var regbody = {
      "ownerName": _nameController.text,
      "shopName": _locationController.text,
      "address": _categoriesController.text,
      "phoneNumber": _descriptionController.text,
      "longitude": _businessTypeController.text,
      "latitude": _openingTimeController.text,
    };
  }

  void _showMapPicker() {
    // Implement your logic for showing the map picker here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up as Shop'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign Up as Shop',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          suffixIcon: Icon(Icons.place, color: Colors.red),
                        ),
                        onTap: () {
                          // Show map picker
                          _showMapPicker();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Show map picker
                        _showMapPicker();
                      },
                      icon: const Icon(Icons.place, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _categoriesController,
                  decoration: const InputDecoration(
                    labelText: 'Categories',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter categories';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _businessTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Business Type',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter business type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _openingTimeController,
                        decoration: const InputDecoration(
                          labelText: 'Opening Time',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter opening time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _closingTimeController,
                        decoration: const InputDecoration(
                          labelText: 'Closing Time',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter closing time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration logic here
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text('Already have an account? Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/customer_signup');
                      },
                      child: const Text('Sign up as a customer'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
