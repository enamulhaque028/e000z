import 'package:flutter/material.dart';
import 'package:mediinfo/pages/about/message_of_md/customDialogue/custom_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';

chairmanProfile(BuildContext context) {
  return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: 'chairman.name'.tr().toString(),
          descriptions: 'chairman.desc'.tr().toString(),
          img: Image(
            image: NetworkImage(
                'http://drug-international.com/resource/img/1.jpg'),
          ),
        );
      });
}
