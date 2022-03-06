import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/widgets/custom_text_button.dart';

class PaymentDialog extends StatelessWidget {
  final String creditCardNo;
  final VoidCallback onTapBuy;
  const PaymentDialog({
    Key? key,
    required this.creditCardNo,
    required this.onTapBuy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          decoration: BoxDecoration(
            color: AppColor.iconBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondaryTextColor,
                ),
              ),
              Text(
                'CHANGE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 32, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.payment,
                    size: 28,
                  ),
                  SizedBox(width: 16),
                  Text(
                    creditCardNo,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.primaryTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Center(
                  child: SizedBox(
                    width: 110,
                    height: 50,
                    child: CustomTextButton(
                      title: 'BUY',
                      onTapBtn: () {
                        onTapBuy();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
