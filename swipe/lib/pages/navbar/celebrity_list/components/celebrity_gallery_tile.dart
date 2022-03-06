import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class CelebrityGalleryTile extends StatefulWidget {
  final List<String> galleryPhotos;
  const CelebrityGalleryTile({
    Key? key,
    required this.galleryPhotos,
  }) : super(key: key);

  @override
  State<CelebrityGalleryTile> createState() => _CelebrityGalleryTileState();
}

class _CelebrityGalleryTileState extends State<CelebrityGalleryTile> {
  late List<String> galleryImageList = widget.galleryPhotos;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        // height: 200,
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(218, 227, 231, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.iconBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/gallery.png',
                    // fit: BoxFit.cover,
                    height: 30,
                    // width: size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 60,
                width: size.width,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: galleryImageList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Stack(
                                children: [
                                  InteractiveViewer(
                                    child: ClipRRect(
                                      // borderRadius:
                                      //     BorderRadius.circular(20), // Image border
                                      child: SizedBox.fromSize(
                                        // size: Size.fromRadius(48), // Image radius
                                        child: Image.network(
                                          galleryImageList[index],
                                          height: size.height,
                                          width: size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/images/cross.png',
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Image.network(
                              galleryImageList[index],
                              errorBuilder: (context, object, stackTrace) {
                                return Image.network(
                                  'https://raw.githubusercontent.com/enamulhaque028/data/main/user.png',
                                  fit: BoxFit.fill,
                                  height: 60,
                                  width: 65,
                                );
                              },
                              fit: BoxFit.cover,
                              height: 60,
                              width: 65,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
