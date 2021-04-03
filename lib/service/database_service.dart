import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project19/model/service_request_model.dart';

class DatabaseService {
  static late FirebaseFirestore _firebase;
  static late FirebaseStorage _storage;
  static bool initialized = false;

  DatabaseService._internal();

  static late DatabaseService _instance;

  static DatabaseService get instance {
    if (initialized == false) {
      print("-1-");
      initialized = true;
      _firebase = FirebaseFirestore.instance;
      _storage = FirebaseStorage.instance;
      _instance = DatabaseService._internal();
    }
    print("_instance: " + _instance.toString());
    return DatabaseService._internal();
  }

  static String _serviceRequestCollection = "ServiceRequest";

  Stream getServiceRequestsStream() {
    return _firebase.collection(_serviceRequestCollection).snapshots();
  }

  Future addServiceRequest(Map<String, dynamic> data) async {
    await _firebase.collection(_serviceRequestCollection).add(data);
  }

  Future getServiceRequest() async {
    await _firebase.collection(_serviceRequestCollection).get();
  }

  Future<String> uploadImage(ServiceRequest serviceRequest) async {
    var ref = _storage.ref("images/${serviceRequest.title}.jpg");
    if (serviceRequest.imageFile != null) {
      UploadTask uploadTask = ref.putFile(serviceRequest.imageFile!);
      var data = await uploadTask;
      var url = data.ref.getDownloadURL();

      return url;
    }
    return "";
  }
}
