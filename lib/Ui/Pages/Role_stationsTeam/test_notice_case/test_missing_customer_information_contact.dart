import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../bloc/test_bloc/test_information_screen_bloc.dart';
import '../../../../common/service/toast_service.dart';
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

class TestMissingCustomerInformationContact extends StatefulWidget {
  const TestMissingCustomerInformationContact({Key? key}) : super(key: key);

  @override
  _TestMissingCustomerInformationContactState createState() =>
      _TestMissingCustomerInformationContactState();
}

class _TestMissingCustomerInformationContactState
    extends State<TestMissingCustomerInformationContact> {
  List titleList = ["Mr.", "Mrs."];
  String title = "";
  String dob = "";
  bool manual = false;

  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();

  String? postCodeSearch = "";

  @override
  void initState() {
    //Filling previous selected post code from bloc
    var submitAddressMap =
        BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
    postCodeSearch = "${submitAddressMap["post_code"]}";
    emailCont.text = "${submitAddressMap["email"] ?? ""}";
    phoneCont.text = "${submitAddressMap["telephone"] ?? ""}";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
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
              if (postCodeSearch == null || postCodeSearch!.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Enter Postcode');
              } else if (emailCont.text.isNotEmpty &&
                  (emailCont.text.length < 5 ||
                      !emailCont.text.contains('@') ||
                      !emailCont.text.endsWith('.com'))) {
                locator<ToastService>().showValidationMessage(
                    context, 'Please enter a valid email address');
              } else if (phoneCont.text.isNotEmpty &&
                  phoneCont.text.length != 11) {
                locator<ToastService>().showValidationMessage(
                    context, 'Please enter a valid phone number');
              } else {
                BlocProvider.of<TestInfoAddressBloc>(context).add(
                    TestInfoContactButtonEvent(
                        email: emailCont.text ?? '',
                        telephone: phoneCont.text ?? '',
                        postcode: postCodeSearch!,
                        context: context));
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
                        ProgressBarThin(deviceWidth: 8.w, color: primaryColor),
                        Column(
                          children: [
                            Image.asset("Assets/icons/contact.png",
                                width: 25.sp, color: primaryColor),
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
                    // boxtextBold(title: "Postcode"),
                    // MediumSpace(),
                    //
                    // GestureDetector(
                    //   onTap: () {
                    //  //   getFilterData(context);
                    //   },
                    //   child: Container(
                    //     width: 100.w,
                    //     height: 6.4.h,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 2.5.w, vertical: 0.h),
                    //       child: Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           postCodeSearch ?? '',
                    //           style: TextStyle(fontSize: 12.sp),
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SmallSpace(),

                    MediumSpace(),
                    boxtextBold(title: "Email"),
                    SmallSpace(),
                    SizedBox(
                      width: 100.w,
                      height: 5.5.h,
                      child: TextField(
                        controller: emailCont,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        decoration: InputDecoration(
                            hintText: 'Enter Email ',
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
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                  size: 14.sp,
                                ))),
                      ),
                    ),
                    MediumSpace(),
                    boxtextBold(title: "Telephone"),
                    SmallSpace(),
                    SizedBox(
                      width: 100.w,
                      height: 5.5.h,
                      child: TextField(
                        controller: phoneCont,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),
                        decoration: InputDecoration(
                            hintText: 'Enter Telephone Number',
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
                                onTap: () {},
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
