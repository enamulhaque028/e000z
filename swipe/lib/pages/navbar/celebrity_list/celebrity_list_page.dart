import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/user_details_model.dart';
import 'package:swipe/pages/navbar/celebrity_list/celebrity_profile_page.dart';
import 'package:swipe/services/user_details_service.dart';
import 'package:swipe/widgets/country_code_list.dart';
import 'package:swipe/widgets/shimmer_effect.dart';
import 'components/celebrity_list_tile.dart';

class CelebrityListPage extends StatefulWidget {
  @override
  State<CelebrityListPage> createState() => _CelebrityListPageState();
}

class _CelebrityListPageState extends State<CelebrityListPage> {
  late UserDetailsModel celebrityData;
  List<User> celebrity = [];
  List<User> displayCelebrity = [];
  bool isLoading = true;
  @override
  void initState() {
    UserDetailsService().fetchUserDetails(isCelebrity: true).then((data) {
      setState(() {
        celebrityData = userDetailsModelFromJson(data);
        celebrity = celebrityData.celebrities!;
        displayCelebrity = celebrity;
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var top = MediaQuery.of(context).viewInsets.top;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverPadding(
              padding: EdgeInsets.only(top: top),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Stack(
                      children: [
                        Image.asset('assets/images/bg.png', fit: BoxFit.cover, height: 180, width: size.width),
                        Positioned(
                          top: 82,
                          child: Container(
                            width: size.width,
                            child: Center(
                              child: Text(
                                'Celebrity list',
                                style: TextStyle(fontSize: 18, color: AppColor.kBackground),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: isLoading
          ? Center(child: ShimmerList())
          : Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 10),
                    height: 90,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Search by name",
                        hintStyle: TextStyle(color: AppColor.primaryTextColor),
                        labelStyle: TextStyle(color: AppColor.primaryTextColor, fontSize: 15,),
                        prefixIcon: Icon(Icons.search, color: Colors.blue, size: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(width: 0, style: BorderStyle.none),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (text) {
                        text = text.toLowerCase();
                        setState(() {
                          displayCelebrity = celebrity.where((value) {
                          var name = value.name.toString().toLowerCase();
                          var country = value.country.toString().toLowerCase();
                          var gender = value.gender.toString().toLowerCase();
                          return name.contains(text) || country.contains(text) || gender.contains(text);
                          }).toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: isPortrait ? 1.0 : 1.5,
                      ),
                      shrinkWrap: true,
                      itemCount: displayCelebrity.length,
                      itemBuilder: (context, index) {
                        var celebrityInfo = displayCelebrity[index];
                        var flag = CountryCodeList.countries.where((element) => element.name.toLowerCase() == celebrityInfo.country!.toLowerCase()).toList();
                        return CelebrityListTile(
                          status: "Online",
                          profileImgUrl: celebrityInfo.avatar.toString(),
                          name: celebrityInfo.name.toString(),
                          flagUrl: flag[0].flag,
                          country: celebrityInfo.country.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CelebrityProfilePage(
                                  name: celebrityInfo.name.toString(),
                                  bio: celebrityInfo.bio.toString(),
                                  gender: celebrityInfo.gender.toString(),
                                  country: celebrityInfo.country.toString(),
                                  avatarUrl: celebrityInfo.avatar.toString(),
                                  id: celebrityInfo.id.toString(),
                                  galleryImages: celebrityInfo.gallery!,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
