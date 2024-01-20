import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart'; //
//dev.log
import 'dart:developer' as dev;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'applogo.dart';
// import 'loginPage.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

import 'dart:developer' as dev;

class ShopRegisterPage extends StatefulWidget {
  @override
  State<ShopRegisterPage> createState() => _ShopRegisterPageState();
}

class _ShopRegisterPageState extends State<ShopRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final int _photoCount = 0;
  LatLng? selectedLocation = null;

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
        _ownerNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _categoriesController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _businessTypeController.text.isNotEmpty &&
        _openingTimeController.text.isNotEmpty &&
        _closingTimeController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Create a shop account
    }
    var regbody = {
      "email": _usernameController.text,
      "password": _passwordController.text,
      "userType": "shop"
    };
    var shopBody = {
      "ownerName": _ownerNameController.text,
      "shopName": _nameController.text,
      "email": _emailController.text,
      "location": _locationController.text,
      "categories": _categoriesController.text,
      "description": _descriptionController.text,
      "businessType": _businessTypeController.text,
      "openingTime": _openingTimeController.text,
      "closingTime": _closingTimeController.text,
      "username": _usernameController.text,
      
    };
    dev.log(Uri.parse(registration).toString());
    var response = await http.post(Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regbody));
    var shopResponse = await http.post(Uri.parse(addShop),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(shopBody));


    dev.log("regbody > " + regbody.toString());
    dev.log("shopbody > " + shopBody.toString());
    dev.log("request for registration sent successfully");

    var jsonResponse = jsonDecode(response.body);
    var jsonShopResponse = jsonDecode(shopResponse.body);
    dev.log("response body > " + jsonResponse.toString());
    dev.log("response body > " + jsonShopResponse.toString());
    dev.log(jsonResponse['status'].toString() + " " + jsonShopResponse['status'].toString());  

    if (jsonResponse['status'] && jsonShopResponse['status']) {
      Navigator.pushNamed(context, 'shop_dashboard');

    } else {
      dev.log("Something Went Wrong");
    }

  }



  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
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
                        //readOnly: true,
                        
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          suffixIcon: Icon(Icons.place, color: Colors.red),
                          
                        ),
                        onTap: () {
                          void _showMapPicker() {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                LatLng?
                                    selectedLocation; // Variable to store the selected location coordinates

                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      height: 400,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: GoogleMap(
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                    37.42796133580664,
                                                    -122.085749655962),
                                                zoom: 15,
                                              ),
                                              onTap: (LatLng? location) {
                                                Set<Marker> markers = {}; // Define the markers variable
                                                markers.clear(); // Clear the markers
                                                if (location !=
                                                    null) {
                                                  // If a location was previously selected, add a marker at that location
                                                  markers.add(
                                                    Marker(
                                                      markerId: MarkerId(
                                                          'selectedLocation'),
                                                      position: LatLng(location.latitude,location.longitude),
                                                    ),
                                                  );
                                                }
                                                
                                                setState(() {
                                                  selectedLocation = location;
                                                });

                                                // Add the following code to show a marker at the selected location
                                                

                                                // Rest of the code...
                                                setState(() {
                                                  selectedLocation = location;
                                                });
                                              },
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              
                                              IconButton(
                                                onPressed: () {
                                                  if (selectedLocation !=
                                                      null) {
                                                    // Save button
                                                    // Implement your logic here
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                icon: Icon(Icons.save),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  // Cancel button
                                                  // Implement your logic here
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.cancel),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }

                          //_showMapPicker();
                          selectedLocation = LatLng(5.42796133580664, 80.085749655962);
                          
                          dev.log("location clicked" + selectedLocation.toString() );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Shop Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                // ownername
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ownerNameController,
                  decoration: const InputDecoration(
                    labelText: 'Owner Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter owner name';
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
                // username and password
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration logic
                      registerShop();
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
                      child: const Text(' Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/customer_signup');
                      },
                      child: const Text('customer signup'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
    ;
  }
}
