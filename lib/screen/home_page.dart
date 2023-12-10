// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import '../Provider/databaseController.dart';
import '../model/model_class.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Markers'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_location');
                },
                child: const Text('Add Location'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/locations_map');
                },
                child: const Text('Locations Map'),
              ),
            ],
          ),
          Container(
            height: ht * 0.81,
            width: wt * 0.95,
            color: Colors.grey,
            child: FutureBuilder<List<LocationModel>>(
          // Fetch the list of saved locations from the database
          future: DataBaseController.instance.readAllLocations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No locations saved yet.'),
          );
        } else {
          // Display the list of saved locations
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'History of Locations',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      LocationModel location = snapshot.data![index];
                      return ListTile(
                        title: Text('Latitude: ${location.latitude}'),
                        subtitle: Text('Longitude: ${location.longitude}'),
                        // Add more details if needed
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    ),
          )
        ],
      ),
    );
  }
}
