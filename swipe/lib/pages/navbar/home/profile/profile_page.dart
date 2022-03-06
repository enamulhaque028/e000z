import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/user_details_model.dart';
import 'package:swipe/pages/navbar/home/components/share_dialog.dart';
import 'package:swipe/pages/navbar/home/profile/edit/edit_profile_page.dart';
import 'package:swipe/services/user_details_service.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/shimmer_effect.dart';
import 'gallery_info.dart';
import 'profile_info.dart';
import 'settings_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserDetailsModel userInfo;
  bool isLoading = true;
  String avatarUrl = '';
  List<String> galleryImageList = [];

  @override
  void initState() {
    UserDetailsService().fetchUserDetails().then((data) {
      setState(() {
        userInfo = userDetailsModelFromJson(data);
        avatarUrl = userInfo.user!.avatar.toString();
        galleryImageList = userInfo.user!.gallery!;
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.kBackground,
        body: isLoading
            ? Center(child: ShimmerList())
            : SingleChildScrollView(
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
                      // padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.18),
                            child: Text(
                              'My Profile',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColor.kBackground,
                              ),
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
                                backgroundImage: NetworkImage(avatarUrl),
                                onBackgroundImageError: (a, b){
                                  setState(() {
                                    avatarUrl = 'https://raw.githubusercontent.com/enamulhaque028/data/main/user.png';
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
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/diamond_blue.png',
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8, right: 4),
                          color: AppColor.iconBackground,
                          child: Text('220'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 165,
                    right: 20,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Row(
                        children: [
                          Switch(
                            value: true,
                            activeColor: Colors.green,
                            onChanged: (val) {},
                          ),
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
                ],
              ),
              SizedBox(height: 70),
              Center(
                child: Column(
                  children: [
                    ProfileInfo(
                      name: userInfo.user!.name.toString(),
                      profileDesc: userInfo.user!.bio.toString(),
                    ),
                    GalleryInfo(
                      galleryPhotos: galleryImageList,
                      onUploadGalleryImage: (updatedGalleryImage){
                        setState(() {
                          galleryImageList = updatedGalleryImage;
                        });
                      },
                    ),
                    SettingsInfo(
                      gender: userInfo.user!.gender.toString(),
                      country: userInfo.user!.country.toString(),
                      profileType: userInfo.user!.type.toString(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: CustomTextButton(
                        title: 'EDIT PROFILE',
                        onTapBtn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                userInfo: userInfo,
                                galleryImageList: galleryImageList,
                                onAvatarChange: (updatedAvatar){
                                  setState(() {
                                    avatarUrl = updatedAvatar;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
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
