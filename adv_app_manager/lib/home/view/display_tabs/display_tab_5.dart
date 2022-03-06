import 'package:advanced_app_manager/native_service/native_service.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DisplayTab5 extends StatefulWidget {
  const DisplayTab5({
    Key? key,
    required this.packageName,
  }) : super(key: key);

  final String packageName;

  @override
  State<DisplayTab5> createState() => _DisplayTab5State();
}

class _DisplayTab5State extends State<DisplayTab5> {
  bool isLoading = true;
  List receivers = [];
  @override
  void initState() {
    NativeApiCall()
        .getNativeData(widget.packageName, 'getReceiverList')
        .then((value) {
      setState(() {
        receivers =
            value['receivers'] == null ? [] : value['receivers'] as List;
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
        : receivers.isEmpty
            ? const Center(
                child: Text('not found!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: receivers.length,
                itemBuilder: (context, index) {
                  return InfoListView(
                    index: index,
                    info: receivers[index]['name'].toString(),
                  );
                },
              );
  }
}
