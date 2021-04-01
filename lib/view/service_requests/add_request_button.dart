import 'package:flutter/material.dart';
import 'package:project19/view/service_requests/new_service_request_page.dart';

class AddRequestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewServiceRequestPage(),
          ),
        );
      },
    );
  }
}
