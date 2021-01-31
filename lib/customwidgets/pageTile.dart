import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/colorFadeIcon.dart';
import 'package:suf_linux/customwidgets/colorFadeText.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/providers/dashboardProvider.dart';

class PageTile extends StatelessWidget {
  final PageOption option;
  final Function onTap;
  final bool sel;
  final bool last;
  const PageTile({Key key, this.option, this.onTap, this.sel, this.last})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: ListTile(
        title: Row(
          children: [
            Container(
              child: ColorFadeIcon(
                begin: Colors.white38,
                end: Colors.white,
                forward: sel,
                icon: option.icon,
              ),
              margin: EdgeInsets.only(right: 8),
            ),
            Expanded(
              child: ColorFadeText(
                begin: Colors.white38,
                end: Colors.white,
                forward: sel,
                text: option.title,
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.only(left: 8),
        onTap: () => {
          onTap(),
          Provider.of<DashboardProvider>(context, listen: false)
              .setSelectedChild(option),
        },
      ),
    );
  }
}
