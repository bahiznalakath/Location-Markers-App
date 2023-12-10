import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_markers_app/Provider/databaseController.dart';
import 'package:location_markers_app/Provider/locationController.dart';
import 'package:location_markers_app/screen/home_page.dart';
import 'package:location_markers_app/screen/location_map.dart';
import 'package:provider/provider.dart';

import 'screen/add_location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<DataBaseController>(
        //     create: (_) => DataBaseController()),
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        title: 'Location Markers App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add_location': (context) =>  const AddLocation(),
          '/locations_map': (context) => const LocationMap(),
        },
      ),
    );
  }
}
