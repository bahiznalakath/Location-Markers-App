// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

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
            child: const Column(
              children: [Text('History of Locations '), Divider()],
            ),
          )
        ],
      ),
    );
  }
}
