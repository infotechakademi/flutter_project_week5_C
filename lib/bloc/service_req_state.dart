import 'package:project19/model/service_request_model.dart';

abstract class ServiceReqState {}

// initial
// loading
// completed
// error

class ServiceReqInitial extends ServiceReqState {
  ServiceReqInitial();
}

class ServiceReqLoading extends ServiceReqState {
  ServiceReqLoading();
}

class ServiceReqCompleted extends ServiceReqState {
  final List<ServiceRequest> serviceReqList;
  ServiceReqCompleted(this.serviceReqList);
}

class ServiceReqError extends ServiceReqState {
  final String errorText;
  ServiceReqError(this.errorText);
}
