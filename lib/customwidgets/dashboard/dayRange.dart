import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class DayRange extends StatelessWidget {
  final String suntime;

  const DayRange({Key key, this.suntime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    var start = suntime.split("-")[0].trim();
    var end = suntime.split("-")[1].trim();

    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: cardElavation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        color: theme.background,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              stops: [0.1, 1.4],
              colors: [Color(0xFFfad0c4), Color(0xFF000C40)],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 40,
                height: 40,
                child: FlareActor(
                  'assets/flares/sun.flr',
                  alignment: Alignment.center,
                  animation: "Moon Rings",
                  color: Colors.deepOrange,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    start,
                    style:
                        GoogleFonts.nunito(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  end,
                  style: GoogleFonts.nunito(color: Colors.white, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 40,
                height: 40,
                child: FlareActor(
                  'assets/flares/moon.flr',
                  alignment: Alignment.center,
                  animation: "Moon Rings",
                  color: Colors.white,
                  //  color: Colors.yellow[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
