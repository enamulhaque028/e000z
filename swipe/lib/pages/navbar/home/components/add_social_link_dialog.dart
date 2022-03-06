import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/textfield_rounded.dart';

class AddSocialLinkDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController linkController = new TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.iconBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Add Social Link',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: TextFieldRounded(
            placeholderText: 'http//:',
            textEditingController: linkController,
            icon: Icons.link,
          ),
        ),
        Center(
          child: Container(
            width: 120,
            padding: EdgeInsets.only(bottom: 16.0),
            child: CustomTextButton(
              title: 'ADD',
              onTapBtn: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
