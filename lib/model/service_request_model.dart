import 'dart:io';

class ServiceRequest {
  String title;
  String details;
  File? imageFile;
  String? imageUrl;

  ServiceRequest({
    required this.title,
    required this.details,
    required this.imageFile,
  });

  Map<String, dynamic> toMap() => {
        "title": this.title,
        "details": this.details,
        "imageUrl": this.imageUrl,
      };
}
