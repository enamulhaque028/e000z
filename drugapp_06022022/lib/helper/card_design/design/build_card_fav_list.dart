import 'package:flutter/material.dart';

class BuildCardFavList extends StatelessWidget {
  final String thumbLink;
  final String productName;
  final String genericName;
  final Function onTap;

  const BuildCardFavList({
    @required this.thumbLink,
    @required this.productName,
    @required this.genericName,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var leftContainerWidth = width * (2 / 5) - 8;
    var rightContainerWidth = width * (3 / 5) - 8;
    return Column(
      children: [
        Container(
          //color: Colors.red,
          width: width,
          height: 170,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: height,
                  width: leftContainerWidth,
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                        thumbLink,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height,
                  width: rightContainerWidth,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: rightContainerWidth * 0.70 - 8,
                                child: Text(
                                  productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                  width: rightContainerWidth * 0.30 - 8,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      onTap();
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            genericName,
                            style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 2,
          thickness: 5,
        )
      ],
    );
  }
}
