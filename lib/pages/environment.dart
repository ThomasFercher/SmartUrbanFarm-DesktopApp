import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/climate/right/climateControlItem.dart';
import 'package:suf_linux/customwidgets/general/popupMenu.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/climateControl.dart';
import 'package:suf_linux/objects/photo.dart';
import 'package:suf_linux/objects/popupMenuOption.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/providers/storageProvider.dart';
import 'package:suf_linux/styles.dart';

class Environment extends StatelessWidget {
  void takePhoto(context) {
    Provider.of<StorageProvider>(context, listen: false).takePhoto();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Consumer<DashboardProvider>(builder: (context, data, c) {
      List<ClimateControl> climates = data.climates;
      var height = MediaQuery.of(context).size.height;
      return Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        padding: EdgeInsets.all(8),
        color: theme.background,
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: SectionTitle(
                      title: "Others",
                    ),
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: climates.length,
                      itemBuilder: (context, index) {
                        return ClimateControlItem(
                          settings: climates[index],
                          height: height - 16,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      );
    });
  }
}
