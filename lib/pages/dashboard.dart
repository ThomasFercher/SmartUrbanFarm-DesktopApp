import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/carddata.dart';
import 'package:suf_linux/customwidgets/dayRange.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/customwidgets/growProgress.dart';
import 'package:suf_linux/customwidgets/waterTankLevel.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    // TODO: implement build
    return Consumer<DashboardProvider>(builder: (context, d, c) {
      var temp = d.liveData.temperature;
      var hum = d.liveData.humidity;
      var soilM = d.liveData.soilMoisture;
      var waterTankLevel = d.liveData.waterTankLevel;
      var growProgress = d.liveData.growProgress;
      var suntime = d.activeClimate.suntime;

      var height = MediaQuery.of(context).size.height - 20;
      var width = MediaQuery.of(context).size.width - 220;

      return Container(
        width: MediaQuery.of(context).size.width - 200,
        height: height + 20,
        color: theme.background,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "Details"),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 3,
              crossAxisSpacing: 10,
              children: [
                CardData(
                  icon: Icons.ac_unit,
                  text: '$temp°C',
                  label: 'Temperature',
                  iconColor: primaryColor,
                ),
                CardData(
                  icon: Icons.ac_unit,
                  text: '$hum%',
                  label: 'Humidity',
                  iconColor: primaryColor,
                ),
                CardData(
                  icon: Icons.ac_unit,
                  text: '$soilM%',
                  label: 'Soil Moisture',
                  iconColor: primaryColor,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            SectionTitle(title: "Suntime"),
            DayRange(
              suntime: suntime,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              children: [
                Expanded(
                  child: SectionTitle(title: "Grow Progress"),
                ),
                Expanded(
                  child: SectionTitle(title: "Watertank"),
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GrowProgress(
                      progress: growProgress,
                    ),
                  ),
                  Expanded(
                    child: WaterTankLevel(
                      fullness: waterTankLevel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
