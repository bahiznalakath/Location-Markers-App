import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  String locationMessage = "Current location is ";
  late String lat;
  late String long;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getCurrentLocation().then((value) {
              lat = '${value.latitude}';
              long = '${value.longitude}';
            });

            _livelocation();
          },
          child: const Icon(Icons.add_location_rounded)),
      appBar: AppBar(
        title: const Text("AddLocation "),
      ),
      body: Center(
        child: Column(
          children: [
            Text(locationMessage),
          ],
        ),
      ),
    );
  }

  void _livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      {
        lat = position.latitude.toString();
        long = position.longitude.toString();
        setState(() {
          locationMessage = 'latitude:$lat,longitude $long';
        });
      }
    });
  }
}

_getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled ');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location Permission are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location Permission are permanently denied, we cannot request');
  }
  return await Geolocator.getCurrentPosition();
}
