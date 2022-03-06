import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/celebrity_list/components/celebrity_gallery_tile.dart';
import 'package:swipe/pages/navbar/celebrity_list/components/celebrity_profile_info.dart';
import 'package:swipe/pages/navbar/celebrity_list/components/chat_option_tile.dart';
import 'package:swipe/pages/navbar/home/components/share_dialog.dart';
import 'package:swipe/services/fav_and_block_service.dart';
import 'package:swipe/widgets/custom_button.dart';

class CelebrityProfilePage extends StatefulWidget {
  final String name;
  final String bio;
  final String gender;
  final String country;
  final String avatarUrl;
  final String id;
  final List<String> galleryImages;
  const CelebrityProfilePage({
    Key? key,
    required this.name,
    required this.bio,
    required this.gender,
    required this.country,
    required this.avatarUrl,
    required this.id,
    required this.galleryImages,
  }) : super(key: key);

  @override
  State<CelebrityProfilePage> createState() => _CelebrityProfilePageState();
}

class _CelebrityProfilePageState extends State<CelebrityProfilePage> {
  late String avatarImageUrl = widget.avatarUrl;
  FavAndBlockListService favAndBlockListService = new FavAndBlockListService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.kBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/bg.png',
                    fit: BoxFit.cover,
                    height: 170,
                    width: size.width,
                  ),
                  Positioned(
                    top: 30,
                    // left: 16,
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: CustomButton(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              iconData: Icons.arrow_back_ios_new,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: CustomButton(
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
                                    return ShareDialog();
                                  },
                                );
                              },
                              iconData: Icons.share,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    // left: size.width * 0.35,
                    child: Container(
                      width: size.width,
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0XFFe6f9ff),
                              radius: 60.0,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(avatarImageUrl),
                                onBackgroundImageError: (a, b){
                                  setState(() {
                                    avatarImageUrl = 'https://raw.githubusercontent.com/enamulhaque028/data/main/user.png';
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              top: 70,
                              right: 0,
                              child: Image.asset(
                                'assets/images/edit.png',
                                fit: BoxFit.cover,
                                height: 30,
                                // width: size.width,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColor.iconBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 17,
                            color: Colors.yellow[600],
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Celebrity',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 165,
                    right: 20,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[500],
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'online',
                              style: TextStyle(
                                color: AppColor.primaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Center(
                child: Column(
                  children: [
                    //profile section
                    CelebrityProfileInfo(
                      name: widget.name,
                      profileDesc: widget.bio,
                      id: widget.id,
                    ),

                    //chat option
                    ChatOptionTile(),

                    //gallery section
                    CelebrityGalleryTile(galleryPhotos: widget.galleryImages),

                    //bottom section
                    SizedBox(height: 24),
                    ListTile(
                      leading: Image.asset('assets/images/gender_color.png', height: 35),
                      title: Text(
                        widget.gender,
                        style: TextStyle(color: AppColor.secondaryTextColor),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Image.asset('assets/images/earth_color.png', height: 35),
                      title: Text(
                        widget.country,
                        style: TextStyle(color: AppColor.secondaryTextColor),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Image.asset('assets/images/block.png', height: 35),
                      title: Text(
                        'Block',
                        style: TextStyle(color: AppColor.secondaryTextColor),
                      ),
                      onTap: () {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          showCancelBtn: true,
                          text: "Do you want to block ${widget.name}?",
                          onConfirmBtnTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(child: CircularProgressIndicator());
                            });
                            favAndBlockListService.addRemoveUser(userId: widget.id, isFavourite: false, method: 'post').then((value) {
                              if (favAndBlockListService.statusCode == 200) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: 'Added ${widget.name} to block list',
                                );
                              } else {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: 'Failed! Try again',
                                );
                              }
                            });
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
