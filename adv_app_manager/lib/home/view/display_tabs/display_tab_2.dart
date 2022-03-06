import 'package:advanced_app_manager/native_service/native_service.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DisplayTab2 extends StatefulWidget {
  const DisplayTab2({
    Key? key,
    required this.packageName,
  }) : super(key: key);

  final String packageName;

  @override
  State<DisplayTab2> createState() => _DisplayTab2State();
}

class _DisplayTab2State extends State<DisplayTab2> {
  bool isLoading = true;
  List requestedPermissions = [];
  List requestedPermissionsFlags = [];
  @override
  void initState() {
    NativeApiCall()
        .getNativeData(widget.packageName, 'getPermissionList')
        .then((value) {
      setState(() {
        requestedPermissions = value['requestedPermissions'] as List;
        requestedPermissionsFlags = value['requestedPermissionsFlags'] as List;
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
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: requestedPermissions.length,
            itemBuilder: (context, index) {
              return InfoListView(
                index: index,
                info: requestedPermissions[index].toString(),
              );
            },
          );
  }
}


// ListView.builder(
//             // separatorBuilder: (BuildContext context, int index) =>
//             //     const Divider(),
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             itemCount: requestedPermissions.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Clipboard.setData(
//                     ClipboardData(
//                       text: requestedPermissions[index].toString(),
//                     ),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('copied to clipboard'),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(4)),
//                       color: index % 2 == 0
//                           ? const Color(0xFFF0F4F8)
//                           : Colors.transparent,
//                     ),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Image.asset(
//                             'assets/images/arrow.png',
//                             height: 24,
//                             width: 24,
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.90 - 78,
//                           child: Text(
//                             requestedPermissions[index].toString(),
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ),
//                         // ignore: unrelated_type_equality_checks, prefer_if_elements_to_conditional_expressions
//                         // requestedPermissionsFlags[index] == 1
//                         //     ? Container(
//                         //         padding: const EdgeInsets.all(6),
//                         //         decoration: BoxDecoration(
//                         //           color: Colors.blueAccent.shade400,
//                         //           shape: BoxShape.circle,
//                         //         ),
//                         //         child: const Icon(
//                         //           Icons.done_sharp,
//                         //           size: 12,
//                         //           color: Colors.white,
//                         //         ),
//                         //       )
//                         //     : Container(),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );