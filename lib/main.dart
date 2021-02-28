import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/home.dart';
import 'package:suf_linux/services.dart/auth.dart';
import 'package:suf_linux/providers/dataProvider.dart';
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
            ChangeNotifierProvider<DataProvider>(
              lazy: false,
              create: (_) => DataProvider(selectedChild: s.DashboardRoute),
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

class SufLinuxApplication extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _SufLinuxApplicationState createState() => _SufLinuxApplicationState();
}

class _SufLinuxApplicationState extends State<SufLinuxApplication> {
  RiveAnimationController grow;
  RiveAnimationController wind;

  Artboard splashscreen;
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/flares/splashscreen.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          final artboard = file.mainArtboard;
          grow = SimpleAnimation('Growing');
          wind = SimpleAnimation('Wind');
          artboard.addController(grow);
          artboard.addController(wind);
          //  artboard.addController(wind);
          setState(() => splashscreen = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suf Linux Application',
      theme: s.themeData,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              projectSnap.hasData == null ||
              projectSnap.connectionState == ConnectionState.waiting) {
            // Splashscreen using a Flare2d as a loading Animation
            return Container(
              color: Colors.transparent,
              child: Center(
                child: splashscreen == null
                    ? const SizedBox()
                    : Rive(
                        artboard: splashscreen,
                      ),
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
    // Get Auth Token
    await Auth.initAuth();
    // Init VPD Class
    await VPD.loadJson(context);

    // Load Everything else
    await Provider.of<DataProvider>(context, listen: false).fetchData();
    await Provider.of<StorageProvider>(context, listen: false).loadFlares();
    await Provider.of<StorageProvider>(context, listen: false)
        .loadImages(context);
    await Provider.of<SettingsProvider>(context, listen: false).loadSettings();
  }
}
