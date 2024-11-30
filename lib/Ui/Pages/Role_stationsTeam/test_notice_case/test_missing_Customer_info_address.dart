import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/test_notice_case/test_missing_customer_information_contact.dart';

import 'package:railpaytro/Ui/Utils/Colors.dart';

import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../data/model/ufn/FullAddressListModel.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Utils/defaultPadiing.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/TextWidgets.dart';
import '../../../Widgets/TopBarwithTitle.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../Lookup/postcode_search.dart';
import 'package:sizer/sizer.dart';

class MissingCustomerInformationAddressTest extends StatefulWidget {
  const MissingCustomerInformationAddressTest({Key? key}) : super(key: key);

  @override
  _MissingCustomerInformationAddressTestState createState() =>
      _MissingCustomerInformationAddressTestState();
}

class _MissingCustomerInformationAddressTestState
    extends State<MissingCustomerInformationAddressTest> {
  List titleList = ["Mr.", "Mrs."];
  String title = "";
  String dob = "";
  bool manual = false;

  TextEditingController addressOne = TextEditingController();
  TextEditingController addressTwo = TextEditingController();
  TextEditingController city = TextEditingController();
  DataFullAddress? dataFullAddress;
  TextEditingController postController = TextEditingController();

  bool addresEn = true;
  bool addres2En = true;
  bool cityEn = true;
  String postCodeSearch = "";

  Future<void> getFilterData(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostCodeSearch()));
    setState(() {
      if (result.toString() != "null") {
        dataFullAddress = result as DataFullAddress;
        addresEn = false;
        addres2En = false;
        cityEn = false;
        addressOne.text = dataFullAddress!.line1.toString();
        addressTwo.text = dataFullAddress!.line2.toString();
        city.text = dataFullAddress!.city.toString();
        var id = dataFullAddress!.id.toString();
        postCodeSearch = dataFullAddress!.postalcode.toString();
      } else {
        dataFullAddress = null;
      }
    });
  }

  @override
  void initState() {
    //Filling previous selected post code from bloc
    var submitAddressMap =
        BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
    postCodeSearch = "${submitAddressMap["post_code"]}";
    addressOne.text = "${submitAddressMap["address_1"] ?? ""}";
    addressTwo.text = "${submitAddressMap["address_2"] ?? ""}";
    city.text = "${submitAddressMap["locality"] ?? ""}";

    super.initState();
  }

  openErrorDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Warning',
                  ),
                )),
            content: subheadingText(
                title: "Enter postcode and select address from the list.."),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "Assets/icons/cross.png",
                    width: 4.w,
                  )),
              SizedBox(
                height: 8.h,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 50.w,
                height: 6.8.h,
                color: secondryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    subheadingTextBOLD(title: " Go Back")
                  ],
                ),
              )),
          InkWell(
            onTap: () {
              if (postCodeSearch != "") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const TestMissingCustomerInformationContact()));
              } else {
                openErrorDialog(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(15),
              width: 50.w,
              height: 6.8.h,
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  subheadingTextBOLD(title: "Continue "),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      backgroundColor: secondryColor,
      body: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: gradientDecoration,
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(deviceWidth: 10.w, color: primaryColor),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),

                          /* const SizedBox(
                                              width: 10,
                                            ),
                                            ProgressBox(deviceWidth: deviceWidth, color: primaryColor),*/
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    headingText(title: "Customer Information"),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProgressBarThin(deviceWidth: 8.w, color: primaryColor),
                        Column(
                          children: [
                            Image.asset("Assets/icons/user.png",
                                width: 25.sp, color: primaryColor),
                            SizedBox(
                              height: .3.h,
                            ),
                            subheadingText(title: "Personal")
                          ],
                        ),
                        ProgressBarThin(deviceWidth: 8.w, color: primaryColor),
                        Column(
                          children: [
                            Image.asset(
                              "Assets/icons/pin.png",
                              width: 25.sp,
                              color: primaryColor,
                            ),
                            SizedBox(
                              height: .3.h,
                            ),
                            subheadingText(title: "Address")
                          ],
                        ),
                        ProgressBarThin(deviceWidth: 8.w, color: blueGrey),
                        Column(
                          children: [
                            Image.asset("Assets/icons/contact.png",
                                width: 25.sp, color: blueGrey),
                            SizedBox(
                              height: .3.h,
                            ),
                            subheadingText(title: "Contact")
                          ],
                        ),
                        ProgressBarThin(deviceWidth: 8.w, color: blueGrey),
                      ],
                    ),
                    LargeSpace(),
                    LargeSpace(),
                    boxtextBold(
                      title: "Postcode",
                    ),
                    SmallSpace(),
                    GestureDetector(
                      onTap: () {
                        getFilterData(context);
                      },
                      child: Container(
                        width: 100.w,
                        height: 5.5.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w, vertical: 0.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              postCodeSearch == ""
                                  ? ""
                                  : postCodeSearch.toString(),
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: "railLight"),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                    LargeSpace(),
                    boxtextBold(title: "Address Line 1"),
                    SmallSpace(),
                    SizedBox(
                      width: 100.w,
                      height: 5.5.h,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        controller: addressOne,
                        // enabled: addresEn,
                        decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: white,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   addresEn!=addresEn;
                                  // });
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                  size: 14.sp,
                                ))),
                      ),
                    ),
                    LargeSpace(),
                    boxtextBold(title: "Address Line 2"),
                    SmallSpace(),
                    SizedBox(
                      width: 100.w,
                      height: 5.5.h,
                      child: TextField(
                        controller: addressTwo,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: white,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   addres2En=!addres2En;
                                  // });
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                  size: 14.sp,
                                ))),
                      ),
                    ),
                    LargeSpace(),
                    boxtextBold(title: "Town / City"),
                    SmallSpace(),
                    Container(
                      width: 100.w,
                      height: 5.5.h,
                      child: TextField(
                        controller: city,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: white,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //
                                  //   cityEn=!cityEn;
                                  // });
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                  size: 14.sp,
                                ))),
                      ),
                    ),
                    SmallSpace(),
                    MediumSpace(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Test Notice ", icon: "Assets/icons/warning.png")),
        ],
      ),
    );
  }
}
