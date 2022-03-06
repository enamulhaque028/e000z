import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(
          ClipboardData(text: info == 'null' ? '' : info),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('copied to clipboard'),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            info == 'null' ? '' : info,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
