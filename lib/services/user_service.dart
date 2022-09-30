import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_riverpod/models/current_user.dart';
import 'package:flutter/material.dart';

class UserService {
  static User getCurrentUser() {
    return FirebaseAuth.instance.currentUser!;
  }

  static Stream<User?> getAuthStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  static createUser(CurrentUser currentUser) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: currentUser.email!, password: currentUser.password!);
    await FirebaseFirestore.instance
        .collection('user')
        .add(currentUser.toJson());
  }

  static login(CurrentUser currentUser) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: currentUser.email!, password: currentUser.password!);
  }
}
