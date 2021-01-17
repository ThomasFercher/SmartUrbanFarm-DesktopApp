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

class Gallery extends StatelessWidget {
  void takePhoto(context) {
    Provider.of<StorageProvider>(context, listen: false).takePhoto();
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
          height: MediaQuery.of(context).size.height - 40,
          child: Stack(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  viewportFraction: 0.95,
                  enlargeCenterPage: true,
                  height: MediaQuery.of(context).size.height,
                  enableInfiniteScroll: false,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return PhotoListItem(photos[index]);
                },
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
                      Icons.photo,
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    AppTheme theme = Provider.of<SettingsProvider>(context).getTheme();

    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: [
          Card(
            elevation: cardElavation + 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            color: theme.cardColor,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: photo.image.width,
                      height: photo.image.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius),
                        ),
                        child: photo.image,
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
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: SectionTitle(title: photo.date)),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "some text containing data from the time of the photo",
                    style: TextStyle(color: theme.headlineColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
