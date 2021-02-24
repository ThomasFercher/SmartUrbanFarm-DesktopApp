import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class GrowProgress extends StatelessWidget {
  final double progress;

  GrowProgress({Key key, this.progress}) : super(key: key);

  FlareControls flareControls = new FlareControls();

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return LayoutBuilder(builder: (context, constraints) {
      Size size = constraints.biggest;
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: theme.cardColor,
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              FlareActor(
                'assets/flares/plant.flr',
                alignment: Alignment.center,
                animation: "Growing",
                controller: flareControls,
                callback: (name) {
                  flareControls.play("Wind");
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 4),
                alignment: Alignment.topCenter,
                child: Text(
                  "$progress%",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w100,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
