import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/styles.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
    @required this.theme,
    @required this.initialValue,
    @required this.valChanged,
  }) : super(key: key);

  final AppTheme theme;
  final String initialValue;
  final Function valChanged;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Card(
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 16),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: SectionTitle(
                title: "Name",
                fontSize: 18,
                color: theme.headlineColor,
              ),
            ),
            SizedBox(
              height: 36,
              child: TextFormField(
                cursorColor: theme.primaryColor,
                initialValue: initialValue,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 1.5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 1.5),
                  ),

                  //fillColor: Colors.green
                ),
                onChanged: (value) => valChanged(value),
                validator: (val) {
                  if (val.length == 0) {
                    return "Name cannot be empty!";
                  } else {
                    return null;
                  }
                },
                style: GoogleFonts.nunito(
                  color: theme.textColor,
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
