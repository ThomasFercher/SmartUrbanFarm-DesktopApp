import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/climate/right/verticalListTile.dart';

import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/climateControl.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/objects/popupMenuOption.dart';
import 'package:suf_linux/pages/editEnvironment.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

import '../../../styles.dart';
import '../../general/popupMenu.dart';

class ClimateControlItem extends StatelessWidget {
  final ClimateControl settings;
  final double height;
  ClimateControlItem({@required this.settings, this.height});

  List<PopupMenuOption> options = [
    PopupMenuOption(
      "Set Active",
      Icon(
        Icons.check,
        color: primaryColor,
      ),
    ),
    PopupMenuOption(
      "Edit",
      Icon(
        Icons.edit,
        color: primaryColor,
      ),
    ),
    PopupMenuOption(
      "Delete",
      Icon(
        Icons.delete,
        color: Colors.redAccent,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      width: MediaQuery.of(context).size.width - 8,
      margin: EdgeInsets.all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          print(constraints.maxHeight);

          var w = constraints.maxWidth - 1 * borderRadius;

          return Card(
            elevation: cardElavation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            color: theme.cardColor,
            child: Container(
              height: height,
              width: w,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15),
                            child: SectionTitle(
                              title: settings.name,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        PopupMenu(
                          color: Colors.white,
                          options: options,
                          onSelected: (val) {
                            switch (val) {
                              case 'Set Active':
                                Provider.of<DashboardProvider>(context,
                                        listen: false)
                                    .setActiveClimate(settings);
                                break;
                              case 'Edit':
                                Provider.of<DashboardProvider>(context,
                                        listen: false)
                                    .setSelectedChild(
                                  PageOption(
                                    title: "Edit Environemnt",
                                    icon: Icons.ac_unit,
                                    widget: EditEnvironment(
                                        initialSettings: settings,
                                        create: false),
                                  ),
                                );
                                break;
                              case 'Delete':
                                Provider.of<DashboardProvider>(context,
                                        listen: false)
                                    .deleteClimate(settings);
                                break;
                              default:
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height - 60,
                    padding: EdgeInsets.symmetric(
                      horizontal: borderRadius,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SectionTitle(
                            title: "Grow Phases",
                            fontSize: 20,
                            color: theme.headlineColor,
                          ),
                          padding: EdgeInsets.only(bottom: 8),
                        ),
                        Expanded(
                          child: Container(
                            width: w,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return GridView.count(
                                primary: false,
                                crossAxisCount: 3,
                                childAspectRatio:
                                    (w / 3) / (constraints.maxHeight),
                                padding: EdgeInsets.all(0),
                                crossAxisSpacing: borderRadius / 2,
                                children: [
                                  VerticalListTile(
                                    title: "Vegetation",
                                    color: Colors.deepPurple,
                                    humidity: settings.growPhase.vegation_hum,
                                    temperature:
                                        settings.growPhase.vegation_temp,
                                    suntime:
                                        settings.growPhase.vegation_suntime,
                                  ),
                                  VerticalListTile(
                                    title: "Early Flower",
                                    color: Colors.green,
                                    humidity: settings.growPhase.flower_hum,
                                    temperature: settings.growPhase.flower_temp,
                                    suntime: settings.growPhase.flower_suntime,
                                  ),
                                  VerticalListTile(
                                    title: "Late Flower",
                                    color: Colors.amber,
                                    humidity: settings.growPhase.lateflower_hum,
                                    temperature:
                                        settings.growPhase.lateflower_temp,
                                    suntime:
                                        settings.growPhase.lateflower_suntime,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          alignment: Alignment.centerLeft,
                          child: SectionTitle(
                            title: "Irrigation",
                            fontSize: 20,
                            color: theme.headlineColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              settings.automaticWatering
                                  ? Chip(
                                      label: Container(
                                        height: 34,
                                        alignment: Alignment.center,
                                        child: SectionTitle(
                                          fontSize: 14,
                                          title: "Automatic",
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: primaryColor,
                                      avatar: Icon(
                                        Icons.tune,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Chip(
                                      label: Container(
                                        height: 32,
                                        alignment: Alignment.center,
                                        child: SectionTitle(
                                          fontSize: 14,
                                          title: "Regulated",
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: theme.secondaryColor,
                                      avatar: Icon(
                                        Icons.tune,
                                        color: Colors.white,
                                      ),
                                    ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    settings.automaticWatering
                                        ? "${settings.soilMoisture}%"
                                        : "${settings.waterConsumption}l/d",
                                    style: TextStyle(
                                      color: theme.textColor,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 28.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
