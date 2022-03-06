import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/services/add_diamond_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/custom_text_button.dart';

class SetDiamondDialog extends StatefulWidget {
  final String assetIconPath;
  final String title;
  final String diamondType;

  const SetDiamondDialog({
    Key? key,
    required this.assetIconPath,
    required this.title,
    required this.diamondType,
  }) : super(key: key);

  @override
  State<SetDiamondDialog> createState() => _SetDiamondDialogState();
}

class _SetDiamondDialogState extends State<SetDiamondDialog> {
  int diamondNo = 20;
  bool isApiCallProcess = false;
  AddDiamondService addDiamondService = new AddDiamondService();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 32),
              decoration: BoxDecoration(
                color: AppColor.iconBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        widget.assetIconPath,
                        height: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 32, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/diamond_blue.png',
                        height: 28,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Set Diamond/minutes',
                        style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (diamondNo >= 2) diamondNo--;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  '—',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.secondaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: AppColor.iconBackground,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(
                                  child: Text(
                                    diamondNo.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  diamondNo++;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.secondaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: SizedBox(
                          width: 80,
                          height: 40,
                          child: CustomTextButton(
                            title: 'OK',
                            onTapBtn: () {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              addDiamondService
                                  .addDiamond(
                                      diamondNo: diamondNo,
                                      diamondType: widget.diamondType)
                                  .then((value) {
                                if (addDiamondService.statusCode == 200) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                          Navigator.of(context).pop();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: value['message'],
                                  );
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: 'Failed! Try again',
                                  );
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
