import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class AuthService {  // Changed from AuthServices to AuthService
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<User?> loginUserWithEmailandPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Login Error: $e");
      return null;
    }
  }

  // Signup function
  Future<User?> createUserWithEmailandPassword(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Signup Error: $e");
      return null;
    }
  }

  // Logout function
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Signout Error: $e");
    }
  }
}
