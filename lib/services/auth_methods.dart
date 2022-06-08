import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clothing_store_app_ui/services/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  // ***
  // Get Uset Info
  // ***
  //
  List<String?>? getAuthInfo() {
    List<String?>? userData;
    Map<String, dynamic>? userInfo;
    if (_auth.currentUser != null) {
      print('abc');
      print(_firestore.collection('users'));

      var path = _firestore
          .collection('users')
          .where('uid', isEqualTo: _auth.currentUser?.uid);
      //     .snapshots()
      //     .map((snapshot) {
      //   snapshot.docs.map((doc) {
      //     userInfo = doc.data();
      //     print(doc);
      //   });
      // });

      print(path);

      userData = [
        _auth.currentUser?.uid,
        _auth.currentUser?.displayName,
        _auth.currentUser?.email,
        // userInfo?['photoUrl']
      ];
    } else {
      userData = null;
    }
    return userData;
  }

  //
  // ***
  // Sign up user
  // ***
  //
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        await _firestore.collection('users').add({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //
  // ***
  // Log in User
  // ***
  //
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //
  // ***
  // Log out user
  // ***
  //
  Future<String> logOut() async {
    String res = "Some error occured";
    await _auth.signOut();
    return res;
  }
}
