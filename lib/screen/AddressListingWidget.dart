import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location_markers_app/Provider/databaseController.dart';
import 'package:provider/provider.dart';

import '../Provider/locationController.dart';
import '../model/model_class.dart';

class AddressListingWidget extends StatelessWidget {
  const AddressListingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<LocationModel>>(
      valueListenable: locationListNotifier,
      builder: (BuildContext context, List<LocationModel> locationList,
          Widget? child) {
        return Column(
          children: locationList.map((LocationModel location) {
            return Column(
              children: [
                ListTile(
                  leading: IconButton(
                      color: Colors.greenAccent,
                      onPressed: () async {
                        var prov = Provider.of<LocationProvider>(context,
                            listen: false);
                        await Fluttertoast.showToast(
                          msg: 'Opening Your Current Location In Google Map',
                          backgroundColor: Colors.black,
                        );
                        await prov.openMap(
                            location.latitude, location.longitude);
                      },
                      icon: const Icon(Icons.place)),
                  title: Text(
                    '${location.street}, ${location.postalCode}, \n ${location.country}, ${location.subLocality}',
                  ),
                  subtitle: Row(
                    children: [
                      Text('lati: ${location.latitude}'),
                      Text("long: ${location.longitude}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Location"),
                            content: const Text(
                                "Are you sure you want to delete The Marked this location?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  if (location.id != null) {
                                    deleteLocation(location.id!);
                                    print(location.id!);
                                    await Fluttertoast.showToast(
                                      msg: 'Delete Marked Location',
                                      backgroundColor: Colors.black,
                                    );
                                  } else {
                                    print("Location id is null");
                                  }
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
