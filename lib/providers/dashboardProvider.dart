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
import '../styles.dart';
import 'package:http/http.dart' as http;

class DashboardProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final baseUrl = "https://smartgrowsystem-sgs.firebaseio.com";
  PageOption selectedChild;
  String token;

  LiveData liveData;
  ClimateControl activeClimate;

  DashboardProvider({@required this.selectedChild}) {
    fetchData();
  }

  /*Timer.periodic(Duration(seconds: 60), (timer) {
      print("aasd");
      // loadData();
    });*/

  void setSelectedChild(PageOption s) {
    selectedChild = s;
    notifyListeners();
  }

  Future<String> authApp() async {
    final response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAeTF-VH5vxA0-ssHg4rMcjIodzBnnPvPw");
    Map<dynamic, dynamic> user = jsonDecode(response.body);
    return user['idToken'];
  }

  Future<void> fetchData() async {
    token = await authApp();
    liveData = await getLiveData();
    activeClimate = await getActiveClimate();
    temperatures = await loadList("temperatures");
    humiditys = await loadList("humiditys");
    notifyListeners();
    print(waterTankLevel);
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

    return ClimateControl.fromJson(json);
  }

  Future<LiveData> getLiveData() async {
    final response = await http.get("$baseUrl/liveClimate.json?auth=$token");
    Map<dynamic, dynamic> json = jsonDecode(response.body);

    return LiveData.fromJson(json);
  }

  bool setting1 = false;
  bool setting2 = false;

  double temperature = 0.0;
  double tempSoll = 25;

  double humidity = 0.0;
  double humiditySoll = 50;

  double soilMoisture = 0.0;
  double soilMoistureSoll = 50;

  double waterTankLevel = 0.0;
  double growProgress = 0.0;

  String suntime = "02:30 - 18:00";

  SplayTreeMap<DateTime, double> temperatures = new SplayTreeMap();
  SplayTreeMap<DateTime, double> humiditys = new SplayTreeMap();
  // final ref = fb.reference();

  List<EnvironmentSettings> settings = [
    new EnvironmentSettings(
      name: "Custom",
      temperature: 50,
      humidity: 50,
      soilMoisture: 50,
      suntime: "02:30 - 18:00",
      waterConsumption: 1,
    ),
    new EnvironmentSettings(
      name: "Custom",
      temperature: 50,
      humidity: 50,
      soilMoisture: 50,
      suntime: "02:30 - 18:00",
      waterConsumption: 1,
    )
  ];

  SplayTreeMap<DateTime, double> getTemperatures() {
    return temperatures;
  }

  SplayTreeMap<DateTime, double> getHumiditys() {
    return humiditys;
  }

  void suntimeChanged(List<dynamic> suntime) {
    String time = "${suntime[0]} - ${suntime[1]}";
    this.suntime = time;
    //   fb.reference().child('suntime').set({'suntime': time}).then((_) {});
  }

  void tempSollChanged(double v) {
    v = num.parse(v.toStringAsFixed(1));
    tempSoll = v;
    //   fb.reference().child('temperatureSoll').set(tempSoll);
    notifyListeners();
  }

  void humiditySollChanged(double v) {
    v = num.parse(v.toStringAsFixed(1));
    humiditySoll = v;
    //   fb.reference().child('humiditySoll').set(humiditySoll);
    notifyListeners();
  }

  void soilMoistureSollChanged(double v) {
    v = num.parse(v.toStringAsFixed(1));
    soilMoistureSoll = v;
    //  fb.reference().child('soilMoistureSoll').set(soilMoistureSoll);
    notifyListeners();
  }

  /* Future<SplayTreeMap<DateTime, double>> loadTemperatures() async {
    SplayTreeMap<DateTime, double> temps;
    await ref
        .child("temperatures")
        .limitToLast(10)
        .once()
        .then((DataSnapshot data) {
      temps = sortData(data.value);
    });
    return temps;
  }*/

  /* Future<double> loadTemperature() async {
    double temp;
    await ref.child("temperature").once().then((DataSnapshot data) {
      temp = double.parse(data.value);
    });
    return temp;
  }

  Future<double> loadHumidity() async {
    double humidity;
    await ref.child("humidity").once().then((DataSnapshot data) {
      humidity = double.parse(data.value);
    });
    return humidity;
  }

  Future<double> loadSoilMoisture() async {
    double soilMoisture;
    await ref.child("soilMoisture").once().then((DataSnapshot data) {
      soilMoisture = double.parse(data.value);
    });
    return soilMoisture;
  }

  Future<String> loadSuntime() async {
    String suntime;
    await ref
        .child("suntime")
        .child("suntime")
        .once()
        .then((DataSnapshot data) {
      suntime = data.value;
    });
    return suntime;
  }
*/
  Future<SplayTreeMap<DateTime, double>> loadList(String child) async {
    SplayTreeMap<DateTime, double> list = new SplayTreeMap();
    final response = await http.get("$baseUrl/$child.json?auth=$token");
    Map<dynamic, dynamic> json = jsonDecode(response.body);
    json.forEach((key, value) {
      list[DateTime.parse(key)] = double.parse(value);
    });

    return list;
  }
  /*

  Future<void> loadData() async {
    temperature = await loadTemperature();
    humidity = await loadHumidity();
    soilMoisture = await loadSoilMoisture();
    suntime = await loadSuntime();
    temperatures = await loadTemperatures();
    humiditys = await loadHumiditys();

    notifyListeners();
  }

  void pressed() {
    alongPressed = !alongPressed;
    notifyListeners();
  }

  void editSettings(EnvironmentSettings initial, EnvironmentSettings e_s) {
    settings[settings.indexOf(initial)] = e_s;
    notifyListeners();
  }*/
}
