import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/settings.dart';
import 'package:suf_linux/services.dart/auth.dart';
import 'package:http/http.dart' as http;

class SettingsProvider extends ChangeNotifier {
  final baseUrl = "https://smartgrowsystem-sgs.firebaseio.com/appSettings";
  String token;
  Settings settings;

  // final ref = firebaseDatabase.reference().child("appSettings");

  List<AppTheme> themes = [
    new AppTheme(
      name: "light",
      cardColor: Colors.white,
      background: Colors.white,
      textColor: Colors.black.withOpacity(0.85),
      secondaryTextColor: Colors.black.withOpacity(0.65),
      headlineColor: Colors.black.withOpacity(0.85),
      secondaryColor: Color(0xFF3f51b5),
      primaryColor: Color(0xFF3FB980),
      contrast: Colors.grey[100],
      disabled: Colors.black12,
    ),
    new AppTheme(
      name: "dark",
      cardColor: Colors.grey[850],
      background: Colors.grey[900],
      textColor: Colors.white,
      headlineColor: Colors.grey[300],
      primaryColor: Color(0xFF3FB980),
      secondaryColor: Color(0xFF3f51b5),
      contrast: Colors.grey[850],
      disabled: Colors.white54,
    )
  ];

  Future<void> loadSettings() async {
    token = await Auth.getAuthToken();
    /* await ref.once().then((DataSnapshot snapshot) {
      var settingsJson = snapshot.value;
      settings = Settings.fromJson(settingsJson);
    });*/
    if (settings == null) {
      settings =
          new Settings(theme: 0, automaticTimeLapse: true, notifications: true);
    }
  }

  Future<void> setValue(String child, String value) {
    http.put("$baseUrl/$child.json?auth=$token", body: "$value", headers: {
      "Content-Tpye": "application/json",
    }).then(
      (value) => {
        print(value.statusCode),
      },
    );
  }

  setNotifications(value) {
    settings.notifications = value;
    setValue("notifications", value.toString());

    notifyListeners();
  }

  setAutomaticTimeLapse(value) {
    settings.automaticTimeLapse = value;

    setValue("automaticTimeLapse", value.toString());
    notifyListeners();
  }

  setTheme(index) {
    settings.theme = index;
    setValue("theme", index.toString());

    notifyListeners();
  }

  bool getSelected(index) {
    if (settings.theme == index)
      return true;
    else
      return false;
  }

  AppTheme getTheme() {
    return themes[settings.theme];
  }
}
