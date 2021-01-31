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
import 'package:suf_linux/pages/environment.dart';
import 'package:suf_linux/pages/environment.dart';
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
      title: "Environment",
    ),
    new PageOption(
      widget: Advanced(),
      icon: Icons.data_usage,
      title: "Advanced ",
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
  List<PageOption> pageOptions;

  @override
  void initState() {
    super.initState();
    selected = 0;
    pageOptions = widget.pageOptions;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: 160,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 4.0),
          BoxShadow(color: Colors.white10, offset: Offset(0, -16)),
          BoxShadow(color: Colors.white10, offset: Offset(0, 16)),
          BoxShadow(color: Colors.white10, offset: Offset(-16, -16)),
          BoxShadow(color: Colors.white10, offset: Offset(-16, 16)),
        ],
        color: primaryColor,
      ),
      child: Column(
        children: [
          Container(
            height: 28,
            child: Text(
              "Smart Urban Farm",
              style: heading,
            ),
          ),
          Container(
            child: FlareActor(
              'assets/flares/logo.flr',
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
            ),
            height: 80,
          ),
          Container(
            height: height - 116,
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              itemExtent: (height - 116) / widget.pageOptions.length,
              padding: EdgeInsets.all(0),
              children: [
                PageTile(
                  option: widget.pageOptions[0],
                  onTap: () => setState(
                    () {
                      selected = 0;
                    },
                  ),
                  sel: 0 == selected,
                ),
                PageTile(
                  option: widget.pageOptions[1],
                  onTap: () => setState(
                    () {
                      selected = 1;
                    },
                  ),
                  sel: 1 == selected,
                ),
                PageTile(
                  option: widget.pageOptions[2],
                  onTap: () => setState(
                    () {
                      selected = 2;
                    },
                  ),
                  sel: 2 == selected,
                ),
                PageTile(
                  option: widget.pageOptions[3],
                  onTap: () => setState(
                    () {
                      selected = 3;
                    },
                  ),
                  sel: 3 == selected,
                ),
                PageTile(
                  option: widget.pageOptions[4],
                  onTap: () => setState(
                    () {
                      selected = 4;
                    },
                  ),
                  sel: 4 == selected,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getOptionTiles(List<PageOption> opt, int selected) {
    List<Widget> w = [];

    for (var index = 0; index < opt.length; index++) {
      w.add(
        PageTile(
          option: widget.pageOptions[index],
          onTap: () => setState(
            () {
              selected = index;
            },
          ),
          sel: index == selected,
        ),
      );
    }

    return w;
  }
}
