import 'package:flutter/material.dart';

class ProfileTextTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTapEdit;
  final bool isVisibleEdit;
  const ProfileTextTile({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.onTapEdit,
    this.isVisibleEdit = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: size.width - 80,
                child: Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: isVisibleEdit,
            child: InkWell(
              onTap: () => onTapEdit(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
