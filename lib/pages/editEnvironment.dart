import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/climate/edit/editIrrigation.dart';
import 'package:suf_linux/customwidgets/climate/edit/growthPhase.dart';
import 'package:suf_linux/customwidgets/climate/edit/input.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/climateControl.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/providers/climateControlProvider.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

import 'environment.dart';

class EditEnvironment extends StatefulWidget {
  ClimateControl initialSettings;
  bool create;

  EditEnvironment({@required this.initialSettings, @required this.create});

  @override
  _EditEnvironmentState createState() => _EditEnvironmentState();
}

class _EditEnvironmentState extends State<EditEnvironment> {
  @override
  void initState() {
    super.initState();
  }

  save(ClimateControl settings, context) {
    print(settings);
    widget.create
        ? Provider.of<DashboardProvider>(context, listen: false)
            .createClimate(settings)
        : Provider.of<DashboardProvider>(context, listen: false)
            .editClimate(this.widget.initialSettings, settings);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.initialSettings.name;

    return ListenableProvider(
      create: (_) => ClimateControlProvider(widget.initialSettings),
      builder: (context, child) {
        AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
        //   EnvironmentSettings settings = d.getSettings();
        var width = MediaQuery.of(context).size.width;
        return Consumer<ClimateControlProvider>(builder: (context, pr, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: width,
            color: theme.background,
            child: Row(
              children: [
                Expanded(
                  child: GrowthPhase(),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Input(
                        theme: theme,
                        initialValue: widget.initialSettings.name,
                        valChanged: (v) => pr.changeName(v),
                      ),
                      EditIrrigation(
                        pr: pr,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(borderRadius),
                              ),
                            ),
                            color: theme.cardColor,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: width / 2,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: RaisedButton(
                                        onPressed: () =>
                                            save(pr.getSettings(), context),
                                        color: theme.primaryColor,
                                        textColor: Colors.white,
                                        child: Text(
                                          widget.create ? "Create" : "Save",
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width / 2,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: RaisedButton(
                                        onPressed: () =>
                                            Provider.of<DashboardProvider>(
                                                    context,
                                                    listen: false)
                                                .setSelectedChild(
                                          PageOption(
                                            widget: Environment(),
                                            icon: Icons.settings_applications,
                                            title: "Environment",
                                          ),
                                        ),
                                        color: Colors.redAccent,
                                        textColor: Colors.white,
                                        child: Text(
                                          "Cancel",
                                          style: GoogleFonts.nunito(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class PlaceDivider extends StatelessWidget {
  double height;

  PlaceDivider({height}) : height = height ?? 8.0;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    return Container(
      color: Colors.green[50],
      height: height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
