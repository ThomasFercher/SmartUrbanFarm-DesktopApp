import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/dashboard/carddata.dart';
import 'package:suf_linux/customwidgets/dashboard/dayRange.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/customwidgets/dashboard/growProgress.dart';
import 'package:suf_linux/customwidgets/dashboard/waterTankLevel.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/dataProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    // TODO: implement build
    return Consumer<DataProvider>(builder: (context, d, c) {
      var temp = d.liveData.temperature;
      var hum = d.liveData.humidity;
      var soilM = d.liveData.soilMoisture;
      var waterTankLevel = d.liveData.waterTankLevel;
      var growProgress = d.liveData.growProgress;
      var suntime = "06:00 - 18:00";

      var height = MediaQuery.of(context).size.height - 20;
      var width = MediaQuery.of(context).size.width - 160;

      return Container(
        width: width,
        height: height + 20,
        color: theme.background,
        padding: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: "Details",
            ),
            Container(
              height: 64,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                childAspectRatio: (width / 3) / 64,
                padding: EdgeInsets.all(0),
                children: [
                  CardData(
                    icon: WeatherIcons.wi_barometer,
                    text: '$temp°C',
                    label: 'Temperature',
                    iconColor: primaryColor,
                  ),
                  CardData(
                    icon: WeatherIcons.wi_humidity,
                    text: '$hum%',
                    label: 'Humidity',
                    iconColor: primaryColor,
                  ),
                  CardData(
                    icon: WeatherIcons.wi_barometer,
                    text: '$soilM%',
                    label: 'Soil Moisture',
                    iconColor: primaryColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
            ),
            SectionTitle(title: "Suntime"),
            DayRange(
              suntime: suntime,
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
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
