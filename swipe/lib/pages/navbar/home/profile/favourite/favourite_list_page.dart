import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/favourite_list_model.dart';
import 'package:swipe/pages/navbar/celebrity_list/celebrity_profile_page.dart';
import 'package:swipe/services/fav_and_block_service.dart';
import 'package:swipe/widgets/country_code_list.dart';
import 'package:swipe/services/get_block_and_fav_list_service.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'package:swipe/widgets/shimmer_effect.dart';

class FavouriteListPage extends StatefulWidget {
  const FavouriteListPage({Key? key}) : super(key: key);

  @override
  State<FavouriteListPage> createState() => _FavouriteListPageState();
}

class _FavouriteListPageState extends State<FavouriteListPage> {
  late BlockingAndFavListModel favouriteListData;
  bool isLoading = true;
  String favExtUrl = 'api/favourite';
  @override
  void initState() {
    BlockAndFavListService().fetchDetails(favExtUrl).then((data) {
      setState(() {
        favouriteListData = data;
        isLoading = false;
      });
    });
    super.initState();
  }
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
                        'Favourite list',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColor.kBackground,
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
                  child: Card(
                    color: AppColor.kBackground,
                    elevation: 0.0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: isLoading
                    ? Center(child: ShimmerList()) 
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: favouriteListData.user!.favourite!.length,
                        itemBuilder: (context, index) {
                          var favListInfo = favouriteListData.user!.favourite![index];
                          var flag = CountryCodeList.countries.where((element) => element.name.toLowerCase() == favListInfo.country!.toLowerCase()).toList();
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
                                      backgroundImage: NetworkImage(favListInfo.avatar.toString()),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  favListInfo.name.toString(),
                                  style: TextStyle(
                                    color: AppColor.primaryTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(flag[0].flag),
                                    ),
                                    Text(
                                      favListInfo.country!,
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 129, 152, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: (){
                                    RemoveFromFavorite(context, favListInfo.name.toString(), favListInfo.id.toString());
                                  },
                                  child: Image.asset(
                                    'assets/images/star_yellow.png',
                                    height: 35,
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CelebrityProfilePage(
                                        name: favListInfo.name.toString(),
                                        bio: favListInfo.bio.toString(),
                                        gender: favListInfo.gender.toString(),
                                        country: favListInfo.country.toString(),
                                        avatarUrl: favListInfo.avatar.toString(),
                                        id: favListInfo.id.toString(),
                                        galleryImages: favListInfo.gallery!,
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
  void RemoveFromFavorite(BuildContext context, String name, String id) {
    FavAndBlockListService favAndBlockListService = new FavAndBlockListService();
    CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    showCancelBtn: true,
    text: "Do you want to remove $name from favorite?",
    onConfirmBtnTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
      });
      favAndBlockListService.addRemoveUser(userId: id, isFavourite: true, method: 'delete').then((value) {
        if (favAndBlockListService.statusCode == 200) {
          setState(() {
            favouriteListData = value;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'Removed $name from favorite',
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
