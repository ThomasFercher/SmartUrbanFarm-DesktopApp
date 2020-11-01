import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:suf_linux/styles.dart';

class CardData extends StatelessWidget {
  final IconData icon;
  final String text;
  final String label;
  final Color iconColor;
  final String type;
  final GlobalKey key;

  /// This widget displays a given text with a label and icon
  /// All this is displayed in a card
  CardData({
    @required this.icon,
    @required this.text,
    @required this.label,
    @required this.iconColor,
    @required this.type,
    @required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: cardElavation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),

          color: Colors.white, //iconColor, //getTheme().cardColor,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Icon(
                icon,
                size: 26,
                color: iconColor,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                text,
                style: GoogleFonts.nunito(
                  color: Colors.black54,
                  fontWeight: FontWeight.w200,
                  fontSize: 26.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
