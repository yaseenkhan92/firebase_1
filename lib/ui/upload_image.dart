import 'dart:io';

import 'package:firebase_1/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  DatabaseReference myref = FirebaseDatabase.instance.ref("Test");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _image;
  final picker = ImagePicker();
  Future getImagallery() async {
    final PickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 78,
    );
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print("No image are selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload screen "),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImagallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(height: 40),
            RoundedButton(
              title: "Upload your image",
              ontap: () async {
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage
                    .instance
                    .ref("/foldername" + '1234');
                firebase_storage.UploadTask uploadTask = ref.putFile(
                  _image!.absolute,
                );
                await Future.value(uploadTask);
                var newurl = ref.getDownloadURL();
                myref.child('1').set({
                  'id': "13314",
                  "title": newurl.toString(),
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
