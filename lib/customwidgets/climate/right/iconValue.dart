import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

class IconValue extends StatelessWidget {
  final IconData icon;
  final Color color;
  String val;
  final String unit;
  final double fontsize;

  IconValue(
      {Key key, this.icon, this.color, this.val, this.unit, this.fontsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    if (val.contains(" - ")) {
      List<String> values = val.split(" - ");

      val = "${values[0]}\n${values[1]}";
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(
            "$val$unit",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w100,
              fontSize: fontsize ?? 18,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
