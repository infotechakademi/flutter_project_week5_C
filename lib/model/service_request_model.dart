import 'dart:io';

import 'package:flutter/material.dart';

class ServiceRequest {
  String title;
  String details;
  File? image;

  ServiceRequest({
    required this.title,
    required this.details,
    required this.image,
  });
}
