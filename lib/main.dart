import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/home.dart';
import 'package:suf_linux/providers/auth.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/providers/storageProvider.dart';
import 'package:suf_linux/services.dart/fileservice.dart';
import 'package:suf_linux/services.dart/vpd.dart';
import 'package:suf_linux/styles.dart' as s;

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      FlareCache.doesPrune = false,
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<DashboardProvider>(
              lazy: false,
              create: (_) => DashboardProvider(selectedChild: s.DashboardRoute),
            ),
            ChangeNotifierProvider<StorageProvider>(
              lazy: false,
              create: (_) => StorageProvider(),
            ),
            ChangeNotifierProvider<SettingsProvider>(
              lazy: false,
              create: (_) => SettingsProvider(),
            ),
          ],
          child: SufLinuxApplication(),
        ),
      ),
    };

class SufLinuxApplication extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    FlareControls flrctrl = new FlareControls();
    return MaterialApp(
      title: 'Suf Linux Application',
      theme: s.themeData,
      home: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              projectSnap.hasData == null ||
              projectSnap.connectionState == ConnectionState.waiting) {
            // Splashscreen using a Flare2d as a loading Animation
            return Container(
              color: s.primaryColor,
              child: FlareActor(
                'assets/flares/splashscreen.flr',
                alignment: Alignment.center,
                animation: "Loading",
                controller: flrctrl,
                callback: (s) {
                  flrctrl.play("Wind");
                },
              ),
            );
          } else {
            // Once loaded the main page will be displayed
            return Home();
          }
        },
        future: loadData(context),
      ),
    );
  }

  Future<void> loadData(context) async {
    FileService s = new FileService();
    await Auth.initAuth();

    // Init VPD Class
    await VPD().loadJson(context);
    Stopwatch stopwatch = new Stopwatch()..start();

    await Provider.of<DashboardProvider>(context, listen: false).fetchData();
    await Provider.of<StorageProvider>(context, listen: false).loadFlares();
    await Provider.of<StorageProvider>(context, listen: false)
        .loadImages(context);
    await Provider.of<SettingsProvider>(context, listen: false).loadSettings();
    //add a delay so the animation plays through
    stopwatch.stop();
    return Future.delayed(
      Duration(milliseconds: 3000 - stopwatch.elapsedMilliseconds),
    );
  }
}
