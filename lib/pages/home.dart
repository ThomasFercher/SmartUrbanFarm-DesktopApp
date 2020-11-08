import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/sider.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/styles.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(MediaQuery.of(context).size.width);
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Sider(),
            Expanded(
              child: Consumer<DashboardProvider>(builder: (context, d, child) {
                return Column(
                  children: [
                    Container(
                      child: d.selectedChild.widget,
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
