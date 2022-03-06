import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/favourite_list_model.dart';
import 'package:swipe/pages/navbar/celebrity_list/celebrity_profile_page.dart';
import 'package:swipe/services/fav_and_block_service.dart';
import 'package:swipe/services/get_block_and_fav_list_service.dart';
import 'package:swipe/widgets/country_code_list.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'package:swipe/widgets/shimmer_effect.dart';

class BlockListPage extends StatefulWidget {
  const BlockListPage({Key? key}) : super(key: key);

  @override
  State<BlockListPage> createState() => _BlockListPageState();
}

class _BlockListPageState extends State<BlockListPage> {
  late BlockingAndFavListModel blockListData;
  bool isLoading = true;
  String blockExtUrl = 'api/blocking';
  @override
  void initState() {
    BlockAndFavListService().fetchDetails(blockExtUrl).then((data) {
      setState(() {
        blockListData = data;
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.kBackground,
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
                    Padding(
                      padding: EdgeInsets.only(left: size.width / 3 - 32),
                      child: Text(
                        'Block List',
                        style: TextStyle(fontSize: 18, color: AppColor.kBackground),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(top: 140),
                  child: Card(
                    color: AppColor.kBackground,
                    elevation: 0.0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: isLoading
                    ? Center(child: ShimmerList()) 
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: blockListData.user!.block!.length,
                        itemBuilder: (context, index) {
                          var blockListInfo = blockListData.user!.block![index];
                          var flag = CountryCodeList.countries.where((element) => element.name.toLowerCase() == blockListInfo.country!.toLowerCase()).toList();
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue, width: 1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.kBackground,
                                    radius: 29.0,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(blockListInfo.avatar.toString()),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  blockListInfo.name.toString(),
                                  style: TextStyle(
                                    color: AppColor.primaryTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Padding(padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(flag[0].flag),
                                    ),
                                    Text(
                                      blockListInfo.country.toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 129, 152, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: (){
                                    unBlockUser(context, blockListInfo.name.toString(), blockListInfo.id.toString());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColor.iconBackground,
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                    ),
                                    child: Text(
                                      'Unblock',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CelebrityProfilePage(
                                        name: blockListInfo.name.toString(),
                                        bio: blockListInfo.bio.toString(),
                                        gender: blockListInfo.gender.toString(),
                                        country: blockListInfo.country.toString(),
                                        avatarUrl: blockListInfo.avatar.toString(),
                                        id: blockListInfo.id.toString(),
                                        galleryImages: blockListInfo.gallery!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Divider(thickness: 1)
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  void unBlockUser(BuildContext context, String name, String id) {
    FavAndBlockListService favAndBlockListService = new FavAndBlockListService();
    CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    showCancelBtn: true,
    text: "Do you want to unblock $name?",
    onConfirmBtnTap: () {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
      favAndBlockListService.addRemoveUser(userId: id, isFavourite: false, method: 'delete').then((value) {
        if (favAndBlockListService.statusCode == 200) {
          setState(() {
            blockListData = value;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'Unblocked $name',
          );
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Failed! Try again',
          );
        }
      });
    });
  }
}

