import 'package:advanced_app_manager/native_service/native_service.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DisplayTab3 extends StatefulWidget {
  const DisplayTab3({
    Key? key,
    required this.packageName,
  }) : super(key: key);

  final String packageName;

  @override
  State<DisplayTab3> createState() => _DisplayTab3State();
}

class _DisplayTab3State extends State<DisplayTab3> {
  bool isLoading = true;
  List activities = [];
  @override
  void initState() {
    NativeApiCall()
        .getNativeData(widget.packageName, 'getActivityList')
        .then((value) {
      setState(() {
        activities =
            value['activities'] == null ? [] : value['activities'] as List;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : activities.isEmpty
            ? const Center(
                child: Text('not found!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return InfoListView(
                    index: index,
                    info: activities[index]['name'].toString(),
                  );
                },
              );
  }
}
