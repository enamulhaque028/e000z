import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'customDialogue/custom_dialogue.dart';

messageFromMd(BuildContext context) {
  return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: "managingDirector.name".tr().toString(),
          descriptions: "managingDirector.message".tr().toString(),
          img: Image(
            image: NetworkImage(
                'http://drug-international.com/resource/img/12.jpg'),
          ),
        );
      });
}
