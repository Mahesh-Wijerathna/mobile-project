

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:http/http.dart' as http;
import '../config.dart';
import 'dart:developer' as dev;

class AddItemPage extends StatefulWidget {
  final String shopId;

  AddItemPage({required this.shopId});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  
  void addItems() async {

    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      var reqBody = {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "itemType": "still not devoloped to search with type",
        "price": _priceController.text,
        "shopId": widget.shopId,
        "shopName": " back end self handle this"
      };
      dev.log("\nrequest body >" + reqBody.toString()); 
      var response = await http.post(Uri.parse(addItem),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      dev.log("\nresponse body > \n" + response.body.toString());
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        var userType = jsonResponse['userType'];
        //prefs.setString('token', myToken);
        if (userType == 'shop')
          Navigator.pushNamed(context, '/shop_dashboard');
      }
      else
        dev.log("\nresponse body > \n" + response.body.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item ${widget.shopId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the shop dashboard page with shopId
                    addItems();
                    dev.log("addItems");

                    Navigator.pushNamed(context, '/shop_signup', arguments: widget.shopId);
                  },
                  child: Text('Save'),
                ),
                SizedBox(width: 8.0),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Implement cancel functionality
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
