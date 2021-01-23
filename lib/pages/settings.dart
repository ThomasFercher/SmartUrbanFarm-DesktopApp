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
      Padding(
        padding: EdgeInsets.only(top: 20),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        secondary: LeadingIcon(icon: Icons.camera_alt),
        value: pr.settings.automaticTimeLapse,
        inactiveTrackColor: theme.contrast,
        activeColor: theme.primaryColor,
        title: Text(
          "Take daily picture",
          style: GoogleFonts.nunito(
            color: theme.headlineColor,
          ),
        ),
        subtitle: new Text(
          "A timelapse will be created",
          style: GoogleFonts.nunito(
            color: theme.headlineColor,
          ),
        ),
        onChanged: (value) => pr.setAutomaticTimeLapse(value),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        secondary: LeadingIcon(icon: Icons.notifications),
        value: pr.settings.notifications,
        inactiveTrackColor: theme.contrast,
        activeColor: theme.primaryColor,
        title: Text(
          "Notifications",
          style: GoogleFonts.nunito(
            color: theme.headlineColor,
          ),
        ),
        subtitle: new Text(
          "Enable or Disable Notifications",
          style: GoogleFonts.nunito(
            color: theme.headlineColor,
          ),
        ),
        onChanged: (value) => pr.setNotifications(value),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: LeadingIcon(icon: Icons.info),
        title: Text(
          "More Information",
          style: GoogleFonts.nunito(
            color: theme.headlineColor,
          ),
        ),
        subtitle: new Text(
          "Information about licenses and version number",
          style: GoogleFonts.nunito(
            color: theme.headlineColor,
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
      Container(
        child: Column(children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            leading: LeadingIcon(icon: Icons.colorize),
            title: Text(
              "Select Color Theme",
              style: GoogleFonts.nunito(
                color: theme.headlineColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 8, left: 48),
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
                  /*   ThemeCard(
                    gradient: themes[1].background,
                    cardColor: themes[1].cardColor,
                    onSelected: () => {pr.setTheme(1)},
                    selected: pr.getSelected(1),
                    appTheme: themes[1],
                  ),*/
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
        ]),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Consumer<SettingsProvider>(builder: (context, settings, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: theme.background,
        child: ListView(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: (w / 5 - w / 7) / 2, vertical: 8),
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
                              padding: EdgeInsets.all(borderRadius),
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
        borderRadius: BorderRadius.circular(23),
        color: theme.contrast,
      ),
      child: Icon(
        icon,
        size: 25,
        color: theme.primaryColor,
      ),
    );
  }
}
