import 'dart:io';

import 'package:flutter/material.dart';

class Photo {
  File file;
  String date;
  Image image;

  Photo({this.file, this.date, this.image});
}
