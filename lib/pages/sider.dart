import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/colorFadeIcon.dart';
import 'package:suf_linux/customwidgets/pageTile.dart';
import 'package:suf_linux/customwidgets/waterTankLevel.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/advanced.dart';
import 'package:suf_linux/pages/environment.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/gallery.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/styles.dart';

import '../customwidgets/colorFadeText.dart';

class Sider extends StatefulWidget {
  final List<PageOption> pageOptions = [
    new PageOption(
      widget: Dashboard(),
      icon: Icons.dashboard,
      title: "Dashboard",
    ),
    new PageOption(
      widget: Gallery(),
      icon: Icons.photo,
      title: "Gallery",
    ),
    new PageOption(
      widget: Environment(),
      icon: Icons.settings_applications,
      title: "Environment ",
    ),
    new PageOption(
      widget: Advanced(),
      icon: Icons.data_usage,
      title: "Advanced Data ",
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
    var height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Container(
      width: 200,
      height: MediaQuery.of(context).size.height,
      color: primaryColor,
      child: Column(
        children: [
          Container(
            height: 52,
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: Text(
              "Smart Urban Farm",
              style: heading,
            ),
          ),
          Container(
            child: FlareActor(
              'assets/flares/logo.flr',
              alignment: Alignment.center,
            ),
            height: 120,
          ),
          Container(
            height: height - 172,
            child: ListView.builder(
              itemCount: widget.pageOptions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == widget.pageOptions.length - 1) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: height - 172 - widget.pageOptions.length * 46 - 10,
                    ),
                    child: PageTile(
                      option: widget.pageOptions[index],
                      onTap: () => setState(
                        () {
                          selected = index;
                        },
                      ),
                      sel: index == selected,
                    ),
                  );
                } else {
                  return PageTile(
                    option: widget.pageOptions[index],
                    onTap: () => setState(
                      () {
                        selected = index;
                      },
                    ),
                    sel: index == selected,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
