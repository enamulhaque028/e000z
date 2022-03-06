import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/services/fav_and_block_service.dart';

class CelebrityProfileInfo extends StatefulWidget {
  final String name;
  final String profileDesc;
  final String id;
  const CelebrityProfileInfo({
    Key? key,
    required this.name,
    required this.profileDesc,
    required this.id,
  }) : super(key: key);

  @override
  State<CelebrityProfileInfo> createState() => _CelebrityProfileInfoState();
}

class _CelebrityProfileInfoState extends State<CelebrityProfileInfo> {
  FavAndBlockListService favAndBlockListService = new FavAndBlockListService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.secondaryTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                child: Image.asset(
                  'assets/images/star_yellow.png',
                  height: 30,
                ),
                onTap: (){
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    showCancelBtn: true,
                    text: "Do you want to add ${widget.name} to favourite?",
                    onConfirmBtnTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                      });
                      favAndBlockListService.addRemoveUser(userId: widget.id, isFavourite: true, method: 'post').then((value) {
                        if (favAndBlockListService.statusCode == 200) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: 'Added ${widget.name} to favourite list',
                          );
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: 'Update failed! Try again',
                          );
                        }
                      });
                    }
                  );
                },
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          child: Text(
            widget.profileDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/facebook.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/twitter.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/instagram.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
