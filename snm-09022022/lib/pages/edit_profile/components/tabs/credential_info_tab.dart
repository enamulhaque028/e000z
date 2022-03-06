import 'package:dil_app/pages/edit_profile/components/profile_text_tile.dart';
import 'package:flutter/material.dart';

class CredentialInfoTab extends StatelessWidget {
  const CredentialInfoTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextTile(
          title: 'Password',
          subTitle: '**********',
          onTapEdit: () {},
        ),
        ProfileTextTile(
          title: 'Account Ownership and Control',
          subTitle: 'Disable Your Account',
          onTapEdit: () {},
        ),
      ],
    );
  }
}
