import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location_markers_app/Provider/databaseController.dart';
import 'package:provider/provider.dart';
import '../Provider/locationController.dart';
import 'AddressListingWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllLocation();
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
                onPressed: () async {
                  var prov =
                      Provider.of<LocationProvider>(context, listen: false);

                  try {
                    final position = await prov.GetCurrentLocation();
                    await prov.updateLocation(position);
                    Fluttertoast.showToast(
                      msg: 'Loading Your Current Address',
                      backgroundColor: Colors.black,
                    );
                    prov.Livelocation(context);
                    await Fluttertoast.showToast(
                      msg: 'Showing  Your Current Address',
                      backgroundColor: Colors.black,
                    );
                  } on Exception catch (error) {
                    if (kDebugMode) {
                      print(error);
                    } else {}
                  }
                  Navigator.pushNamed(context, '/add_location');
                },
                child: const Text('Mark Location'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/locations_map');
                },
                child: const Text('Locations Map'),
              ),
            ],
          ),
          const Text("History of Marked Location"),
          Container(
            height: ht * 0.81,
            width: wt * 0.95,
            color: Colors.grey,
            child: const AddressListingWidget(),
          )
        ],
      ),
    );
  }
}
