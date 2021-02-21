import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/pages/environment.dart';
import 'package:suf_linux/pages/sider.dart';
import 'package:suf_linux/providers/dataProvider.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer<DataProvider>(
          builder: (context, d, child) {
            return Row(
              children: [
                Container(
                  color: d.selectedChild.title == "Environment"
                      ? theme.primaryColor
                      : theme.background,
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Sider(),
                ),
                Expanded(
                  child: d.selectedChild.widget,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
