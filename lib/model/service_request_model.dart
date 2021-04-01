import 'dart:io';

class ServiceRequest {
  String title;
  String details;
  File? image;

  ServiceRequest({
    required this.title,
    required this.details,
    required this.image,
  });

  Map<String, dynamic> toMap() => {
        "title": this.title,
        "details": this.details,
      };
}
