import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_line_bd/pages/navbar_patient/doctors/components/custom_searchbar.dart';
import 'components/all_doctors_tile.dart';
import 'doctor_details_page.dart';

class AllDoctorsPage extends StatelessWidget {
  const AllDoctorsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: [
            CustomSearchBar(
              controller: controller,
              onChanged: (val) {},
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  padding:
                      EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 8),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: AllDoctorTile(
                        imageUrl:
                            'https://raw.githubusercontent.com/ezatechbd/data/master/img/doctor.png',
                        name: 'Dr. Moushumi Sanyal',
                        speciality: 'Cardiologist specialist',
                        degree: 'MBBS, MS(CVTS)',
                        institute: '5 Years Experience',
                        departmentName: 'Dept of Cardilogy',
                        rating: '5.5',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailsPage(
                              imageUrl:
                                  'https://raw.githubusercontent.com/ezatechbd/data/master/img/doctor.png',
                              name: 'Dr. Moushumi Sanyal',
                              speciality: 'Cardiology specialist',
                              degree: 'MBBS',
                              department: 'Health Care',
                              currentChember: '',
                              drNo: '',
                            ),
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
