import 'package:flutter/material.dart';

class FavListTile extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String genericName;
  final String tokenType;
  final String token;
  final bool isVisibleDeleteIcon;
  final VoidCallback onTapDalete;
  const FavListTile({
    Key key,
    @required this.imageUrl,
    @required this.productName,
    @required this.genericName,
    this.tokenType = '',
    this.token = '',
    this.isVisibleDeleteIcon = true,
    @required this.onTapDalete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var leftContainerWidth = width * (3 / 10);
    var rightContainerWidth = width * (7 / 10);
    return Column(
      children: [
        Container(
          width: width,
          height: 100,
          child: Row(
            children: [
              Container(
                height: height,
                width: leftContainerWidth,
                child: Image.network(
                  imageUrl,
                  headers: {'Authorization': '$tokenType $token'},
                  errorBuilder: (context, object, stacktrace) {
                    return Container(
                      height: height,
                      width: leftContainerWidth,
                      child: Image.asset(
                        'assests/images/no_preview.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                // decoration: new BoxDecoration(
                //   color: Colors.transparent,
                //   shape: BoxShape.rectangle,
                //   image: new DecorationImage(
                //     fit: BoxFit.fill,
                //     image: new NetworkImage(imageUrl),
                //   ),
                // ),
              ),
              Container(
                height: height,
                width: rightContainerWidth,
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: rightContainerWidth * 0.70 - 8,
                              child: Text(
                                productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            !isVisibleDeleteIcon ? Container() : Container(
                              // width: rightContainerWidth * 0.30 - 8,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  onTapDalete();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(genericName),
                      // Text(productCategoryName),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey[200], height: 2, thickness: 5),
      ],
    );
  }
}
