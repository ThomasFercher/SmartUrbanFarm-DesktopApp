import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

import '../styles.dart';

class Settings extends StatelessWidget {
  List<Widget> getSettings(SettingsProvider pr, context) {
    AppTheme theme = pr.getTheme();
    List<AppTheme> themes = pr.themes;

    return [
      Container(
        height: 40,
        child: SwitchListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          secondary: LeadingIcon(icon: Icons.camera_alt),
          value: pr.settings.automaticTimeLapse,
          inactiveTrackColor: theme.contrast,
          activeColor: theme.primaryColor,
          title: Text(
            "Take daily picture",
            style: GoogleFonts.nunito(
              color: theme.headlineColor,
              fontSize: 14,
            ),
          ),
          subtitle: new Text(
            "A timelapse will be created",
            style: GoogleFonts.nunito(
              color: theme.headlineColor,
              fontSize: 12,
            ),
          ),
          onChanged: (value) => pr.setAutomaticTimeLapse(value),
        ),
      ),
      Container(
        height: 40,
        child: SwitchListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          secondary: LeadingIcon(icon: Icons.notifications),
          value: pr.settings.notifications,
          inactiveTrackColor: theme.contrast,
          activeColor: theme.primaryColor,
          title: Text(
            "Notifications",
            style: GoogleFonts.nunito(
              color: theme.headlineColor,
              fontSize: 14,
            ),
          ),
          subtitle: new Text(
            "Enable or Disable Notifications",
            style: GoogleFonts.nunito(
              color: theme.headlineColor,
              fontSize: 12,
            ),
          ),
          onChanged: (value) => pr.setNotifications(value),
        ),
      ),
      Container(
        height: 40,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          leading: LeadingIcon(
            icon: Icons.info,
          ),
          title: Text(
            "More Information",
            style: GoogleFonts.nunito(
              color: theme.headlineColor,
              fontSize: 14,
            ),
          ),
          subtitle: new Text(
            "Information about licenses and version number",
            style: GoogleFonts.nunito(
              color: theme.headlineColor,
              fontSize: 12,
            ),
          ),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationIcon: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.only(bottom: 5, right: 5),
                child: SvgPicture.asset(
                  "assets/leaf.svg",
                  color: Colors.green,
                ),
              ),
              applicationLegalese: "",
              applicationVersion: "0.4.4",
              useRootNavigator: true,
              applicationName: "SGS",
            );
          },
        ),
      ),
      Container(
        height: 40,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          leading: LeadingIcon(icon: Icons.colorize),
          title: Container(
            height: 40,
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Color Theme",
              style: GoogleFonts.nunito(
                color: theme.headlineColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 4, left: 0, bottom: 4),
          child: Row(
            children: [
              Expanded(
                child: ThemeCard(
                  background: themes[0].background,
                  cardColor: themes[0].cardColor,
                  onSelected: () => {pr.setTheme(0)},
                  selected: pr.getSelected(0),
                  appTheme: themes[0],
                ),
              ),
              Expanded(
                child: ThemeCard(
                  background: themes[1].background,
                  cardColor: themes[1].cardColor,
                  onSelected: () => {pr.setTheme(1)},
                  selected: pr.getSelected(1),
                  appTheme: themes[1],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Consumer<SettingsProvider>(builder: (context, settings, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 4),
        color: theme.background,
        child: Column(
          children: getSettings(settings, context),
        ),
      );
    });
  }
}

class ThemeCard extends StatelessWidget {
  final Color background;
  final bool selected;
  final Function onSelected;
  final Color cardColor;
  final AppTheme appTheme;

  ThemeCard({
    this.background,
    this.selected,
    this.onSelected,
    this.cardColor,
    this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var w = constraints.maxWidth;
      var h = constraints.maxHeight - 6 * borderRadius;
      print(h);
      return GestureDetector(
        onTap: onSelected,
        child: Container(
          height: constraints.maxHeight + 8,
          child: Card(
            color:
                appTheme.name == "light" ? Colors.grey[50] : Colors.grey[800],
            elevation: selected ? 3 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: w,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(borderRadius),
                            topLeft: Radius.circular(borderRadius),
                          ),
                        ),
                        width: w / 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Card(
                              margin: EdgeInsets.all(0),
                              color: cardColor,
                              elevation: 1,
                              child: Container(
                                width: w / 7,
                                height: w / 7,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(w / 7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(borderRadius / 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: cardColor,
                                    elevation: 1,
                                    child: Container(
                                      width: w / 5,
                                      height: h / 5,
                                    ),
                                  ),
                                  Card(
                                    color: cardColor,
                                    elevation: 1,
                                    child: Container(
                                      width: w / 5,
                                      height: h / 5,
                                    ),
                                  ),
                                  Card(
                                    color: cardColor,
                                    elevation: 1,
                                    child: Container(
                                      width: w / 5,
                                      height: h / 5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(borderRadius),
                              child: Card(
                                color: cardColor,
                                elevation: 1,
                                child: Container(
                                  width: w,
                                  height: h / 5,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(borderRadius),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: cardColor,
                                    elevation: 1,
                                    child: Container(
                                      width: 2 * w / 5,
                                      height: 2 * h / 5,
                                    ),
                                  ),
                                  Card(
                                    color: cardColor,
                                    elevation: 1,
                                    child: Container(
                                      width: w / 5,
                                      height: 2 * h / 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                selected
                    ? Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.all(5),
                        child: Icon(
                          Icons.check,
                          color: primaryColor,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class LeadingIcon extends StatelessWidget {
  final IconData icon;

  const LeadingIcon({Key key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.contrast,
      ),
      child: Icon(
        icon,
        size: 20,
        color: theme.primaryColor,
      ),
    );
  }
}
