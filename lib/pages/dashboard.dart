import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suf_linux/customwidgets/carddata.dart';
import 'package:suf_linux/customwidgets/dayRange.dart';
import 'package:suf_linux/customwidgets/waterTankLevel.dart';
import 'package:suf_linux/styles.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 60,
      color: Colors.white,
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 3,
            crossAxisSpacing: 20,
            children: [
              CardData(
                icon: Icons.ac_unit,
                text: '25C',
                label: 'Temperature',
                iconColor: primaryColor,
              ),
              CardData(
                icon: Icons.ac_unit,
                text: '25C',
                label: 'Temperature',
                iconColor: primaryColor,
              ),
              CardData(
                icon: Icons.ac_unit,
                text: '25C',
                label: 'Temperature',
                iconColor: primaryColor,
              )
            ],
          ),
          DayRange(),
          WaterTankLevel(
            fullness: 40.0,
            height: 200,
            width: 100,
          ),
        ],
      ),
    );
  }
}
