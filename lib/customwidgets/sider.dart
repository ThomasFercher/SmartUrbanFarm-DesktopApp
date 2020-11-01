import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/colorFadeIcon.dart';
import 'package:suf_linux/customwidgets/pageTile.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/styles.dart';

import 'colorFadeText.dart';

class Sider extends StatefulWidget {
  final List<PageOption> pageOptions = [
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
  _SiderState createState() => _SiderState();
}

class _SiderState extends State<Sider> {
  int selected;

  @override
  void initState() {
    super.initState();
    selected = 0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 200,
      height: 800,
      color: primaryColor,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 20),
            child: Text(
              "Smart Urban Farm",
              style: heading,
            ),
          ),
          ListView.builder(
            itemCount: widget.pageOptions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PageTile(
                option: widget.pageOptions[index],
                onTap: () => setState(() {
                  selected = index;
                }),
                sel: index == selected,
              );
            },
          )
        ],
      ),
    );
  }
}
