import 'package:flutter/material.dart';
import 'package:location_markers_app/Provider/databaseController.dart';
import 'package:location_markers_app/screen/home_page.dart';
import 'package:location_markers_app/screen/location_map.dart';
import 'package:provider/provider.dart';

import 'screen/add_location.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataBaseController>(create: (_) => DataBaseController()),
      ],
      child: MaterialApp(
        title: 'Location Markers App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: true,
        // home: const HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add_location': (context) => const AddLocation(),
          '/locations_map': (context) => const GeolocatorWidget(),
        },
      ),
    );
  }
}
