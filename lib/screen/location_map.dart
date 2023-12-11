import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../Provider/databaseController.dart';
import '../Provider/locationController.dart';
import '../model/model_class.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  Completer<GoogleMapController> _controller = Completer();

  // static const CameraPosition _kGoogle = CameraPosition(
  //   target: LatLng(11.043428, 75.8856747),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    getAllLocation();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
      ),
      body: ValueListenableBuilder<List<LocationModel>>(
        valueListenable: locationListNotifier,
        builder: (BuildContext context, List<LocationModel> locationList,
            Widget? child) {
          final currentLocationProvider =
              Provider.of<LocationProvider>(context);
          double currentLatitude =
              double.tryParse(currentLocationProvider.Latitude) ?? 0.0;
          double currentLongitude =
              double.tryParse(currentLocationProvider.Longitude) ?? 0.0;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(currentLatitude, currentLongitude),
              zoom: 2,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _buildMarkers(locationList, context),
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(
      List<LocationModel> locationList, BuildContext context) {
    Set<Marker> markers = Set();

    final currentLocationProvider = Provider.of<LocationProvider>(context);
    double currentLatitude =
        double.tryParse(currentLocationProvider.Latitude) ?? 0.0;
    double currentLongitude =
        double.tryParse(currentLocationProvider.Longitude) ?? 0.0;

    markers.add(Marker(

      markerId: const MarkerId("Marked Location"),
      position: LatLng(currentLatitude, currentLongitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(title: "Current Location"),
    ));

    // Add red markers for saved locations
    for (LocationModel location in locationList) {
      double savedLatitude = double.tryParse(location.latitude) ?? 0.0;
      double savedLongitude = double.tryParse(location.longitude) ?? 0.0;

      markers.add(Marker(
        markerId: MarkerId(location.id.toString()),
        position: LatLng(savedLatitude, savedLongitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: "Saved Location"),
      ));
    }

    return markers;
  }
}
