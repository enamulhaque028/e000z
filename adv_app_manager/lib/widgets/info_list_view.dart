import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoListView extends StatelessWidget {
  final int index;
  final String info;
  const InfoListView({
    Key? key,
    required this.index,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(
          ClipboardData(
            text: info,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('copied to clipboard'),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color:
                index % 2 == 0 ? const Color(0xFFF0F4F8) : Colors.transparent,
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  'assets/images/arrow.png',
                  height: 24,
                  width: 24,
                ),
              ),
              Flexible(
                child: Text(
                  info,
                  style: const TextStyle(
                    color: Color(0xFF444444),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
