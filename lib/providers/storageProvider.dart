import 'dart:convert';
import 'dart:io';

import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:suf_linux/objects/photo.dart';
import 'package:suf_linux/services.dart/fileservice.dart';

class StorageProvider extends ChangeNotifier {
  List<Photo> photos = [];

  var _assetsToWarmup = [
    AssetFlare(bundle: rootBundle, name: "assets/flares/moon.flr"),
    AssetFlare(bundle: rootBundle, name: "assets/flares/sun.flr"),
    AssetFlare(bundle: rootBundle, name: "assets/flares/plant.flr")
  ];

  Future<void> loadFlares() async {
    //chaches the flares so they can be instantly used without loading
    for (final asset in _assetsToWarmup) {
      await cachedActor(asset);
    }
  }

  Future<void> loadImages(context) async {
    FileService service = new FileService();
    List<File> files = service.getFileList();

    photos = files.map((file) {
      var p = file.path.split("/")[file.path.split("/").length - 1];
      var date_string = p.replaceAll("photo_", "").replaceAll(".jpeg", "");
      print(date_string);
      return Photo(file: file, image: Image.file(file), date: date_string);
    }).toList();

    //need to call sort after all images are in the lis

    photos.sort((ph1, ph2) {
      return ph1.date.compareTo(ph2.date);
    });

    photos.forEach((photo) {
      precacheImage(photo.image.image, context);
    });

    print("loaded photos");
    notifyListeners();
  }

  void deletePhoto(Photo photo) {
    this.photos.remove(photo);
    photo.file.deleteSync();
    notifyListeners();
  }

  void takePhoto() {
    print("Take Photo");
  }
}
