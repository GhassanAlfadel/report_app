import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:report_app/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool logedin = false;
  String userId = "";

  Future<void> signup(
      String email, String password, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String id = user.user!.uid;
      userId = id;
      Navigator.of(context).pushReplacementNamed("/home_screen");

      logedin = true;
      notifyListeners();

      await pref.setBool("logedin", true);
      chekAuthState();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("حدث خطأ ما حاول مره اخرى"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      String id = user.user!.uid;
      userId = id;
      Navigator.of(context).pushReplacementNamed("/home_screen");
      logedin = true;
      notifyListeners();

      await pref.setBool("logedin", true);
      chekAuthState();
    } on FirebaseAuthException catch (e) {
      String message = "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا";

      switch (e.code) {
        case CustomError.invalidEmail:
          message = "صيغة البريد الإلكتروني غير صحيحة";
          break;
        case CustomError.userNotFound:
          message = "المستخدم غير موجود";
          break;
        case CustomError.wrongPassword:
          message = "البريد الإلكتروني أو كلمة السر غير صحيح";
          break;
        case CustomError.networkError:
          message = "تأكد من اتصالك بالإنترنت";
          break;
        case CustomError.unknownError:
          message = "حصل خطأ ما الرجاء المحاولة مره أخرى";
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Future<void> logout(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    try {
      _auth.signOut();
      await pref.clear();
      Navigator.of(context).pushReplacementNamed("/auth_screen");
      userId = "";
      logedin = false;
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

  void autilogin() async {
    final pref = await SharedPreferences.getInstance();
    bool? logStatus = pref.containsKey("logedin");

    if (logStatus) {
      logedin = true;
      notifyListeners();
    }
  }

  Future resetPasseord(String email) async {
    _auth.sendPasswordResetEmail(email: email).then((onValue) {});
  }
}
