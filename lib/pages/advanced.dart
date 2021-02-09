import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/advanced.dart/datachart.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/dataProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

class Advanced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: theme.background,
      child: Consumer<DataProvider>(
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: CarouselSlider(
              items: [
                Container(
                  height: MediaQuery.of(context).size.height - 8,
                  child: DataChart(
                    data: value.temperatures,
                    gradientColors: [theme.primaryColor, Color(0xFFA5D6A7)],
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 16,
                  child: DataChart(
                    data: value.humiditys,
                    gradientColors: [Colors.lime, Colors.lime[200]],
                    unit: "%",
                    title: "Soil Moisture",
                    icon: WeatherIcons.wi_barometer,
                  ),
                )
              ],
              options: CarouselOptions(
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height,
                enableInfiniteScroll: false,
                scrollDirection: Axis.vertical,
              ),
            ),
          );
        },
      ),
    );
  }
}
