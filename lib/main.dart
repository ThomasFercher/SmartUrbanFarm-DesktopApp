import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/home.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/storageProvider.dart';
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
          ],
          child: SufLinuxApplication(),
        ),
      ),
    };

class SufLinuxApplication extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
              child: FlareActor(
                'assets/flares/splashscreen.flr',
                alignment: Alignment.center,
                animation: "Loading",
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
    Stopwatch stopwatch = new Stopwatch()..start();
    await Provider.of<DashboardProvider>(context, listen: false).fetchData();
    await Provider.of<StorageProvider>(context, listen: false).loadFlares();

    //add a delay so the animation plays through
    stopwatch.stop();
    return Future.delayed(
      Duration(milliseconds: 3000 - stopwatch.elapsedMilliseconds),
    );
  }
}
