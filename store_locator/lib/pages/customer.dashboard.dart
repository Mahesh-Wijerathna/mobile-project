import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomerDashboardPage extends StatefulWidget {
  CustomerDashboardPage({Key? key}) : super(key: key);

  @override
  _CustomerDashboardPageState createState() => _CustomerDashboardPageState();
}

class _CustomerDashboardPageState extends State<CustomerDashboardPage> {
  final List markers = [];

  final TextEditingController _nameController = TextEditingController();

  void search() async {
    var url = Uri.parse(getItemToCustomer);
    url = url.replace(queryParameters: {
      // Add query parameters here
      "name": _nameController.text,
    });
    dev.log("url ${url.toString()}");

    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    dev.log(jsonResponse.toString());

    var place = jsonResponse['success'];
    var locs = place;

    dev.log("\n\n place ${locs.toString()}");

    List newMarkers = [];

    for (var location in place) {
      var latitude = location['location'];
      var longitude = location['location'];
      dev.log("\n\nlatitude ${latitude.toString()}");

      newMarkers.add(latitude);
    }
    dev.log("\n\n new markers  >> ${newMarkers.toString()}");

    setState(() {
      markers.clear();
      markers.addAll(newMarkers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Locator'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              search();
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  7.8731,
                  80.7718,
                ),
                zoom: 8,
              ),
              markers: Set<Marker>.from(markers.map((e) => Marker(
                markerId: MarkerId(e.toString()),
                position: LatLng(e[0], e[1]),
              ))),
            ),
          ),
        ],
      ),
    );
  }
}
