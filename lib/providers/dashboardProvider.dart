import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suf_linux/objects/climateControl.dart';
import 'package:suf_linux/objects/environmentSettings.dart';
import 'package:suf_linux/objects/liveData.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:http/http.dart';
import 'package:suf_linux/providers/auth.dart';
import '../styles.dart';
import 'package:http/http.dart' as http;

class DashboardProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final baseUrl = "https://smartgrowsystem-sgs.firebaseio.com";
  PageOption selectedChild;
  String token;

  LiveData liveData;
  ClimateControl activeClimate;
  List<ClimateControl> climates;
  SplayTreeMap<DateTime, double> temperatures = new SplayTreeMap();
  SplayTreeMap<DateTime, double> humiditys = new SplayTreeMap();

  void setSelectedChild(PageOption s) {
    selectedChild = s;
    notifyListeners();
  }

  DashboardProvider({this.selectedChild});

  Future<String> authApp() async {
    final response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAeTF-VH5vxA0-ssHg4rMcjIodzBnnPvPw");
    Map<dynamic, dynamic> user = jsonDecode(response.body);
    return user['idToken'];
  }

  Future<void> fetchData() async {
    token = await Auth.getAuthToken();
    liveData = await getLiveData();
    activeClimate = await getActiveClimate();
    climates = await getClimates();
    temperatures = await loadList("temperatures");
    humiditys = await loadList("humiditys");
    notifyListeners();
  }

  Future<T> getValue<T>(var url) async {
    final response = await http.get(url + "/liveData/$url.json");
    var body = jsonDecode(response.body);

    if (T == double) {
      body = double.parse(body);
    }
    return body;
  }

  Future<ClimateControl> getActiveClimate() async {
    final response = await http.get("$baseUrl/activeClimate.json?auth=$token");
    Map<dynamic, dynamic> json = jsonDecode(response.body);

    return ClimateControl.fromJson(json, true);
  }

  Future<List<ClimateControl>> getClimates() async {
    List<ClimateControl> climates = [];
    final response = await http.get("$baseUrl/climates.json?auth=$token");
    Map<dynamic, dynamic> json = jsonDecode(response.body);
    json.forEach((key, value) {
      if (key != activeClimate.id)
        climates.add(ClimateControl.fromJson(value, false));
    });

    return climates;
  }

  Future<LiveData> getLiveData() async {
    final response = await http.get("$baseUrl/liveClimate.json?auth=$token");
    Map<dynamic, dynamic> json = jsonDecode(response.body);

    return LiveData.fromJson(json);
  }

  SplayTreeMap<DateTime, double> getTemperatures() {
    return temperatures;
  }

  SplayTreeMap<DateTime, double> getHumiditys() {
    return humiditys;
  }

  Future<SplayTreeMap<DateTime, double>> loadList(String child) async {
    SplayTreeMap<DateTime, double> list = new SplayTreeMap();
    final response = await http.get("$baseUrl/$child.json?auth=$token");
    Map<dynamic, dynamic> json = jsonDecode(response.body);
    json.forEach((key, value) {
      list[DateTime.parse(key)] = double.parse(value);
    });

    return list;
  }

  void editClimate(ClimateControl initial, ClimateControl newClimate) {
    bool isActive = false;
    // If the active Climate is edited update active climate aswell
    if (initial.getID == activeClimate.getID) {
      setActiveClimate(newClimate);
      isActive = true;
    }
    // get the local ClimateControl Object by matching the id
    ClimateControl clim =
        climates.singleWhere((clim) => initial.getID == clim.getID);
    // edit in local list
    climates[climates.indexOf(clim)] = newClimate;
    // edit in firebase
    http.put("$baseUrl/climates/${initial.getID}.json?auth=$token",
        body: "${newClimate.getJson(isActive)}",
        headers: {
          "Content-Tpye": "application/json",
        }).then(
      (value) => {
        print(value.statusCode),
      },
    );

    notifyListeners();
  }

  void createClimate(ClimateControl newClimate) {
    // add Climate to local List
    climates.add(newClimate);
    // add Climate to Firebase
    http.post("$baseUrl/climates/${newClimate.getID}.json?auth=$token",
        body: "${newClimate.getJson(false)}",
        headers: {
          "Content-Tpye": "application/json",
        }).then(
      (value) => {
        print(value.statusCode),
      },
    );
    notifyListeners();
  }

  void setActiveClimate(ClimateControl climate) {
    activeClimate = climate;
    activeClimate.growPhase.phase = GROWPHASEVEGETATION;
    http.post("$baseUrl/activeClimate.json?auth=$token",
        body: "${climate.getJson(true)}",
        headers: {
          "Content-Tpye": "application/json",
        }).then(
      (value) => {
        print(value.statusCode),
      },
    );
    notifyListeners();
  }

  void deleteClimate(ClimateControl climate) {
    // Remove Climate locally
    climates.remove(climate);
    // Remove Climate in firebase
    http
        .delete(
          "$baseUrl/climates/${climate.getID}.json?auth=$token",
        )
        .then(
          (value) => {
            print(value.statusCode),
          },
        );
    notifyListeners();
  }

  void activeClimateChangePhase(String phase) {
    activeClimate.growPhase.phase = phase;

    http.put("$baseUrl/activeClimate/growPhase/phase.json?auth=$token",
        body: "phase:$phase",
        headers: {
          "Content-Tpye": "application/json",
        }).then(
      (value) => {
        print(value.statusCode),
      },
    );
    notifyListeners();
  }
}
