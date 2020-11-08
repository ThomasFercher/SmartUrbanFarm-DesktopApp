import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/carddata.dart';
import 'package:suf_linux/customwidgets/dayRange.dart';
import 'package:suf_linux/customwidgets/growProgress.dart';
import 'package:suf_linux/customwidgets/waterTankLevel.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/styles.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DashboardProvider>(builder: (context, d, c) {
      var temp = d.temperature;
      var hum = d.humidity;
      var soilM = d.soilMoisture;
      var waterTankLevel = d.waterTankLevel;
      var growProgress = d.growProgress;
      var suntime = d.suntime;

      var height = MediaQuery.of(context).size.height - 20;
      var width = MediaQuery.of(context).size.width - 220;
      print(width);

      return Container(
        width: MediaQuery.of(context).size.width - 200,
        height: height + 20,
        color: Colors.grey[100],
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(text: "Details"),
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
            SectionHeading(text: "Suntime"),
            DayRange(
              suntime: suntime,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              children: [
                Expanded(
                  child: SectionHeading(text: "Grow Progress"),
                ),
                Expanded(
                  child: SectionHeading(text: "Watertank"),
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

class SectionHeading extends StatelessWidget {
  final String text;

  const SectionHeading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 2),
      child: Text(
        text,
        style: heading2,
      ),
    );
  }
}
