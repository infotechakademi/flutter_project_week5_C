import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static late FirebaseFirestore _firebase;

  DatabaseService._internal();

  static late DatabaseService _instance;

  static DatabaseService get instance {
    if (_instance == null) {
      _instance = DatabaseService._internal();
      _firebase = FirebaseFirestore.instance;
    }
    return DatabaseService._internal();
  }

  static String _serviceRequestCollection = "ServiceRequest";

  Future addServiceRequest(Map<String, dynamic> data) async {
    await _firebase.collection(_serviceRequestCollection).add(data);
  }

  Future getServiceRequest() async {
    await _firebase.collection(_serviceRequestCollection).get();
  }
}
