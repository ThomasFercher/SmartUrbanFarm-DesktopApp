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
    AssetFlare(bundle: rootBundle, name: "assets/flares/plant.flr"),
    AssetFlare(bundle: rootBundle, name: "assets/flares/logo.flr")
  ];


  /// This Functions caches all the predifined Flares [_assetsToWarmup]
  Future<void> loadFlares() async {
    for (final asset in _assetsToWarmup) {
      await cachedActor(asset);
    }
  } 

  /// This Functions loads all Photos which exist locally on the 
  /// machine in the Photos folder. The Photos also get sorted after 
  /// Date und get precached so they dont load in the App. 
  Future<void> loadImages(context) async {
    List<File> files = FileService.getFileList();

    if (files == null || files.isEmpty) {
      return;
    }

    photos = files.map((file) {
      var fileName = file.path.split("/")[file.path.split("/").length - 1];
      var date_string = fileName.replaceAll("photo_", "").replaceAll(".jpeg", "");
      return Photo(file: file, image: Image.file(file), date: date_string);
    }).toList();

    photos.sort((ph1, ph2) {
      return ph1.date.compareTo(ph2.date);
    });

    photos.forEach((photo) {
      precacheImage(photo.image.image, context);
    });

    notifyListeners();
  }

  /// This Functions deletes the given [photo] locally from the List.
  /// Aswell as deleting it from the Filesystem.
  void deletePhoto(Photo photo) {
    this.photos.remove(photo);
    FileService.deleteFile(photo.file);
    notifyListeners();
  }

  void takePhoto() {
    print("Take Photo");
  }
}
