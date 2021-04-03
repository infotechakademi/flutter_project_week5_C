import 'package:flutter/material.dart';
import 'package:project19/model/service_request_model.dart';
import 'package:project19/service/database_service.dart';

class ServiceRequestState extends ChangeNotifier {
  List<ServiceRequest> _serviceRequestList = <ServiceRequest>[];

  List<ServiceRequest> get serviceRequestList => _serviceRequestList;

  Stream get serviceRequestListStream =>
      DatabaseService.instance.getServiceRequestsStream();

  void addServiceRequest(ServiceRequest serviceRequest) async {
    // image upload
    print(serviceRequest.imageUrl);
    serviceRequest.imageUrl =
        await DatabaseService.instance.uploadImage(serviceRequest);

    // url
    // serviceRequest.imageUrl = url
    if (serviceRequest.imageUrl != null) {
      await DatabaseService.instance.addServiceRequest(serviceRequest.toMap());
      _serviceRequestList.add(serviceRequest);
      notifyListeners();
    }
  }

  void removeServiceRequest(ServiceRequest serviceRequest) {
    _serviceRequestList.remove(serviceRequest);
    notifyListeners();
  }
}
