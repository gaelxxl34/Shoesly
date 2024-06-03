import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/user_model.dart';


class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUpWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        UserModel newUser = UserModel(
          uid: user.uid,
          name: name,
          email: email,
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Future.error('Email already in use.');
      } else if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'invalid-email') {
        return Future.error('The email address is not valid.');
      }
      return Future.error('Sign-up failed.');
    } catch (e) {
      return Future.error('Sign-up failed.');
    }
    return null;
  }


  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
          return userModel;
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('No user found with this email.');
      } else if (e.code == 'wrong-password') {
        return Future.error('Incorrect password.');
      }
      return Future.error('Login failed.');
    } catch (e) {
      return Future.error('Login failed.');
    }
    return null;
  }



  Future<void> signOut() async {
    await _auth.signOut();
  }


}

