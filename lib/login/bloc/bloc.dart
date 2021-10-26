import 'dart:convert';

import 'package:earbo/main.dart';
import 'package:earbo/resources/provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  final String email;
  final String pass;

  Login(this.email, this.pass);
}

class BlocLogin {
  final login = BehaviorSubject<Login>();
  final GlobalKey<FormState> formkey;

  BlocLogin({required this.formkey}) {
    login.add(Login("", ""));
  }

  changeEmail(String value) => login.add(Login(value, login.value.pass));

  changePass(String value) => login.add(Login(login.value.email, value));

  Future<bool> logIn() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String basicAuth;

    if (login.value.email.isEmpty || login.value.email == "") {
      basicAuth =
          'Basic ' + base64Encode(utf8.encode('admin@earbo.com:adminearbo'));
    } else {
      basicAuth = 'Basic ' +
          base64Encode(utf8.encode('${login.value.email}:${login.value.pass}'));
    }

    Map data = await Provider(hasToken: false)
        .get("/login", header: {"Authorization": basicAuth});
    Logger().i(data);
    if (data.isEmpty) return false;
    prefs.setString("token", data['token']);
    prefs.setString("user", json.encode(data['user']));
    return true;
  }

  static logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentState!.context, '/', (route) => false);
  }

  dispose() {
    login.close();
  }
}
