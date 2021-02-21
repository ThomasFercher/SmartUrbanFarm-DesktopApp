import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/settings.dart';
import 'package:suf_linux/services.dart/auth.dart';
import 'package:http/http.dart' as http;

class SettingsProvider extends ChangeNotifier {
  final baseUrl =
      "https://smartgrowsystem-sgs.firebaseio.com/appSettingsDesktop";
  String token;
  Settings settings;

  bool getSelected(index) => settings.theme == index;
  AppTheme getTheme() => themes[settings.theme];

  final List<AppTheme> themes = [
    AppTheme(
      name: "light",
      cardColor: Colors.white,
      background: Colors.white,
      textColor: Colors.black.withOpacity(0.85),
      secondaryTextColor: Colors.black.withOpacity(0.65),
      headlineColor: Colors.black.withOpacity(0.85),
      secondaryColor: Color(0xFF3f51b5),
      primaryColor: Color(0xFF26C281),
      contrast: Colors.grey[100],
      disabled: Colors.black12,
    ),
    AppTheme(
      name: "dark",
      cardColor: Colors.grey[850],
      background: Colors.grey[900],
      textColor: Colors.white,
      headlineColor: Colors.grey[300],
      primaryColor: Color(0xFF26C281),
      secondaryColor: Color(0xFF3f51b5),
      contrast: Colors.grey[850],
      disabled: Colors.white54,
    )
  ];

  /// Loads the AppSettings from the Firebase. If there is
  /// a error a local Object will be initialized.
  Future<void> loadSettings() async {
    await http.get(
      "$baseUrl.json?auth=$token",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (value) {
        switch (value.statusCode) {
          case 200:
            Map<dynamic, dynamic> json = jsonDecode(value.body);
            settings = new Settings.fromJson(json);
            print("Successfull Loaded Settings");
            return;
          case 400:
            settings = new Settings(
              theme: 0,
              automaticTimeLapse: true,
              notifications: true,
            );
            print("Error while trying to load Settings");
            return;
          default:
            return;
        }
      },
    );
  }

  /// This is a PUT Function to update a variable in the
  /// firebase Settings object. The [child] specifies the
  /// location where the [value] will be put. The response
  /// will be printed out.
  Future<void> setValue(String child, String value) async {
    await http.put(
      "$baseUrl/$child.json?auth=$token",
      body: "$value",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (value) {
        switch (value.statusCode) {
          case 200:
            print("Successfull Update of Settings/$child");
            return;
          case 400:
            print("Error while trying to update Settings/$child");
            return;
          case 412:
            print("Error while trying to update Settings/$child");
            return;
          default:
            return;
        }
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
}
