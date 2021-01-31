import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/climate/edit/dayslider.dart';
import 'package:suf_linux/customwidgets/climate/edit/editVariable.dart';
import 'package:suf_linux/providers/climateControlProvider.dart';
import 'package:suf_linux/services.dart/vpd.dart';

import 'package:suf_linux/styles.dart';

class GrowthItem extends StatelessWidget {
  final String phase;
  final Color color;

  const GrowthItem({Key key, this.phase, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClimateControlProvider>(builder: (context, pr, child) {
      Tween temp =
          VPD.getMinMaxLowFromHum(pr.climateSettings.getHumidity(phase), phase);
      double minTemp = temp.begin;
      double maxTemp = temp.end;
      Tween hum = VPD.getMinMaxLowFromTemp(
          pr.climateSettings.getTemperature(phase), phase);
      double minHum = hum.begin;
      double maxHum = hum.end;

      String suntime = pr.climateSettings.getSuntime(phase);
      return LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: EditVariable(
                  value: pr.climateSettings.getTemperature(phase),
                  color: color,
                  title: "Temperature",
                  unit: "°C",
                  icon: WeatherIcons.wi_thermometer,
                  minVal: minTemp,
                  maxVal: maxTemp,
                  min: 10,
                  max: 45,
                  onValueChanged: (v) {
                    if (v > maxHum) {
                      pr.changeHumidity(
                          VPD.getMinMaxLowFromTemp(v, phase).begin, phase);
                    } else if (v < minHum) {
                      pr.changeHumidity(
                          VPD.getMinMaxLowFromTemp(v, phase).end, phase);
                    }
                    pr.changeTemperature(v, phase);
                  },
                  isChild: true,
                ),
              ),
              Expanded(
                child: EditVariable(
                  value: pr.climateSettings.getHumidity(phase),
                  title: "Humidty",
                  unit: "%",
                  icon: WeatherIcons.wi_humidity,
                  minVal: minHum,
                  maxVal: maxHum,
                  min: 30,
                  max: 90,
                  onValueChanged: (v) {
                    if (v > maxHum) {
                      pr.changeTemperature(
                          VPD.getMinMaxLowFromHum(v, phase).begin, phase);
                    } else if (v < minHum) {
                      pr.changeTemperature(
                          VPD.getMinMaxLowFromHum(v, phase).end, phase);
                    }
                    pr.changeHumidity(v, phase);
                  },
                  isChild: true,
                  color: color,
                ),
              ),
              Expanded(
                child: DaySlider(
                  onValueChanged: (v) => pr.changeSuntime(v, phase),
                  initialTimeString: suntime,
                  key: new Key(phase),
                  color: color,
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
