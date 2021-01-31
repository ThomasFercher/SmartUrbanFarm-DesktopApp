import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/climate/edit/growthItem.dart';
import 'package:suf_linux/customwidgets/climate/edit/selectButton.dart';
import 'package:suf_linux/customwidgets/general/info.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/climateControlProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class GrowthPhase extends StatefulWidget {
  @override
  _GrowthPhaseState createState() => _GrowthPhaseState();
}

class _GrowthPhaseState extends State<GrowthPhase> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    return Consumer<ClimateControlProvider>(builder: (context, pr, child) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Card(
          color: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: SectionTitle(
                            title: "Grow Phases",
                            color: theme.headlineColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      InfoDialog(
                        title: "Grow Phases",
                        text:
                            "Because a plant has different needs in different periods of time, you can specify the Temperature, the Humidity and the Suntime for each the Vegetation, Early Flower and Late Flower Phase",
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: SelectButton(
                          color: Colors.deepPurple,
                          title: "Vegetation",
                          icon: MaterialCommunityIcons.sprout,
                          enabled: pr.sel_phase == GROWPHASEVEGETATION,
                          onPressed: () {
                            pr.changePhase(GROWPHASEVEGETATION);
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: SelectButton(
                          color: Colors.green,
                          icon: FontAwesome.pagelines,
                          title: "Early Flower",
                          enabled: pr.sel_phase == GROWPHASEFLOWER,
                          onPressed: () {
                            pr.changePhase(GROWPHASEFLOWER);
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: SelectButton(
                          color: Colors.amber,
                          icon: FontAwesome.pagelines,
                          enabled: pr.sel_phase == GROWPHASELATEFLOWER,
                          title: "Late Flower",
                          onPressed: () {
                            pr.changePhase(GROWPHASELATEFLOWER);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 100),
                        child: getGrowthItem(pr.sel_phase)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getGrowthItem(String phase) {
    switch (phase) {
      case GROWPHASEVEGETATION:
        return GrowthItem(
          phase: phase,
          color: Colors.deepPurple,
        );
        break;
      case GROWPHASEFLOWER:
        return GrowthItem(
          phase: phase,
          color: Colors.green,
        );
        break;
      case GROWPHASELATEFLOWER:
        return GrowthItem(
          phase: phase,
          color: Colors.amber,
        );
        break;
      default:
    }
  }
}
