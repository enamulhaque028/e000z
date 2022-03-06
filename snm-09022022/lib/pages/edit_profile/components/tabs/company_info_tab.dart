import 'package:dil_app/pages/edit_profile/components/profile_text_tile.dart';
import 'package:flutter/material.dart';

class CompanyInfoTab extends StatelessWidget {
  const CompanyInfoTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextTile(
          title: 'Company Name',
          subTitle: 'ATI Limited',
          onTapEdit: () {},
        ),
        ProfileTextTile(
          title: 'Client Name',
          subTitle: 'Birdem Medical College Hospital',
          onTapEdit: () {},
        ),
        ProfileTextTile(
          title: 'Project Name',
          subTitle: 'Attendance Management System',
          onTapEdit: () {},
        ),
        ProfileTextTile(
          title: 'Address',
          subTitle: 'ATI Center, House # 7 Gareeb-e-Nawaz Ave, Dhaka 1230',
          onTapEdit: () {},
        ),
      ],
    );
  }
}
