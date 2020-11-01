import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/styles.dart';

class Sider extends StatelessWidget {
  List<PageOption> pageOptions = [
    new PageOption(
      widget: Dashboard(),
      icon: Icons.dashboard,
      title: "Dashboard",
    ),
    new PageOption(
      widget: Settings(),
      icon: Icons.settings,
      title: "Settings",
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 200,
      height: MediaQuery.of(context).size.height,
      color: primaryColor,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            child: Text(
              "Smart Urban Farm",
              style: heading,
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return PageTile(
                option: pageOptions[index],
              );
            },
          )
        ],
      ),
    );
  }
}

class PageTile extends StatelessWidget {
  final PageOption option;

  const PageTile({Key key, this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(option.icon),
      title: Text(option.title),
      onTap: () {
        Provider.of<DashboardProvider>(context).setSelectedChild(option.widget);
      },
    );
  }
}

class PageOption {
  final Widget widget;
  final IconData icon;
  final String title;

  PageOption({this.widget, this.icon, this.title});
}
