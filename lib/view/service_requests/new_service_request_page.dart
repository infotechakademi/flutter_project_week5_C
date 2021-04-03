import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project19/model/service_request_model.dart';
import 'package:project19/state/service_request_state.dart';
import 'package:provider/provider.dart';

class NewServiceRequestPage extends StatefulWidget {
  @override
  _NewServiceRequestPageState createState() => _NewServiceRequestPageState();
}

class _NewServiceRequestPageState extends State<NewServiceRequestPage> {
  late final title, details;
  File? image;

  @override
  void initState() {
    title = 'Başlık ${Random().nextInt(100)}';
    details =
        "It is a long '$title' fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Container(
                height: 150,
                alignment: Alignment.center,
                child: Image.file(image!),
              ),
            Text(title),
            Divider(),
            SelectableText(details),
            (image != null) ? saveButton() : imageButton(),
          ],
        ),
      ),
    );
  }

  getImage(source) async {
    PickedFile? pickedImage = await ImagePicker().getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  imageButton() {
    return ButtonBar(
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.add_a_photo),
          label: Text("Kamera"),
          onPressed: () {
            getImage(ImageSource.camera);
          },
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.image),
          label: Text("Galeri"),
          onPressed: () {
            getImage(ImageSource.gallery);
          },
        ),
      ],
    );
  }

  saveButton() {
    return ElevatedButton(
      child: Text("Kaydet"),
      onPressed: () {
        var _state = Provider.of<ServiceRequestState>(context, listen: false);
        // add ServiceRequest
        final ServiceRequest newServiceRequest = ServiceRequest(
          title: title,
          details: details,
          imageFile: image,
        );
        _state.addServiceRequest(newServiceRequest);
        Navigator.pop(context);
      },
    );
  }
}
