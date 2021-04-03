import 'package:bloc/bloc.dart';
import 'package:project19/model/service_request_model.dart';

import 'service_req_state.dart';

class ServiceReqsCubit extends Cubit<ServiceReqState> {
  ServiceReqsCubit() : super(ServiceReqInitial());

  Future<void> getServiceReqs() async {
    // loading phase
    emit(ServiceReqLoading());
    // service call
    await Future.delayed(Duration(seconds: 3));
    List<ServiceRequest> response = [
      ServiceRequest(
        title: "Onarım Talebi",
        details: "Acil destek",
        imageFile: null,
      ),
      ServiceRequest(
        title: "Yedekleme Talebi",
        details: "İvedi destek",
        imageFile: null,
      ),
      ServiceRequest(
        title: "Güncelleme Talebi",
        details: "Çok ivedi destek",
        imageFile: null,
      ),
    ];
    // completed
    emit(ServiceReqCompleted(response));
  }
}
