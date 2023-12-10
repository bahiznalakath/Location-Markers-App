import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationProvider with ChangeNotifier {
  String postcode = "";
  String street = "";
  String sublocality = "";
  String country = "";
  String Longitude = "";
  String Latitude = "";

  bool _locationFetched = true;

  bool get locationFetched => _locationFetched;


  Future<void> updateLocation(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];
    Latitude = '${position.latitude}';
    Longitude = '${position.longitude}';
    postcode = '${place.postalCode}';
    street =
        "${place.street},${place.subAdministrativeArea},${place.administrativeArea}";
    sublocality = "${place.subLocality}";
    country = "${place.country}";

    if (!_locationFetched) {
      _locationFetched = true;
      notifyListeners();
    }
  }

  Future<Position> GetCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void Livelocation(BuildContext context) async {
    try {
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      ).listen((position) {
        updateLocation(position);
      });
    } catch (error) {
      print(error);
    }
  }
  Future<void> openMap(String lat, String long) async {
    String googleURL =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw "Could not launch $googleURL";
  }

}
