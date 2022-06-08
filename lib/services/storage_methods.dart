/*
 * Firebase Storage Control
 * *
 * Use to upload Image and Video
 */
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  //
  // ***
  // Create firebase instances
  // ***
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //
  // ***
  // Upload Image to Storge
  // ***
  //
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //
  // ***
  // Upload Video to Storge
  // ***
  //
  Future<String> uploadVideoToStorage(
      String childName, Uint8List file, bool isPost) async {
    String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    String videoID = '${_auth.currentUser!.uid}-$time';
    Reference ref = _storage.ref().child(childName).child(videoID);
    String currentUserId = _auth.currentUser!.uid;
    if (currentUserId.isNotEmpty) {
      createTrigger(videoID, currentUserId);
    } else {
      throw Exception("User not loggin !");
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //
  // ***
  // Upload Data Info To Storage
  // Include
  // ***
  //
  Future<void> createTrigger(String videoID, String userID) async {
    final data = <String, dynamic>{
      "isTrained": false,
      "userID": userID,
      // "productID": productID,
      "videoID": videoID
    };
    _firestore.collection("data-ai").add(data);
  }
}
