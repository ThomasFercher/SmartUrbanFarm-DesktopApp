import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';

class Advanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 60,
      color: Colors.red,
      child: Consumer<DashboardProvider>(
        builder: (context, value, child) {
          return Container();
        },
      ),
    );
  }
}
