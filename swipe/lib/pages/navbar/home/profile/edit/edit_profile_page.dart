import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/user_details_model.dart';
import 'package:swipe/pages/navbar/home/components/share_dialog.dart';
import 'package:swipe/pages/navbar/home/profile/switch_profile/switch_profile_dialog.dart';
import 'package:swipe/pages/signup/components/country_list_dialog.dart';
import 'package:swipe/pages/signup/components/gender_list_dialog.dart';
import 'package:swipe/services/edit_profile_service.dart';
import 'package:swipe/services/update_avatar_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/avatar_image_picker.dart';
import 'package:swipe/widgets/textfield_square.dart';
import '../gallery_info.dart';
import 'dropdown_item.dart';

class EditProfilePage extends StatefulWidget {
  final UserDetailsModel userInfo;
  final List<String> galleryImageList;
  final Function(String) onAvatarChange;
  const EditProfilePage({
    Key? key,
    required this.userInfo,
    required this.onAvatarChange,
    required this.galleryImageList,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditProfilePage> {
  late TextEditingController nameController = new TextEditingController(text: widget.userInfo.user!.name);
  late TextEditingController bioController = new TextEditingController(text: widget.userInfo.user!.bio);
  late String profileMode = widget.userInfo.user!.type.toString();
  late String gender = widget.userInfo.user!.gender.toString();
  late String countryName = widget.userInfo.user!.country.toString();
  late String countryCode = widget.userInfo.user!.countryCode.toString();
  late String avatarUrl = widget.userInfo.user!.avatar.toString();
  late List<String> galleryImages = widget.galleryImageList;
  bool isApiCallProcess = false;
  EditProfileService editProfileService = new EditProfileService();
  UpdateAvatarService updateAvatarService = new UpdateAvatarService();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.kBackground,
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          child: SingleChildScrollView(
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
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.18),
                              child: Text(
                                'Edit Profile',
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
                                  log(nameController.text);
                                  log(bioController.text);
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
                                top: 10,
                                right: 0,
                                child: InkWell(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AvatarImagePickerDialog(
                                          updatePhoto: (imagePath) {
                                            setState(() {
                                              isApiCallProcess = true;
                                            });
                                            updateAvatarService.updateProfile(
                                              imagePath: imagePath
                                            ).then((value) {
                                              if (updateAvatarService.statusCode == 200) {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                  avatarUrl = value['filePath'];
                                                  widget.onAvatarChange(avatarUrl);
                                                });
                                                CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.success,
                                                  text: 'Profile picture updated',
                                                );
                                              } else {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                });
                                                CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.error,
                                                  text: 'Update failed! Try again',
                                                );
                                              }
                                            });
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/edit.png',
                                    fit: BoxFit.cover,
                                    height: 30,
                                    // width: size.width,
                                  ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                color: AppColor.secondaryTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextFieldSquire(
                            textEditingController: nameController,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Bio',
                              style: TextStyle(
                                color: AppColor.secondaryTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextFieldSquire(
                            textEditingController: bioController,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    GalleryInfo(
                      galleryPhotos: galleryImages,
                      onUploadGalleryImage: (updatedGalleryImage){
                        setState(() {
                          galleryImages = updatedGalleryImage;
                        });
                      },
                    ),
                    DropDownItem(
                      iconPath: 'assets/images/male.png',
                      title: 'Profile Type',
                      selectedValue: profileMode,
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
                            return SwitchProfileDialog(
                              onTapChange: (value) {
                                setState(() {
                                  profileMode = value;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    DropDownItem(
                      iconPath: 'assets/images/gender_color.png',
                      title: 'Gender',
                      selectedValue: gender,
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
                            return GenderListDialog(
                              onTapChangeGender: (value) {
                                setState(() {
                                  gender = value;
                                });
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                    ),
                    DropDownItem(
                      iconPath: 'assets/images/earth_color.png',
                      title: 'Country',
                      selectedValue: countryName,
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
                            return CountryListDialog(
                              onTapChangedCountry: (name, code) {
                                setState(() {
                                  countryName = name;
                                  countryCode = code;
                                });
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                    ),
                    Center(
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: CustomTextButton(
                          title: 'Done',
                          onTapBtn: () {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            editProfileService.editProfile(
                              name: nameController.text,
                              bio: bioController.text,
                              type: profileMode,
                              gender: gender,
                              country: countryName,
                              countryCode: countryCode,
                            ).then((value) {
                              if (editProfileService.statusCode == 200) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: value['message'],
                                );
                              } else {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: 'Update failed! Try again',
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
