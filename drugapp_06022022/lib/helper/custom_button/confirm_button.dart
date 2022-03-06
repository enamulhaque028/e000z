import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';

class ConfirmButton extends StatefulWidget {
  final Function onTap;
  ConfirmButton({@required this.onTap});
  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => controller.forward(),
      onTapUp: (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reverse();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 100,
            width: 220,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              value: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
            ),
          ),
          Container(
            height: 100,
            width: 220,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              value: controller.value,
              valueColor: controller.value == 1.0
                  ? AlwaysStoppedAnimation<Color>(Colors.green)
                  : AlwaysStoppedAnimation<Color>(
                      Color(PrimaryColor).withOpacity(0.7)),
            ),
          ),
          //Icon(Icons.add)
          controller.value == 1.0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order confirmed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Icon(
                      Icons.check_outlined,
                      color: Colors.green,
                      size: 30,
                    )
                  ],
                )
              : Text(
                  'Tap and hold to confirm order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
      onTap: () {
        controller.value == 1.0
            ? () {
                log('Order confirmed');
                //Navigator.pop(context);
                widget.onTap();
              }()
            : log('Order not confirmed');
      },
    );
  }
}
