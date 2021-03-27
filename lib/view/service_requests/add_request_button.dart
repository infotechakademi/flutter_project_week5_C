import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project19/model/service_request_model.dart';
import 'package:project19/state/service_request_state.dart';
import 'package:project19/view/service_requests/new_service_request_page.dart';
import 'package:provider/provider.dart';

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
