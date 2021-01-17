import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/providers/settingsProvider.dart';

import '../../styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;

  SectionTitle({
    this.title,
    this.fontSize,
    this.color,
  });

  Widget build(BuildContext context) {
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            color: color ?? theme.headlineColor,
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
