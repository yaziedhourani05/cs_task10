import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_riverpod/models/user/auth_user.dart';

import 'package:flutter/material.dart';

class UserService {
  static User currentUserId() {
    return FirebaseAuth.instance.currentUser!;
  }

  static Future<AuthUser> getCurrentUserInfo() async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserId().uid)
        .get()
        .then((value) {
      return AuthUser.fromJson(value.data()!);
    });
  }

  static Stream<User?> getAuthStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  static upsertProfileInfo(AuthUser authUser, String currentUserId) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserId.toString())
        .set(authUser.toJson());
  }

  static Future<DocumentSnapshot> profileSetUpStatus(
      String currentUserId) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUserId)
        .get();
  }

  static createUser(AuthUser authUser) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: authUser.email, password: authUser.password!)
        .then((value) {
      return FirebaseFirestore.instance
          .collection('user')
          .doc(value.user!.uid)
          .set(
            authUser.toJson(),
          );
    });
  }

  static login(AuthUser authUser) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authUser.email, password: authUser.password!);
  }

  static logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
