import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.onTapYes,
    required this.title,
  }) : super(key: key);

  final String title;
  final Function onTapYes;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      child: SizedBox(
        height: 200,
        width: width,
        child: Column(
          // ignore: avoid_redundant_argument_values
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(''),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: 'Yes',
                  onTap: () {
                    onTapYes();
                  },
                ),
                const SizedBox(width: 10.0),
                CustomButton(
                  title: 'No',
                  btnColor: AppColor.kDarkBlueColor,
                  btnTextColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
