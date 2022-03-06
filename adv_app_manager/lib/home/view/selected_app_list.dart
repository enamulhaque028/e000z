import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:flutter/material.dart';

class SelectedAppListTile extends StatefulWidget {
  const SelectedAppListTile({
    Key? key,
    required this.appIcon,
    required this.appName,
    required this.appSize,
    required this.appUpdate,
  }) : super(key: key);

  final String appIcon;
  final String appName;
  final String appSize;
  final String appUpdate;

  @override
  _SelectedAppListTileState createState() => _SelectedAppListTileState();
}

class _SelectedAppListTileState extends State<SelectedAppListTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Card(
        color: AppColor.kSearchBarColor,
        elevation: 0.0,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Image.asset(widget.appIcon, height: 60, width: 60),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.appName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.appSize,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '  ● Updated on ${widget.appUpdate}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: const Icon(Icons.circle_outlined, color: Colors.black26),
        ),
      ),
    );
  }
}
