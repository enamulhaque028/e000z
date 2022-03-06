import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_line_bd/model/doctor_category_model.dart';
import 'package:health_line_bd/pages/navbar_patient/doctors/components/all_doctors_tile.dart';
import 'package:health_line_bd/pages/navbar_patient/doctors/components/custom_searchbar.dart';
import 'package:health_line_bd/pages/navbar_patient/doctors/doctor_details_page.dart';

class DoctorListPage extends StatefulWidget {
  final List<DoctorList> doctorListByCategory;
  final List<DoctorList> allDoctorList;
  const DoctorListPage({
    Key key,
    @required this.doctorListByCategory,
    @required this.allDoctorList,
  }) : super(key: key);

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> with SingleTickerProviderStateMixin {
  List<DoctorList> doctorInfoByCategory = [];
  List<DoctorList> displayDoctorInfoByCategory = [];
  List<DoctorList> allDoctorInfo = [];
  List<DoctorList> displayAllDoctorInfo = [];
  final TextEditingController categoryDrController = TextEditingController();
  final TextEditingController allDrController = TextEditingController();
  bool isSearching = false;
  TabController _tabController;
  final ScrollController scrollcontroller = new ScrollController();
  // bool scrollVisibility = true;
  int tabIndex = 0;

  @override
  void initState() {
    setState(() {
      doctorInfoByCategory = widget.doctorListByCategory;
      displayDoctorInfoByCategory = doctorInfoByCategory;
      allDoctorInfo = widget.allDoctorList;
      displayAllDoctorInfo = allDoctorInfo;
    });
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener((){
      setState(() {
        tabIndex = _tabController.index;
      });
      print(tabIndex);
    });
    // scrollcontroller.addListener(() {
    //   if (scrollcontroller.position.pixels > 0) scrollVisibility = false;
    //   else scrollVisibility = true;
    //   log(scrollcontroller.offset.toString());
    //   // setState(() {});
    // });
    super.initState();
  }

  String filterDays(int dayValue) {
    String filteredDay = '';
    if (dayValue == 1) {
      filteredDay = 'sunday';
    } else if (dayValue == 2) {
      filteredDay = 'monday';
    } else if (dayValue == 3) {
      filteredDay = 'tuesday';
    } else if (dayValue == 4) {
      filteredDay = 'wednesday';
    } else if (dayValue == 5) {
      filteredDay = 'thursday';
    } else if (dayValue == 6) {
      filteredDay = 'friday';
    } else if (dayValue == 7) {
      filteredDay = 'saturday';
    } else
      return '';
    return filteredDay;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: [
            Visibility(
              // visible: scrollVisibility,
              child: SizedBox(
                height: 40,
                child: Material(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(text: 'Speciality',),
                        Tab(text: 'All',),
                      ],
                      indicator: ShapeDecoration(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                        color: Colors.white,
                      ),
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                ),
              ),
            ),
            tabIndex == 0
                ? CustomSearchBar(
                    controller: categoryDrController,
                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        displayDoctorInfoByCategory = doctorInfoByCategory.where((value) {
                          var name = value.doctorName.toLowerCase();
                          var degree = value.degree.toString().toLowerCase();
                          var dept = value.departmentName.toString().toLowerCase();
                          var institute = value.instituteName.toString().toLowerCase();
                          var specialityName = value.specialityName.toString().toLowerCase();
                          var sunday = filterDays(value.chamber.sun).toLowerCase();
                          var monday = filterDays(value.chamber.mon).toLowerCase();
                          var tuesday = filterDays(value.chamber.tue).toLowerCase();
                          var wednesday = filterDays(value.chamber.wed).toLowerCase();
                          var thursday = filterDays(value.chamber.thu).toLowerCase();
                          var friday = filterDays(value.chamber.fri).toLowerCase();
                          var saturday = filterDays(value.chamber.sat).toLowerCase();
                          return name.contains(text) || degree.contains(text) || dept.contains(text) || institute.contains(text) || specialityName.contains(text) || sunday.contains(text) || monday.contains(text) || tuesday.contains(text) || wednesday.contains(text) || thursday.contains(text) || friday.contains(text) || saturday.contains(text);
                        }).toList();
                      });
                    },
                  )
                : CustomSearchBar(
                    controller: allDrController,
                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        displayAllDoctorInfo = allDoctorInfo.where((value) {
                          var name = value.doctorName.toLowerCase();
                          var degree = value.degree.toString().toLowerCase();
                          var dept = value.departmentName.toString().toLowerCase();
                          var institute = value.instituteName.toString().toLowerCase();
                          var specialityName = value.specialityName.toString().toLowerCase();
                          var sunday = filterDays(value.chamber.sun).toLowerCase();
                          var monday = filterDays(value.chamber.mon).toLowerCase();
                          var tuesday = filterDays(value.chamber.tue).toLowerCase();
                          var wednesday = filterDays(value.chamber.wed).toLowerCase();
                          var thursday = filterDays(value.chamber.thu).toLowerCase();
                          var friday = filterDays(value.chamber.fri).toLowerCase();
                          var saturday = filterDays(value.chamber.sat).toLowerCase();
                          return name.contains(text) || degree.contains(text) || dept.contains(text) || institute.contains(text) || specialityName.contains(text) || sunday.contains(text) || monday.contains(text) || tuesday.contains(text) || wednesday.contains(text) || thursday.contains(text) || friday.contains(text) || saturday.contains(text);
                        }).toList();
                      });
                    },
                  ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  displayDoctorInfoByCategory.isEmpty
                      ? Center(child: Text('not matched!'))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: displayDoctorInfoByCategory.length,
                          // controller: scrollcontroller,
                          padding: EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                          itemBuilder: (context, index) {
                            var drInfo = displayDoctorInfoByCategory[index];
                            return InkWell(
                              child: AllDoctorTile(
                                imageUrl: drInfo.imgPath.toString(),
                                name: drInfo.doctorName.toString(),
                                speciality: drInfo.specialityName.toString(),
                                degree: drInfo.degree.toString(),
                                institute: drInfo.instituteName.toString(),
                                departmentName: drInfo.departmentName.toString(),
                                rating: '5.5',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDetailsPage(
                                      imageUrl: drInfo.imgPath.toString(),
                                      name: drInfo.doctorName.toString(),
                                      speciality: drInfo.specialityName.toString(),
                                      degree: drInfo.degree.toString(),
                                      department: drInfo.departmentName.toString(),
                                      drNo: drInfo.doctorNo.toString(),
                                      currentChember: drInfo.currentChember.toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                  displayAllDoctorInfo.isEmpty
                      ? Center(child: Text('not matched!'))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: displayAllDoctorInfo.length,
                          // controller: scrollcontroller,
                          padding: EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                          itemBuilder: (context, index) {
                            var drInfo = displayAllDoctorInfo[index];
                            return InkWell(
                              child: AllDoctorTile(
                                imageUrl: drInfo.imgPath.toString(),
                                name: drInfo.doctorName.toString(),
                                speciality: drInfo.specialityName.toString(),
                                degree: drInfo.degree.toString(),
                                institute: drInfo.instituteName.toString(),
                                departmentName: drInfo.departmentName.toString(),
                                rating: '5.5',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDetailsPage(
                                      imageUrl: drInfo.imgPath.toString(),
                                      name: drInfo.doctorName.toString(),
                                      speciality: drInfo.specialityName.toString(),
                                      degree: drInfo.degree.toString(),
                                      department: drInfo.departmentName.toString(),
                                      drNo: drInfo.doctorNo.toString(),
                                      currentChember: drInfo.currentChember.toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}