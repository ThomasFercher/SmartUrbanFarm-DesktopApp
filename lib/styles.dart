library sgs.styles;

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suf_linux/objects/pageOption.dart';
import 'package:suf_linux/pages/dashboard.dart';
import 'package:suf_linux/pages/settings.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

double borderRadius = 15.0;
double cardElavation = 2.0;

const Color primaryColor = Color(0xFF26C281);
const Color secondaryColor = Color(0xFF3f51b5);
const Color text_gray = Color(0xFF646464);
const Color accentColor = Colors.white;

PageOption DashboardRoute = PageOption(
  widget: Dashboard(),
  icon: Icons.dashboard,
  title: "Dashboard",
);

PageOption SettingsRoute = PageOption(
  widget: Settings(),
  icon: Icons.settings,
  title: "Settings",
);

ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  primaryColor: primaryColor,
  accentColor: accentColor,
  textTheme: TextTheme(
    subtitle2: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 18,
      color: Colors.black87,
      fontWeight: FontWeight.w400,
    ),
    headline2: TextStyle(
      color: text_gray,
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
    ),
    headline3: TextStyle(
      color: text_gray,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      color: accentColor,
      fontSize: 24,
      fontFamily: "Lato",
    ),
    headline1: TextStyle(
      color: Colors.black87,
      fontSize: 30.0,
    ),
  ),
);

TextStyle heading = GoogleFonts.quicksand(
    color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.w600);

TextStyle heading2 = GoogleFonts.quicksand(
    color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.w600);

TextStyle text = GoogleFonts.quicksand();
