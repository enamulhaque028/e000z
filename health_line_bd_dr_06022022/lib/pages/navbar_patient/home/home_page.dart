import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:health_line_bd/model/doctor_category_model.dart';
import 'package:health_line_bd/model/video_model.dart';
import 'package:health_line_bd/services/doctor_category_service.dart';
import 'package:health_line_bd/pages/navbar_patient/home/view/speciality/doctor_list_page.dart';
import 'package:health_line_bd/services/notification_service.dart';
import 'package:health_line_bd/services/video_service.dart';
import 'components/title_widget.dart';
import 'view/speciality/doctor_speciality.dart';
import 'view/popular_doctor.dart';
import 'view/prescription/prescription_page.dart';
import 'view/tips_and_tricks.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DoctorCategoryModel doctorCategoryData = new DoctorCategoryModel();
  bool isLoadingDoctorCategory = true;

  VideoModel videoData = new VideoModel();
  bool isLoadingVideo = true;

  @override
  void initState() {
    VideoService().fetchVideoInfo().then((video) {
      setState(() {
        videoData = video;
        isLoadingVideo = false;
      });
    });
    DoctorCategoryService().fetchDoctorCategory().then((category) {
      setState(() {
        doctorCategoryData = category;
        isLoadingDoctorCategory = false;
      });
    });
    super.initState();
  }

  List<DoctorList> getAllDrList() {
    List<DoctorList> allDoctor = [];
    for (int i = 0; i < doctorCategoryData.listResponse.length; i++) {
      for (int j = 0; j < doctorCategoryData.listResponse[i].doctorList.length; j++) {
        allDoctor.add(doctorCategoryData.listResponse[i].doctorList[j]);
      }
    }
    return allDoctor;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      // appBar: AppBar(
      //   title: Text('HealthLine BD'),
      //   backgroundColor: cViolet.withOpacity(0.7),
      //   brightness: Brightness.dark,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Popular Doctors
              InkWell(
                onTap: () async {
                  await AndroidAlarmManager.periodic(
                    const Duration(seconds: 10),
                    0,
                    fireAlarm,
                    wakeup: true,
                    rescheduleOnReboot: true,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrescriptionPage(),
                    ),
                  );
                  // print(allDoctor.map((e) => e));
                },
                child: TitleWidget(
                  title: 'homePage.title1'.tr().toString(),
                ),
              ),
              Container(
                height: 250,
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 10),
                    itemBuilder: (context, index) {
                      return PopularDoctors(
                        imageUrl:
                            'https://raw.githubusercontent.com/ezatechbd/data/master/img/doctor.png',
                        name: 'Dr. Mousumi Sanyal',
                        speciality: 'Heart Specialist',
                        degree: 'MBBS, MS(CVTS)',
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                      );
                    }),
              ),

              //Tips and Tricks
              SizedBox(height: 10),
              TitleWidget(
                title: 'homePage.title2'.tr().toString(),
              ),
              isLoadingVideo
                  ? Center(
                      child: Image.asset(
                        'assets/images/loader.gif',
                        height: 100,
                      ),
                    )
                  : Container(
                      height: 170,
                      child: ListView.builder(
                          itemCount: videoData.listResponse.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 10),
                          itemBuilder: (context, index) {
                            var videoInfo = videoData.listResponse[index];
                            return TipsAndTricks(
                              videoUrl: videoInfo.videoUrl,
                              videoTitle: videoInfo.videoTitle,
                              videoDuration: videoInfo.videoDuration,
                            );
                          }),
                    ),

              //Doctor Speciality
              SizedBox(height: 8),
              TitleWidget(
                title: 'homePage.title3'.tr().toString(),
              ),
              isLoadingDoctorCategory
                  ? Center(
                      child: Image.asset(
                        'assets/images/loader.gif',
                        height: 100,
                      ),
                    )
                  : Container(
                      height: 195,
                      child: ListView.builder(
                          itemCount: doctorCategoryData.listResponse.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          itemBuilder: (context, index) {
                            var info = doctorCategoryData.listResponse[index];
                            return InkWell(
                              child: DoctorSpeciality(
                                speciallityNo: info.speciallityNo.toString(),
                                title: info.speciality,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorListPage(
                                      doctorListByCategory: info.doctorList,
                                      allDoctorList: getAllDrList(),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
