import 'dart:convert';
import 'dart:io';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StorageProvider extends ChangeNotifier {
  Map<String, String> imgRefs = new Map();
  List<Image> images = [];
  Map<String, String> urls = {};
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

  Future initImages(context) async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.jpeg'))
        .toList();

    imagePaths.forEach((element) {
      var path = element.split("/");
      var imgName = path[path.length - 1];

      if (!images.any((element) => element.semanticLabel == imgName)) {
        images.add(
          new Image.asset(
            element,
            semanticLabel: imgName,
          ),
        );
      }
    });
    notifyListeners();
    print(images);
  }

  Future<void> loadImages(context) async {
    // imgRefs = await getImageReferences();

    /* await Future.wait(
      imgRefs.keys.map(
             (key) async => urls[key] = await imgRefs[key].getDownloadURL(),
          ),
    );*/

    urls.forEach((date, url) {
      if (images.every((element) => element.semanticLabel != date))
        images.add(
          new Image.network(
            url,
            semanticLabel: date,
          ),
        );
    });

    //need to call sort after all images are in the lis

    images.sort((img1, img2) {
      return img1.semanticLabel.compareTo(img2.semanticLabel);
    });

    images.forEach((element) {
      precacheImage(element.image, context);
    });

    print("loaded images");
    notifyListeners();
  }
}
