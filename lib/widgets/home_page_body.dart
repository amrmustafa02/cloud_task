import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePageBody extends StatefulWidget {
  HomePageBody({super.key, required this.userName});

  String userName;

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  File? file;
  bool isLoading = false;
  int loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          file == null
              ? SizedBox(
                  width: size.width / 2,
                  child: Image.asset("assets/images/Add files-bro.png"))
              : Text(
                  file!.path,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
          SizedBox(
            width: size.width / 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                getFile();
              },
              child: const Text("Add File"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: isLoading,
            child: CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: loadingPercentage / 100,
              center: Text("$loadingPercentage %"),
              progressColor: Colors.green,
            ),
          ),
          SizedBox(
            width: size.width / 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                uploadToFireBase();
              },
              child: const Text("Upload"),
            ),
          ),
        ],
      ),
    );
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      setState(() {});
    } else {}
  }

  uploadToFireBase() async {
    if (file != null) {
      final storage = FirebaseStorage.instance;

      final storageRef = storage.ref();

      final userRef =
          storageRef.child("${widget.userName}/${p.basename(file!.path)}");

      var upload = userRef.putFile(file!);

      upload.snapshotEvents.listen((taskSnapshot) async {
        isLoading = true;
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress =
                100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            loadingPercentage = progress.toInt();
            setState(() {});
            break;
          case TaskState.paused:
            Fluttertoast.showToast(
                msg: "File Upload ...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            break;
          case TaskState.canceled:
            Fluttertoast.showToast(
                msg: "File Upload canceled...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            break;

          case TaskState.error:
            Fluttertoast.showToast(
                msg: "File Upload error...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            break;
          case TaskState.success:
            Fluttertoast.showToast(
                msg: "File Upload Successfully...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);

            var downLoadUrl = await userRef.getDownloadURL();
            await addUrlToFirebase(downLoadUrl);

            Fluttertoast.showToast(
                msg: "save download url Successfully...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            break;
        }
      });
    }
  }

  addUrlToFirebase(String url) async {
    var db = FirebaseFirestore.instance;
    var userCollection = db.collection(widget.userName);
    await userCollection.doc().set({"url": url});
  }
}
