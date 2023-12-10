import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location_markers_app/Provider/locationController.dart';
import 'package:provider/provider.dart';

import '../Provider/databaseController.dart';
import '../model/model_class.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery
        .sizeOf(context)
        .height;
    final wt = MediaQuery
        .sizeOf(context)
        .width;
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var prov = Provider.of<LocationProvider>(context, listen: false);

          try {
            final position = await prov.GetCurrentLocation();
            prov.updateLocation(position);
          } on Exception catch (error) {
            if (kDebugMode) {
              print(error);
            }
          }
          prov.Livelocation(context);
        },
        child: const Icon(Icons.add_location_rounded),
      ),
      appBar: AppBar(
        title: const Text("AddLocation"),
      ),
      body: Center(
        child: Container(
          height: ht * 0.81,
          width: wt * 0.95,
          color: Colors.grey,
          child: Consumer<LocationProvider>(
            builder: (context, locationProvider, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: ht * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latitude:${locationProvider.Latitude}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Longitude:${locationProvider.Longitude}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ht * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Your Current Address is : ${locationProvider
                          .postcode}${locationProvider.street}${locationProvider
                          .country}${locationProvider.sublocality}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: ht * .2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: () async {
                          var locationProvider = Provider.of<LocationProvider>(context, listen: false);

                          // Create a LocationModel with the current data
                          LocationModel locationModel = LocationModel(
                            latitude: locationProvider.Latitude,
                            longitude: locationProvider.Longitude,
                            postalCode: locationProvider.postcode,
                            street: locationProvider.street,
                            subLocality: locationProvider.sublocality,
                            country: locationProvider.country,
                          );

                          // Save the location to the database
                          try {
                            await DataBaseController.instance.create(locationModel);
                            Fluttertoast.showToast(
                              msg: 'Location saved successfully!',
                              backgroundColor: Colors.green,
                            );
                          } catch (error) {
                            Fluttertoast.showToast(
                              msg: 'Error saving location: $error',
                              backgroundColor: Colors.red,
                            );
                          }

                          // Pop the screen
                          Navigator.pop(context);
                        }, child: const Text("Save Your Location")),

                        ElevatedButton(onPressed: () async {
                          Fluttertoast.showToast(
                            msg: 'Opening Your Current Location In Google Map',
                            backgroundColor: Colors.black,
                          );
                         await  locationProvider.openMap(locationProvider.Latitude,
                              locationProvider.Longitude);
                        }, child: const Text("Open Location In Google Map")),
                      ],),
                  ),
                  SizedBox(
                    height: ht * .01,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
