import 'package:flutter/material.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';


class MyApps extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppsState();
  }
}

class _MyAppsState extends State<MyApps>{
  final ImagePicker imagePicker = ImagePicker();

  XFile? _image;

  Future getImage(bool isCamera) async {
    XFile? image;
    if(isCamera){

      image = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image  = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('TestModel')),
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(onPressed: (){
              getImage(false);
            },
              icon: Icon(Icons.insert_drive_file),
            ),
            SizedBox(
              height: 10.0,
            ),
            IconButton(onPressed: (){
              getImage(true);
            },
              icon: Icon(Icons.camera_alt),
            ),
            _image == null ? Container() : Image.file(File(_image!.path), height: 300.0, width: 300.0,)
          ],
        ),
      ),
    );

  }


}