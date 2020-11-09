import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suf_linux/customwidgets/sectionTitle.dart';
import 'package:suf_linux/providers/storageProvider.dart';
import 'package:suf_linux/styles.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<StorageProvider>(builder: (context, storage, c) {
      List<Image> imgs = storage.images;
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: SectionHeading(text: "Photos")),
            Container(
              height: MediaQuery.of(context).size.height - 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imgs.length,
                itemBuilder: (context, index) {
                  return ImageListItem(imgs[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ImageListItem extends StatelessWidget {
  final Image image;

  ImageListItem(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: MediaQuery.of(context).size.height - 30,
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: cardElavation + 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                child: image,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                image.semanticLabel,
                style: heading2,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                "some text containing data from the time of the photo",
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}
