import 'package:aits_gallery/screens/home/gallery/gallery_details_page.dart';
import 'package:flutter/material.dart';
import 'package:aits_gallery/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:aits_gallery/widgets/photo_list_tile.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  void initState() {
    super.initState();
    final data = Provider.of<GalleryDataProvider>(context, listen: false);
    data.getGalleryData(context);
  }

  @override
  Widget build(BuildContext context) {
    final galleryInfo = Provider.of<GalleryDataProvider>(context);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      padding: EdgeInsets.all(8),
      child: galleryInfo.loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: isPortrait ? 1.0 : 1.2,
                ),
                itemCount: galleryInfo.galleryData.length,
                itemBuilder: (context, index) {
                  String url = galleryInfo.galleryData[index].downloadUrl.toString();
                  var imageUrl = '${url.substring(0, url.length - 10)}/400/400';
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryDetailsPage(imageUrl: imageUrl),
                          ),
                        );
                      },
                      child: PhotoListTile(
                        imageUrl: "$imageUrl",
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
