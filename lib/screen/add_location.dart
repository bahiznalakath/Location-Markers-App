import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location_markers_app/Provider/locationController.dart';
import 'package:provider/provider.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
                    child: Column(
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
                      'Your Current Address is : ${locationProvider.postcode}${locationProvider.street}${locationProvider.country}${locationProvider.sublocality}',
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
                        ElevatedButton(
                            onPressed: () async {
                              await locationProvider.savedata();
                              await Fluttertoast.showToast(
                                msg: 'Saved  Your Current Location ',
                                backgroundColor: Colors.black,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("Save Your Location")),
                        ElevatedButton(
                            onPressed: () async {
                              Fluttertoast.showToast(
                                msg:
                                    'Opening Your Current Location In Google Map',
                                backgroundColor: Colors.black,
                              );
                              await locationProvider.openMap(
                                  locationProvider.Latitude,
                                  locationProvider.Longitude);
                            },
                            child: const Text("Open In Google Map")),
                      ],
                    ),
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
