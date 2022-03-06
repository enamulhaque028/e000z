import 'package:advanced_app_manager/native_service/native_service.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DisplayTab4 extends StatefulWidget {
  const DisplayTab4({
    Key? key,
    required this.packageName,
  }) : super(key: key);

  final String packageName;

  @override
  State<DisplayTab4> createState() => _DisplayTab4State();
}

class _DisplayTab4State extends State<DisplayTab4> {
  bool isLoading = true;
  List providers = [];
  @override
  void initState() {
    NativeApiCall()
        .getNativeData(widget.packageName, 'getProviderList')
        .then((value) {
      setState(() {
        providers =
            value['providers'] == null ? [] : value['providers'] as List;
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
        : providers.isEmpty
            ? const Center(
                child: Text('not found!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: providers.length,
                itemBuilder: (context, index) {
                  return InfoListView(
                    index: index,
                    info: providers[index]['authority'].toString(),
                  );
                },
              );
  }
}
