import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/general/popupMenu.dart';
import 'package:suf_linux/customwidgets/general/sectionTitle.dart';
import 'package:suf_linux/objects/appTheme.dart';
import 'package:suf_linux/objects/photo.dart';
import 'package:suf_linux/objects/popupMenuOption.dart';
import 'package:suf_linux/providers/settingsProvider.dart';
import 'package:suf_linux/providers/storageProvider.dart';
import 'package:suf_linux/styles.dart';
import 'package:animations/animations.dart';

class Gallery extends StatelessWidget {
  void takePhoto(context) {
    Provider.of<StorageProvider>(context, listen: false).takePhoto(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Consumer<StorageProvider>(builder: (context, storage, c) {
      List<Photo> photos = storage.photos;
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: theme.background,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              GridView.builder(
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return PhotoListItem(photos[index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    elevation: 2.0,
                    onPressed: () {
                      takePhoto(context);
                    },
                    backgroundColor: theme.primaryColor,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class PhotoListItem extends StatelessWidget {
  final Photo photo;

  PhotoListItem(this.photo);

  delete(context) {
    Provider.of<StorageProvider>(context, listen: false).deletePhoto(photo);
  }

  onTap(context) {
    showModal(
      configuration: FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 250),
        barrierDismissible: true,
        reverseTransitionDuration: Duration(milliseconds: 250),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: photo.image.width,
                  height: photo.image.height,
                  child: Image(image: photo.image.image),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Card(
            elevation: cardElavation + 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            color: theme.cardColor,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => onTap(context),
                        child: Container(
                          width: photo.image.width,
                          height: photo.image.height,
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius),
                            ),
                            child: photo.image,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenu(
                          color: Colors.white,
                          options: [
                            PopupMenuOption(
                              "Delete",
                              Icon(Icons.delete, color: Colors.redAccent),
                            )
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case "Delete":
                                delete(context);
                                break;
                              default:
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: SectionTitle(
                      title: photo.date.split("\\")[1].replaceAll(".jpg", "")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
