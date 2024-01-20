

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:http/http.dart' as http;
import '../config.dart';

import 'dart:developer' as dev;

class ShopDashboard extends StatefulWidget {
  final String shopId;
  
  ShopDashboard({required this.shopId});

  @override
  _ShopDashboardState createState() => _ShopDashboardState();
}

class _ShopDashboardState extends State<ShopDashboard> {
  List items = [];

  @override
  void initState() {
    super.initState();
    updateItemList();
  }

  void updateItemList() async {

    // update uri with shop id
    var url = Uri.parse(getItems);
    // show url

    url = url.replace(queryParameters: {
      "id": "65a9d9388ed17b6d45c3bb48"
    });
    dev.log(url.toString());

    var response = await http.get(url);
    dev.log("\n\n" + response.body.toString());
    var res = jsonDecode(response.body);
    dev.log(res.toString());
    items = res['success'];
    dev.log("to item \n\n "+ items.toString());
    if (res['status'] == true) {
      setState(() {
        
        dev.log(res['su'].toString());
        dev.log("\n\n" + items.toString());
      });
    } else {
      dev.log('Failed to fetch items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Dashboard'),
      ),
      body: Column(
        children: [
          Text(
            'Shop ID: ${widget.shopId}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${items[index]['name']}"),
                  onTap: () {
                    Navigator.pushNamed(context, '/item_add',
                        arguments: widget.shopId);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/item_add', arguments: widget.shopId);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
