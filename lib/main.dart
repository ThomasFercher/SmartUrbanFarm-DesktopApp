import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/home.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/styles.dart' as s;

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<DashboardProvider>(
              lazy: false,
              create: (_) => DashboardProvider(selectedChild: s.DashboardRoute),
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
      home: Home(),
    );
  }
}
