import 'package:flutter/material.dart';
// import 'package:mediinfo/pages/cart/cart_page.dart';
import 'package:mediinfo/services/db/db_provider.dart';

class DragableButton extends StatefulWidget {
  final Offset initialOffset;
  final VoidCallback onBtnTap;

  const DragableButton({
    Key key,
    @required this.onBtnTap,
    this.initialOffset = const Offset(282.0, 198.4),
  }) : super(key: key);
  @override
  _DragableButtonState createState() => _DragableButtonState();
}

class _DragableButtonState extends State<DragableButton> {
  // Offset position = Offset(282.0, 198.4);
  DBProvider dbProvider = DBProvider();
  Offset position;
  @override
    void initState() {
      setState(() {
        position = widget.initialOffset;
      });
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
          feedback: Container(
            child: FloatingActionButton(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black.withOpacity(0.6),
                  size: 50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                backgroundColor: Colors.grey.shade200.withOpacity(0.5),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CartPage(),
                  //   ),
                  // );
                  widget.onBtnTap();
                  //click events
                  String userActivity = 'Went to Cart page from Herbal';
                  String page = 'Herbal';
                  String date = DateTime.now().toString();
                  dbProvider.addToClickEvent(userActivity, page, date);
                }),
          ),
          child: Container(
            child: FloatingActionButton(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black.withOpacity(0.6),
                  size: 50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                backgroundColor: Colors.grey.shade200.withOpacity(0.5),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CartPage(),
                  //   ),
                  // );
                  widget.onBtnTap();
                  //click events
                  String userActivity = 'Went to Cart page from Herbal';
                  String page = 'Herbal';
                  String date = DateTime.now().toString();
                  dbProvider.addToClickEvent(userActivity, page, date);
                }),
          ),
          childWhenDragging: Container(),
          onDragEnd: (details) {
            setState(() {
              position = details.offset;
            });
            print(position);
            print(position.dx);
            print(position.dy);
          }),
    );
  }
}
