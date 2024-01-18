import 'package:flutter/material.dart';

class ShopDashboard extends StatelessWidget {
  final String shopId;

  ShopDashboard({required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Dashboard'),
      ),
      body: Column(
        children: [
          Text(
            'Shop ID: $shopId',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<String> items = [
  'Item 1',
  'Item 2',
  'Item 3',
  // Add more items here
];
