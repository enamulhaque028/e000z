import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final Function onTap;
  CustomButton({
    @required this.btnColor,
    @required this.btnText,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                btnColor.withOpacity(1.0),
                btnColor.withOpacity(0.6),
              ],
            ),
          ),
          child: Center(
            child: Text(
              btnText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateEventButton extends StatelessWidget {
  final String title;
  final VoidCallback onTapBtn;
  const CreateEventButton({
    Key key,
    @required this.title,
    @required this.onTapBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Container(
            // width: 145,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(cViolet),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$title'),
                  Icon(Icons.add),
                ],
              ),
              onPressed: () {
                onTapBtn();
              },
            ),
          ),
        ),
      ],
    );
  }
}
