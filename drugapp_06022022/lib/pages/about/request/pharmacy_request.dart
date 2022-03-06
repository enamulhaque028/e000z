import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/helper/custom_progress.dart';
import 'package:mediinfo/pages/about/request/components/dragable_send_button.dart';
import 'package:mediinfo/pages/about/request/components/dropdown/pharmacy_dropdown.dart';
import 'package:mediinfo/pages/about/request/components/image_picker.dart';
import 'package:mediinfo/pages/about/request/components/dropdown/dropdown_view.dart';
import 'package:mediinfo/services/web/pharmacy_request_service.dart';
import 'components/text_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cool_alert/cool_alert.dart';

Future requestDialog(BuildContext context) {
  return showDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) => PharmacyRequest(),
  );
}

class PharmacyRequest extends StatefulWidget {
  const PharmacyRequest({
    Key key,
  }) : super(key: key);

  @override
  _PharmacyRequestState createState() => _PharmacyRequestState();
}

class _PharmacyRequestState extends State<PharmacyRequest> {
  TextEditingController ownerNameController = new TextEditingController();
  TextEditingController pharmacyNameController = new TextEditingController();
  TextEditingController lisenceNoController = new TextEditingController();
  TextEditingController regiNoNameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController addressLocationController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController telephoneNumberController = new TextEditingController();
  TextEditingController recommendationController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool isApiCallProcess = false;
  bool isVisibleAttatchments = false;
  // String address = '';
  final GlobalKey _parentKey = GlobalKey();

  double latitude = 0.0;
  double longitude = 0.0;
  double altitude = 0.0;
  double accuracy = 0.0;

  Future<Position> getCurrentLocationAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = res.latitude;
      longitude = res.longitude;
      altitude = res.altitude;
      accuracy = res.accuracy;
    });
    log('Lat: ${res.latitude.toString()} Long: ${res.longitude.toString()}');
    List<Placemark> placemarks =
        await placemarkFromCoordinates(res.latitude, res.longitude);
    // log('Address: ${placemarks.map((e) => e.street)}');
    String geoAddress = placemarks.map((e) => e.street).toString();
    String formattedGeoAddress = geoAddress.substring(1, geoAddress.length - 1);
    setState(() {
      addressLocationController.text = formattedGeoAddress;
    });
    return res;
  }

  @override
  void initState() {
    PickImages.pharmacyImgPath = '';
    PickImages.visitingCardImgPath = '';
    PickImages.otherImgPath = '';
    DropDownView.selectedDivisions = null;
    DropDownView.selectedDistrict = null;
    PharmacyDropDown.selectedPharmacy = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Stack(
          key: _parentKey,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, bottom: 10.0, right: 5.0),
                            child: Image.asset(
                              'assests/images/drug.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'newPharmacyRequest.title'
                                    .tr()
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(PrimaryColor),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        // ignore: deprecated_member_use
                        autovalidate: _autoValidate,
                        child: Column(
                          children: [
                            CustomTextField(
                              textFieldController: pharmacyNameController,
                              labelText: 'newPharmacyRequest.pharmacyName'
                                  .tr()
                                  .toString(),
                            ),
                            CustomTextField(
                              textFieldController: ownerNameController,
                              labelText: 'newPharmacyRequest.ownerName'
                                  .tr()
                                  .toString(),
                            ),
                            CustomTextField(
                              textFieldController: lisenceNoController,
                              labelText: 'newPharmacyRequest.licenseNo'
                                  .tr()
                                  .toString(),
                              isRequiredValidation: true,
                            ),
                            CustomTextField(
                              textFieldController: regiNoNameController,
                              labelText: 'newPharmacyRequest.pnameAndRegNo'
                                  .tr()
                                  .toString(),
                              isRequiredValidation: false,
                            ),
                            CustomTextFieldMobile(
                              textFieldController: mobileNumberController,
                              labelText:
                                  'newPharmacyRequest.mobileNo'.tr().toString(),
                            ),
                            CustomTextField(
                              textFieldController: telephoneNumberController,
                              labelText: 'newPharmacyRequest.telephoneNo'
                                  .tr()
                                  .toString(),
                              isRequiredValidation: false,
                            ),
                            CustomTextField(
                              textFieldController: addressController,
                              labelText:
                                  'newPharmacyRequest.pAddress'.tr().toString(),
                            ),
                            DropDownView(),
                            CustomTextField(
                              textFieldController: addressLocationController,
                              labelText: 'newPharmacyRequest.pLocationAddess'
                                  .tr()
                                  .toString(),
                              disableTextField: true,
                              onTapLocation: () {
                                setState(() {
                                  addressLocationController.text =
                                      'calculating.......';
                                });
                                getCurrentLocationAddress().then((value) => log(
                                    'Your address: ${addressLocationController.text}'));
                              },
                            ),
                            CustomTextField(
                              textFieldController: recommendationController,
                              maxLines: 5,
                              labelText: 'newPharmacyRequest.recommendation'
                                  .tr()
                                  .toString(),
                              isRequiredValidation: false,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            trailing: Icon(Icons.attachment),
                            title: Text(
                              'newPharmacyRequest.attatchment'.tr().toString(),
                            ),
                            onTap: () {
                              setState(() {
                                isVisibleAttatchments = !isVisibleAttatchments;
                              });
                            },
                          ),
                        ),
                      ),
                      isVisibleAttatchments
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: cViolet),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  PickImages(imageType: 'shop'),
                                  PickImages(imageType: 'card'),
                                  PickImages(imageType: 'other'),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            DraggableFloatingActionButton(
              initialOffset: Offset(width * 0.65, height * 0.7),
              parentKey: _parentKey,
              onPressed: () {
                String pharmacyImgPath = PickImages.pharmacyImgPath;
                String visitingCardImgPath = PickImages.visitingCardImgPath;
                String otherImgPath = PickImages.otherImgPath;
                if (_formKey.currentState.validate()) {
                  print('Profile Image: $pharmacyImgPath');
                  print('Signature Image: $visitingCardImgPath');
                  print('Other Image: $otherImgPath');
                  setState(() {
                    isApiCallProcess = true;
                  });
                  PharmacyRequestService()
                      .sendRequest(
                          pharmacyName: pharmacyNameController.text,
                          ownerName: ownerNameController.text,
                          lisenceNo: lisenceNoController.text,
                          pharmacistNameAndRegNo: regiNoNameController.text,
                          mobileNo: mobileNumberController.text,
                          telephoneNo: telephoneNumberController.text,
                          pharmacyAddress: addressController.text,
                          divisionName: DropDownView.selectedDivisions,
                          districtName: DropDownView.selectedDistrict,
                          pharmacyCategory: PharmacyDropDown.selectedPharmacy,
                          latitude: latitude.toString(),
                          longitude: longitude.toString(),
                          altitude: altitude.toString(),
                          accuracy: accuracy.toString(),
                          locationAddress: addressLocationController.text,
                          recommendation: recommendationController.text,
                          pharmacyImgPath: pharmacyImgPath,
                          visitingCardImgPath: visitingCardImgPath,
                          otherImgPath: otherImgPath)
                      .then((value) {
                    if (value['code'].toString() == '201') {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      CoolAlert.show(
                        context: context,
                        // width: 350,
                        type: CoolAlertType.success,
                        text: "Request send successful!",
                      );
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Update failed! Please try again'),
                      ));
                    }
                  });
                  _formKey.currentState.save();
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
