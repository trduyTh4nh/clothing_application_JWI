// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/page/auth/login.dart';
import '../model/user.dart';

Future<bool> saveUser(User objUser, String token) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = jsonEncode(objUser);
    prefs.setString('user', strUser);
    prefs.setString('token', token);
    print("Luu thanh cong: $strUser");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> logOut(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
    print("Logout thành công");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

//
Future<User> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String strUser = pref.getString('user')!;
  return User.fromJson(jsonDecode(strUser));
}
