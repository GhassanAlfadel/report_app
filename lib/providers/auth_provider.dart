import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool logedin = false;
  String userId = "";

  Future<void> signup(String email, String password) async {
    final pref = await SharedPreferences.getInstance();

    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String id = user.user!.uid;
      userId = id;
      notifyListeners();

      await pref.setBool("logedin", true);
      chekAuthState();
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String password) async {
    final pref = await SharedPreferences.getInstance();
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      String id = user.user!.uid;
      userId = id;
      notifyListeners();

      await pref.setBool("logedin", true);
      chekAuthState();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    try {
      _auth.signOut();
      await pref.clear();
      userId = "";
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void chekAuthState() async {
    final pref = await SharedPreferences.getInstance();
    bool? logStatus = pref.containsKey("logedin");
    if (logStatus) {
      logedin = true;
      notifyListeners();
    } else {
      logedin = false;
      notifyListeners();
    }
  }

  Future resetPasseord(String email) async {
    _auth.sendPasswordResetEmail(email: email).then((onValue) {});
  }
}
