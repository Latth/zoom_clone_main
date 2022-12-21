// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone_main/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(
    BuildContext context,
  ) async {
    bool res = false;
    try {
      //Sign in with google account
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //take the auth datas
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      //take the credential which comes from auth
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //sign in with the credential which comes from credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      res = false;
    }

    return res;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
