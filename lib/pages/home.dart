import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/sider.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        children: [
          Sider(),
          Expanded(
            child: Consumer<DashboardProvider>(builder: (context, d, child) {
              return d.selectedChild;
            }),
          )
        ],
      ),
    );
  }
}
