import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceDesk extends StatefulWidget {
  @override
  _ServiceDeskState createState() => _ServiceDeskState();
}

class _ServiceDeskState extends State<ServiceDesk> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    CollectionReference serviceRequests =
        FirebaseFirestore.instance.collection("ServiceRequest");
    return Scaffold(
      appBar: AppBar(
        title: Text("Servis Masası"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: GoogleMap(
              mapType: MapType.terrain,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                print("onMapCreated executed");
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: serviceRequests.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshotList) {
                if (snapshotList.hasData) {
                  List<Widget> listTileList = [];
                  var docs = snapshotList.data?.docs;
                  if (docs != null) {
                    for (var doc in docs) {
                      listTileList.add(
                        ListTile(
                          title: Text(doc["title"] ?? ""),
                        ),
                      );
                    }
                  }

                  return ListView(
                    children: listTileList,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
