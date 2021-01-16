import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/advanced.dart/datachart.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

class Advanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: theme.background,
      child: Consumer<DashboardProvider>(
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.only(
              left: 18,
              top: 8,
              bottom: 8,
              right: 6,
            ),
            child: CarouselSlider(
              items: [
                Container(
                  height: MediaQuery.of(context).size.height - 16,
                  child: DataChart(
                    data: value.temperatures,
                    gradientColors: [theme.primaryColor, Color(0xFF81C784)],
                    unit: "°C",
                    title: "Temperatures",
                    icon: Icons.dashboard,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 16,
                  child: DataChart(
                    data: value.humiditys,
                    gradientColors: [theme.secondaryColor, Color(0xFF9575CD)],
                    unit: "%",
                    title: "Humidities",
                    icon: Icons.ramen_dining,
                  ),
                )
              ],
              options: CarouselOptions(
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height,
                enableInfiniteScroll: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
