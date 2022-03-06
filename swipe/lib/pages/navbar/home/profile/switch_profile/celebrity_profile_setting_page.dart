import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/components/congratulation_diualog.dart';
import 'package:swipe/pages/navbar/home/profile/edit/set_diamond_dialog.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import '../../components/celebrity_profile_card_tile.dart';

class CelebrityProfileSettingPage extends StatefulWidget {
  const CelebrityProfileSettingPage({Key? key}) : super(key: key);

  @override
  _CelebrityProfileSettingPageState createState() =>
      _CelebrityProfileSettingPageState();
}

class _CelebrityProfileSettingPageState
    extends State<CelebrityProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                height: 220,
                width: size.width,
              ),
              Positioned(
                top: 50,
                left: 16,
                child: Row(
                  children: [
                    CustomButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      iconData: Icons.arrow_back_ios_new,
                    ),
                    Container(
                      width: size.width / 1.4,
                      child: Center(
                        child: Text(
                          'Celebrity Profile Setting',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.kBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(top: 140),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CelebrityProfileCardTile(
                          diamondNo: '10 Diamond',
                          assetIconPath: 'assets/images/message.png',
                          title: 'For Chat',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColor.kBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              builder: (context) {
                                return SetDiamondDialog(
                                  assetIconPath: 'assets/images/message.png',
                                  title: 'Chat Request',
                                  diamondType: 'chat',
                                );
                              },
                            );
                          },
                        ),
                        CelebrityProfileCardTile(
                          diamondNo: '20 Diamond / minutes',
                          assetIconPath: 'assets/images/audio.png',
                          title: 'Audio Call',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColor.kBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              builder: (context) {
                                return SetDiamondDialog(
                                  assetIconPath: 'assets/images/tel.png',
                                  title: 'Audio Call',
                                  diamondType: 'audio',
                                );
                              },
                            );
                          },
                        ),
                        CelebrityProfileCardTile(
                          diamondNo: '30 Diamond / minutes',
                          assetIconPath: 'assets/images/video.png',
                          title: 'Video Call',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColor.kBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              builder: (context) {
                                return SetDiamondDialog(
                                  assetIconPath: 'assets/images/video.png',
                                  title: 'Video Call',
                                  diamondType: 'video',
                                );
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: CustomTextButton(
                            title: 'OK',
                            onTapBtn: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CongratulationDialog(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
