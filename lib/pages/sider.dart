import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/sider/colorFadeIcon.dart';
import 'package:suf_linux/customwidgets/sider/pageTile.dart';
import 'package:suf_linux/customwidgets/dashboard/waterTankLevel.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/advanced.dart';
import 'package:suf_linux/pages/environment.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/environment.dart';
import 'package:suf_linux/pages/environment.dart';
import 'package:suf_linux/pages/gallery.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:suf_linux/providers/dataProvider.dart';
import 'package:suf_linux/styles.dart';

import '../customwidgets/sider/colorFadeText.dart';

class Sider extends StatefulWidget {
  final List<PageOption> pageOptions = [
    PageOption(
      widget: Dashboard(),
      icon: Icons.dashboard,
      title: "Dashboard",
    ),
    PageOption(
      widget: Gallery(),
      icon: Icons.photo,
      title: "Gallery",
    ),
    PageOption(
      widget: Environment(),
      icon: Icons.settings_applications,
      title: "Environment",
    ),
    PageOption(
      widget: Advanced(),
      icon: Icons.data_usage,
      title: "Advanced ",
    ),
    PageOption(
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
      width: 136,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 3.0),
          BoxShadow(color: Colors.white10, offset: Offset(0, -8)),
          BoxShadow(color: Colors.white10, offset: Offset(0, 8)),
          BoxShadow(color: Colors.white10, offset: Offset(-8, -8)),
          BoxShadow(color: Colors.white10, offset: Offset(-8, 8)),
        ],
        color: primaryColor,
      ),
      child: Column(
        children: [
          Container(
            
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,left: 4,right: 4),
              child: Image.asset(
                'assets/images/logo.png',
                alignment: Alignment.center,
                fit: BoxFit.contain,

                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: height - 120,
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              itemExtent: (height - 120) / widget.pageOptions.length,
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
