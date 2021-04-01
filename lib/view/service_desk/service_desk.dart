import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceDesk extends StatefulWidget {
  @override
  _ServiceDeskState createState() => _ServiceDeskState();
}

class _ServiceDeskState extends State<ServiceDesk> {
  @override
  Widget build(BuildContext context) {
    CollectionReference serviceRequests =
        FirebaseFirestore.instance.collection("ServiceRequest");
    return Scaffold(
      appBar: AppBar(
        title: Text("Servis Masası"),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
    );
  }
}
