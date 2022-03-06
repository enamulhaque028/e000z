import 'package:flutter/material.dart';

class CartListTile extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productAmount;
  final String totalPrice;
  final String tokenType;
  final String token;
  final VoidCallback onTapDalete;
  final VoidCallback onTapIncrement;
  final VoidCallback onTapDecrement;
  const CartListTile({
    Key key,
    @required this.imageUrl,
    @required this.productName,
    @required this.productAmount,
    @required this.totalPrice,
    @required this.tokenType,
    @required this.token,
    @required this.onTapDalete,
    @required this.onTapIncrement,
    @required this.onTapDecrement,
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
                            Container(
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
                      Text("Quantity (Box)"),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromRGBO(26, 201, 253, 1),
                                Color.fromRGBO(29, 105, 241, 1)
                              ],
                            ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  child: Icon(Icons.remove, color: Colors.white, size: 20),
                                  onTap: () {
                                    onTapDecrement();
                                  },
                                ),
                                Text(productAmount, style: TextStyle(color: Colors.white)),
                                InkWell(
                                  child: Icon(Icons.add, color: Colors.white, size: 20),
                                  onTap: () {
                                    onTapIncrement();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                totalPrice,
                                style:
                                    TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
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
