import 'package:flutter/material.dart';
import 'package:project19/model/service_request_model.dart';
import 'package:project19/state/service_request_state.dart';
import 'package:provider/provider.dart';

import 'add_request_button.dart';

class ServiceRequestPage extends StatefulWidget {
  @override
  _ServiceRequestPageState createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servis İsteklerim"),
        centerTitle: true,
      ),
      floatingActionButton: AddRequestButton(),
      body: Consumer<ServiceRequestState>(
          builder: (context, ServiceRequestState serviceRequestState, _) {
        final _serviceRequestList = serviceRequestState.serviceRequestList;
        return ListView.builder(
          itemCount: _serviceRequestList.length,
          itemBuilder: (context, index) {
            final _serviceRequst = _serviceRequestList[index];
            return listItem(_serviceRequst);
          },
        );
      }),
    );
  }

  listItem(ServiceRequest _request) {
    return ListTile(
      title: Text(_request.title),
      subtitle: Text(_request.details),
      leading:
          _request.imageFile != null ? Image.file(_request.imageFile!) : null,
      trailing: IconButton(
        icon: Icon(
          Icons.remove,
        ),
        onPressed: () {
          // remove ServiceRequest
          var _state = Provider.of<ServiceRequestState>(context, listen: false);
          _state.removeServiceRequest(_request);
        },
      ),
    );
  }
}
