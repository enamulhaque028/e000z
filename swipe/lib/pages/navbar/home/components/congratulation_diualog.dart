import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/widgets/custom_text_button.dart';

class CongratulationDialog extends StatelessWidget {
  final VoidCallback onTap;

  const CongratulationDialog({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Image.asset(
                    'assets/images/congo_star.png',
                    height: 100,
                  ),
                ),
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondaryTextColor.withOpacity(0.58),
                  ),
                ),
                Text(
                  "Now you're celebrity",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.primaryTextColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: Material(
                      child: CustomTextButton(
                        title: 'OK',
                        onTapBtn: () {
                          onTap();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
