import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Lookup/postcode_search.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import '../../../../common/Utils/utils.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/backButton.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../data/model/ufn/FullAddressListModel.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/SpaceWidgets.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import 'missing_customer_information_personal.dart';

class AddressCapture extends StatefulWidget {
  @override
  _AddressCaptureState createState() => _AddressCaptureState();
}

class _AddressCaptureState extends State<AddressCapture> {
  String menu = "";
  List<String> customerLanguages = ["English", "Welsh/Cymraeg"];
  String selectLang = "";

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

  openErrorDialogForVerication(BuildContext context) async {
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
            content: subheadingText(title: "App is offline."),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 30.w,
                    height: 5.5.h,
                    color: primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [subheadingTextBOLD(title: "OK")],
                    ),
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
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<AddressUfnBloc>(context).submitAddressMap.clear();

          Navigator.pop(context, false);

          return Future.value(false);
        },
        child: Scaffold(
          bottomNavigationBar: backButton(),
          drawer: const DrawerWidget(),
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
                            ProgressBar(deviceWidth: 10.w, color: primaryColor),
                            ProgressBar(deviceWidth: 10.w, color: blueGrey),
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
                      headingText(
                          title: "The address details have been captured  "),
                      LargeSpace(),
                      subheadingText(title: "How do you wish to proceed ?"),
                      LargeSpace(),
                      LargeSpace(),
                      LargeSpace(),
                      LargeSpace(),
                      Container(
                        height: 8.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () async {
                            bool checkInternet = await Utils.checkInternet();
                            if (checkInternet) {
                              BlocProvider.of<AddressUfnBloc>(context)
                                  .add(AddressUfnIdentityCheck(context));
                            } else {
                              openErrorDialogForVerication(context);
                            }
                          },
                          child: Text(
                            "Attempt Verification",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "railLight"),
                          ),
                        ),
                      ),
                      LargeSpace(),
                      Container(
                        height: 8.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MissingCustomerInformationPersona()));
                          },
                          child: Text(
                            "Proceed without Verification",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "railLight"),
                          ),
                        ),
                      ),
                      LargeSpace(),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: TopHeaderCase(
                      title: "Unpaid Fare Notice (LUMO) ",
                      icon: "Assets/icons/bandge.png")),
            ],
          ),
        ));
  }
}
