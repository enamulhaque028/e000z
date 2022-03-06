import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:aits_gallery/provider/provider.dart';

class GalleryDetailsPage extends StatelessWidget {
  final String imageUrl;
  const GalleryDetailsPage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibility = Provider.of<GalleryDataProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: InkWell(
        onTap: () {
          visibility.checkVisibility();
        },
        child: Stack(
          children: [
            Container(
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
                loadingBuilder: (context, event) {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Visibility(
              visible: visibility.isVisible,
              child: Positioned(
                top: 30,
                left: 0,
                child: SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back, size: 30),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert, size: 30),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: visibility.isVisible,
              child: Positioned(
                bottom: 20,
                child: SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          print('Tapped share!');
                          http.Response response = await http.get(Uri.parse(imageUrl));
                          await WcFlutterShare.share(
                            sharePopupTitle: 'share',
                            subject: 'This is subject',
                            text: 'This is text',
                            fileName: 'share.png',
                            mimeType: 'image/png',
                            bytesOfFile: response.bodyBytes,
                          );
                        },
                        icon: Icon(Icons.share, size: 30),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.auto_awesome_outlined, size: 30),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.mode_edit, size: 30),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, size: 30),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
