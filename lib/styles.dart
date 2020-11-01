library sgs.styles;

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double borderRadius = 15.0;
double cardElavation = 0.5;

const Color primaryColor = Color(0xFF26C281);
const Color secondaryColor = Color(0xFF3f51b5);
const Color text_gray = Color(0xFF646464);
const Color accentColor = Colors.white;

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

TextStyle heading = GoogleFonts.quicksand(color: Colors.white);

TextStyle heading2 = GoogleFonts.quicksand();

TextStyle text = GoogleFonts.quicksand();