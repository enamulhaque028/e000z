import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoListTile extends StatelessWidget {
  final String imageUrl;

  const PhotoListTile({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: double.maxFinite,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'IMG_20220202_22450669',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 9),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(228, 229, 229, 1)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'JPG',
                    style: TextStyle(color: Color.fromRGBO(79, 44, 255, 1)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.folder,
                        color: Color.fromRGBO(79, 44, 255, 1),
                        size: 16,
                      ),
                      SizedBox(width: 7),
                      Text('3 MB'),
                    ],
                  ),
                  SizedBox(width: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_view_month_rounded,
                        color: Color.fromRGBO(79, 44, 255, 1),
                        size: 16,
                      ),
                      SizedBox(width: 7),
                      Text('12/10/2021'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 13),
        ],
      ),
    );
  }
}
