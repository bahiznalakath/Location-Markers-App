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

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(11.043428, 75.8856747),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    var prov =
    Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Maps"),
        ),
        body: ValueListenableBuilder<List<LocationModel>>(
          valueListenable: locationListNotifier,
          builder: (BuildContext context, List<LocationModel> locationList,
              Widget? child) {
            return GoogleMap(
              initialCameraPosition: _kGoogle,
              // markers: {
              //   Marker(markerId: MarkerId("soucre"),position: _kGoogle)
              // },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          },
        ));
  }
}
