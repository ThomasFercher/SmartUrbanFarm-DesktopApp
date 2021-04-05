import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suf_linux/objects/climateControl.dart';
import 'package:suf_linux/objects/growPhase.dart';
import 'package:suf_linux/objects/liveData.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:http/http.dart';
import 'package:suf_linux/services.dart/auth.dart';
import '../styles.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final baseUrl = "https://smartgrowsystem-sgs.firebaseio.com";
  PageOption selectedChild;
  LiveData liveData;
  ClimateControl activeClimate;
  List<ClimateControl> climates;
  SplayTreeMap<DateTime, double> temperatures = new SplayTreeMap();
  SplayTreeMap<DateTime, double> humiditys = new SplayTreeMap();
  SplayTreeMap<DateTime, double> soilMoistures = new SplayTreeMap();

  DataProvider({this.selectedChild});

  Future<void> fetchData() async {
    liveData = await getLiveData();
    activeClimate = await getActiveClimate();
    climates = await getClimates();
    temperatures = await loadList("temperatures");
    humiditys = await loadList("humiditys");
    soilMoistures = await loadList("humiditys");
    notifyListeners();
  }

  Future<ClimateControl> getActiveClimate() async {
    ClimateControl activeClimate = new ClimateControl(
      name: "",
      soilMoisture: 0.0,
      waterConsumption: 0.0,
      automaticWatering: false,
      growPhase: GrowPhase(),
    );

    return await http.get(
      "$baseUrl/activeClimate.json?auth=${Auth.token}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            Map<dynamic, dynamic> json = jsonDecode(response.body);
            activeClimate = ClimateControl.fromJson(json, true);
            print("Active Climate was loaded: ${activeClimate.getName}");
            return activeClimate;
          case 400:
            print("Active Climate couldnt be loaded");
            return activeClimate;
          default:
            return activeClimate;
        }
      },
    );
  }

  Future<List<ClimateControl>> getClimates() async {
    List<ClimateControl> climates = [];
    return await http.get(
      "$baseUrl/climates.json?auth=${Auth.token}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            Map<dynamic, dynamic> json = jsonDecode(response.body);
            json.forEach((key, value) {
              if (key != activeClimate.id)
                climates.add(ClimateControl.fromJson(value, false));
            });
            print("Climates loaded. Total: ${climates.length}");
            return climates;
          case 400:
            print("Climates couldnt be loaded");
            return climates;
          default:
            return climates;
        }
      },
    );
  }

  Future<LiveData> getLiveData() async {
    LiveData liveData = new LiveData(
      temperature: 0.0,
      humidity: 0.0,
      soilMoisture: 0.0,
      growProgress: 0.0,
      waterTankLevel: 0.0,
    );
    return await http.get(
      "$baseUrl/liveClimate.json?auth=${Auth.token}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            Map<dynamic, dynamic> json = jsonDecode(response.body);
            liveData = LiveData.fromJson(json);
            print("Live Data was loaded");
            return liveData;
          case 400:
            print("Live Data couldnt be loaded");
            return liveData;
          default:
            return liveData;
        }
      },
    );
  }

  /// This Method loads the given [child] List from
  /// the Firebase
  Future<SplayTreeMap<DateTime, double>> loadList(String child) async {
    SplayTreeMap<DateTime, double> list = new SplayTreeMap();
    return await http.get(
      "$baseUrl/$child.json?auth=${Auth.token}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            Map<dynamic, dynamic> json = jsonDecode(response.body);
            json.forEach((key, value) {
              list[DateTime.parse(key)] = value * 1.0;
            });
            print("$child loaded");
            return list;
          case 400:
            print("$child couldnt be loaded");
            return list;
          default:
            return list;
        }
      },
    );
  }

  void setSelectedChild(PageOption s) {
    selectedChild = s;
    notifyListeners();
  }

  void editClimate(ClimateControl initial, ClimateControl newClimate) {
    bool isActive = false;
    if (initial.id == activeClimate.id) {
      setActiveClimate(newClimate);
      isActive = true;
    }
    ClimateControl clim =
        climates.singleWhere((clim) => initial.getID == clim.getID);
    climates[climates.indexOf(clim)] = newClimate;
    http.put(
      "$baseUrl/climates/${initial.getID}.json?auth=${Auth.token}",
      body: "${newClimate.getJson(isActive)}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            print("${newClimate.name} ${initial.id} was updated");
            return;
          case 412:
            print("${initial.name} ${initial.id} couldnt be updated");
            return;
          default:
            return;
        }
      },
    );
    notifyListeners();
  }

  void createClimate(ClimateControl newClimate) {
    climates.add(newClimate);
    http.post(
      "$baseUrl/climates/${newClimate.getID}.json?auth=${Auth.token}",
      body: "${newClimate.getJson(false)}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            print("${newClimate.name} ${newClimate.id} was created");
            return;
          case 412:
            print("${newClimate.name} ${newClimate.id} couldnt be created");
            return;
          default:
            return;
        }
      },
    );
    notifyListeners();
  }

  void setActiveClimate(ClimateControl climate) {
    activeClimate = climate;
    activeClimate.growPhase.phase = GROWPHASEVEGETATION;
    http.post(
      "$baseUrl/activeClimate.json?auth=${Auth.token}",
      body: "${climate.getJson(true)}",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            print("${climate.name} ${climate.id} is active now");
            return;
          case 412:
            print("${climate.name} ${climate.id} couldnt be set active");
            return;
          default:
            return;
        }
      },
    );
    notifyListeners();
  }

  void deleteClimate(ClimateControl climate) {
    climates.remove(climate);
    http
        .delete("$baseUrl/climates/${climate.getID}.json?auth=${Auth.token}")
        .then(
      (response) {
        switch (response.statusCode) {
          case 200:
            print("${climate.name} ${climate.id} was deleted");
            return;
          case 412:
            print("${climate.name} ${climate.id} couldnt be deleted");
            return;
          default:
            return;
        }
      },
    );
    notifyListeners();
  }

  void changePhase(String phase) {
    activeClimate.growPhase.phase = phase;
    http.put(
      "$baseUrl/activeClimate/growPhase/phase.json?auth=${Auth.token}",
      body: "phase:$phase",
      headers: {
        "Content-Tpye": "application/json",
      },
    ).then(
      (response) {
        switch (response.statusCode) {
          case 200:
            print("$phase is active now");
            return;
          case 412:
            print("$phase couldnt be activated");
            return;
          default:
            return;
        }
      },
    );
    notifyListeners();
  }

  void setPhoto(bool photo) {
    http
        .put(
      "$baseUrl/photo.json?auth=${Auth.token}",
      body: photo,
    )
        .then(
      (response) {
        switch (response.statusCode) {
          case 200:
            print("Photo is set");
            return;
          case 412:
            print("Phase couldnt be set");
            return;
          default:
            return;
        }
      },
    );
    notifyListeners();
  }
}
