import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

import 'package:suf_linux/styles.dart';
import '../../../styles.dart';

class EditVariable extends StatelessWidget {
  final double value;
  final String title;
  final Color color;
  final IconData icon;
  final String unit;
  final Function onValueChanged;
  final double min;
  final double max;
  final double minVal;
  final double maxVal;
  final double divisions;
  bool isChild;

  EditVariable({
    this.value,
    this.title,
    this.color,
    this.icon,
    this.unit,
    this.onValueChanged,
    this.min,
    this.max,
    this.isChild,
    this.divisions,
    this.minVal,
    this.maxVal,
  }) {
    isChild = isChild ?? false;
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      padding: isChild
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      color: theme.cardColor,
      child: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: SectionTitle(
                      title: title,
                      fontSize: 13,
                      color: theme.headlineColor,
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$value$unit",
                      style: TextStyle(
                        color: theme.headlineColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: CupertinoSlider(
                value: value,
                onChanged: (val) {
                  val = double.parse((val).toStringAsFixed(2));

                  onValueChanged(val);
                },
                activeColor: color,
                max: max,
                min: min,
                divisions: divisions ?? ((max - min) * 2).round(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
