import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/climate/left/activeClimateControlItem.dart';
import 'package:suf_linux/customwidgets/climate/left/growPhaseSelect.dart';
import 'package:suf_linux/customwidgets/climate/right/climateControlItem.dart';
import 'package:suf_linux/customwidgets/general/popupMenu.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/climateControl.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/objects/photo.dart';
import 'package:suf_linux/objects/popupMenuOption.dart';
import 'package:suf_linux/pages/editEnvironment.dart';
import 'package:suf_linux/providers/dataProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/providers/storageProvider.dart';
import 'package:suf_linux/styles.dart';

class Environment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      child: Consumer<DataProvider>(builder: (context, data, c) {
        List<ClimateControl> climates = data.climates;
        ClimateControl activeClimate = data.activeClimate;
        var temp = activeClimate.getTemperature(activeClimate.growPhase.phase);
        var hum = activeClimate.getHumidity(activeClimate.growPhase.phase);
        var sun = activeClimate.getSuntime(activeClimate.growPhase.phase);

        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width / 2;
        width = width.floorToDouble();

        List<Widget> climctrlitems = climates
            .map((clim) => ClimateControlItem(
                  settings: clim,
                  height: height - 56,
                ))
            .toList();

        return Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          color: theme.background,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      child: Container(
                        width: width,
                        child: LayoutBuilder(builder: (context, constraints) {
                          var w = constraints.maxWidth;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.centerLeft,
                                      child: SectionTitle(
                                        title: activeClimate.name,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  PopupMenu(
                                    color: Colors.white,
                                    options: [
                                      PopupMenuOption(
                                        "Edit",
                                        Icon(
                                          Icons.edit,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                    onSelected: (val) {
                                      if (val == "Edit") {
                                        Provider.of<DataProvider>(context,
                                                listen: false)
                                            .setSelectedChild(
                                          PageOption(
                                            title: "Edit Environemnt",
                                            icon: Icons.ac_unit,
                                            widget: EditEnvironment(
                                                initialSettings: activeClimate,
                                                create: false),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: SectionTitle(
                                      title: "Active Growphase",
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: w,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GrowPhaseSelect(
                                          phase: GROWPHASEVEGETATION,
                                          disabledWidth: (w) * 0.2,
                                          color: Colors.deepPurple,
                                          title: "Vegetation",
                                          expandedWidth: (w) * 0.6,
                                          right_phase: GROWPHASEFLOWER,
                                          icon: MaterialCommunityIcons.sprout,
                                        ),
                                        GrowPhaseSelect(
                                          disabledWidth: (w) * 0.2,
                                          expandedWidth: (w) * 0.6,
                                          title: "Early Flower",
                                          color: Colors.green,
                                          phase: GROWPHASEFLOWER,
                                          left_phase: GROWPHASEVEGETATION,
                                          right_phase: GROWPHASELATEFLOWER,
                                          icon: MaterialCommunityIcons.sprout,
                                        ),
                                        GrowPhaseSelect(
                                          left_phase: GROWPHASEFLOWER,
                                          phase: GROWPHASELATEFLOWER,
                                          title: "Late Flower",
                                          color: Colors.amber,
                                          disabledWidth: (w) * 0.2,
                                          expandedWidth: (w) * 0.6,
                                          icon: MaterialCommunityIcons.sprout,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: w,
                                    child: Column(
                                      children: [
                                        ActiveClimateControlItem(
                                          height: 36,
                                          icon: WeatherIcons.wi_thermometer,
                                          lable: "Temperature",
                                          value: "$temp°C",
                                        ),
                                        ActiveClimateControlItem(
                                          height: 36,
                                          icon: WeatherIcons.wi_humidity,
                                          lable: "Humidity",
                                          value: "$hum%",
                                        ),
                                        ActiveClimateControlItem(
                                          icon: WeatherIcons.wi_day_sunny,
                                          height: 36,
                                          lable: "Suntime",
                                          value: "$sun",
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SectionTitle(
                                    title: "Irrigation",
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    child: Row(
                                      children: [
                                        activeClimate.automaticWatering
                                            ? Chip(
                                                label: Container(
                                                  height: 26,
                                                  alignment: Alignment.center,
                                                  child: SectionTitle(
                                                    fontSize: 12,
                                                    title: "Automatic",
                                                    color: theme.primaryColor,
                                                  ),
                                                ),
                                                backgroundColor: Colors.white,
                                                avatar: Icon(
                                                  Icons.auto_awesome,
                                                  color: theme.primaryColor,
                                                  size: 16,
                                                ),
                                              )
                                            : Chip(
                                                label: Container(
                                                  height: 26,
                                                  alignment: Alignment.center,
                                                  child: SectionTitle(
                                                    fontSize: 12,
                                                    title: "Regulated",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    theme.secondaryColor,
                                                avatar: Icon(
                                                  Icons.tune,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              activeClimate.automaticWatering
                                                  ? "${activeClimate.soilMoisture}%"
                                                  : "${activeClimate.waterConsumption}l/d",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 20,
                          ),
                          onPressed: () {
                            Provider.of<DataProvider>(context, listen: false)
                                .setSelectedChild(
                              PageOption(
                                title: "Create Environemnt",
                                icon: Icons.ac_unit,
                                widget: EditEnvironment(
                                  initialSettings: activeClimate,
                                  create: true,
                                ),
                              ),
                            );
                          },
                          color: theme.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: CarouselSlider(
                    items: climctrlitems,
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnTouch: true,
                      pauseAutoPlayInFiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 20),
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
