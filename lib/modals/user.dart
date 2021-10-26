import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.scope,
    required this.personName,
    required this.personEmail,
    required this.personId,
    required this.personType,
  });

  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final int expiresIn;
  final String scope;
  final String personName;
  final String personEmail;
  final int personId;
  final String personType;

  User copyWith({
    required String accessToken,
    required String tokenType,
    required String refreshToken,
    required int expiresIn,
    required String scope,
    required String personName,
    required String personEmail,
    required int personId,
    required String personType,
  }) =>
      User(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        refreshToken: refreshToken ?? this.refreshToken,
        expiresIn: expiresIn ?? this.expiresIn,
        scope: scope ?? this.scope,
        personName: personName ?? this.personName,
        personEmail: personEmail ?? this.personEmail,
        personId: personId ?? this.personId,
        personType: personType ?? this.personType,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
        scope: json["scope"],
        personName: json["personName"],
        personEmail: json["personEmail"],
        personId: json["personId"],
        personType: json["personType"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
        "scope": scope,
        "personName": personName,
        "personEmail": personEmail,
        "personId": personId,
        "personType": personType,
      };

  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

}
