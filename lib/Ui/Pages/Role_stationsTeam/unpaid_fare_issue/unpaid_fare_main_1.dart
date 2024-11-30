import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Lookup/postcode_search.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_issue/address_capture.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import '../../../../bloc/printer_bloc/printer_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/image_submit_bloc.dart';
import '../../../../common/Utils/utils.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import '../../../../common/service/printing_service.dart';
import '../../../../common/service/toast_service.dart';
import '../../../../constants/app_utils.dart';
import '../../../../data/model/ufn/FullAddressListModel.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/SpaceWidgets.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class UnpaidFare extends StatefulWidget {
  String issueTitle;

  UnpaidFare(this.issueTitle, {Key? key}) : super(key: key);

  @override
  _UnpaidFareState createState() => _UnpaidFareState();
}

class _UnpaidFareState extends State<UnpaidFare> {
  bool isPrinterConnected(BuildContext context) {
    final printerBloc = BlocProvider.of<PrinterBloc>(context);
    return printerBloc.status == "Connected";
  }
  getprinterConnnected(){
    connectToPrinterIfNotConnected(context);
  }

  connectToPrinterIfNotConnected(BuildContext context) async {
    if (!isPrinterConnected(context)) {
      String printType = await AppUtils().getPrinterId();
      if (printType != null && printType != "") {
        locator<PrintingService>().connectToPrinter(printType);
      }
    }
  }
  String menu = "";
  List<String> customerLanguages = ["English", "Welsh/Cymraeg"];
  String selectLang = "English";

  TextEditingController addressOne = TextEditingController();
  TextEditingController addressTwo = TextEditingController();
  TextEditingController city = TextEditingController();
  DataFullAddress? dataFullAddress;
  TextEditingController postController = TextEditingController();

  bool addresEn = true;
  bool addres2En = true;
  bool cityEn = true;
  String postCodeSearch = "";
  bool checkInternet = false;

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
                title:
                    "Enter Post Code and select correct address from the list"),
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

  Future<void> getFilterData(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostCodeSearch()));
    setState(() {
      if (result.toString().contains("timeout") &&
          result[1].toString().isNotEmpty) {
        setState(() {
          postCodeSearch = result[1].toString();
        });
      } else if (result.toString().contains("timeout")) {
        checkInternet = false;
      } else if (result.toString() != "null") {
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
    getprinterConnnected();
    getValue();
    // TODO: implement initState
    super.initState();
  }

  getValue() async {
    bool check = await Utils.checkInternet();
    setState(() {
      checkInternet = check;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<AddressUfnBloc>(context).submitAddressMap.clear();
          BlocProvider.of<AddressUfnBloc>(context).mapAddress.clear();

          Navigator.pop(context, false);

          return Future.value(false);
        },
        child: Scaffold(
          drawer: const DrawerWidget(),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    BlocProvider.of<AddressUfnBloc>(context)
                        .submitAddressMap
                        .clear();
                    BlocProvider.of<ImageSubmitBloc>(context)
                        .imageMapList
                        .clear();
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
                  if (postCodeSearch == "") {
                    locator<ToastService>().showValidationMessage(context,
                        ' Enter Post Code and select correct address from the list');
                  } else if (addressOne.text.isEmpty) {
                    locator<ToastService>().showValidationMessage(
                        context, ' Please Enter Address Line 1');
                  } else if (city.text.isEmpty) {
                    locator<ToastService>().showValidationMessage(
                        context, ' Please Enter Town/City');
                  } else {
                    BlocProvider.of<AddressUfnBloc>(context).add(
                        OfflineAddressSavedEvent(
                            context,
                            postCodeSearch,
                            addressOne.text,
                            addressTwo.text,
                            city.text,
                            selectLang));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressCapture()));
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
          body: SingleChildScrollView(
            child: Stack(
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
                                  deviceWidth: 10.w, color: primaryColor),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            headingText(title: "Customer Information  "),
                            IconButton(
                              iconSize: 35,
                              icon: const Icon(
                                Icons.info_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                openErrorDialog(context);
                              },
                            ),
                          ],
                        ),
                        LargeSpace(),
                        LargeSpace(),
                        boxtextBold(
                          title: "Post Code",
                        ),
                        SmallSpace(),
                        checkInternet
                            ? GestureDetector(
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
                                            ? "Enter Post Code"
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
                              )
                            : SizedBox(
                                width: 100.w,
                                height: 5.5.h,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black,
                                      fontFamily: "railLight"),
                                  onChanged: (v) {
                                    setState(() {
                                      postCodeSearch = v.toString();
                                    });
                                    log(postCodeSearch.toString());
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter Post Code Search',
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
                            decoration: InputDecoration(
                                hintText: 'e.g House Number or Name',
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
                        LargeSpace(),
                        boxtextBold(title: "Address Line 2"),
                        SmallSpace(),
                        SizedBox(
                          width: 100.w,
                          height: 5.5.h,
                          child: TextField(
                            controller: addressTwo,
                            enabled: addres2En,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontFamily: "railLight"),
                            decoration: InputDecoration(
                                hintText: 'e.g Street Name',
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
                                      setState(() {
                                        addres2En = !addres2En;
                                      });
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
                                hintText: 'Enter town or city name...',
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
                                      //   cityEn = !cityEn;
                                      // });
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.red,
                                      size: 14.sp,
                                    ))),
                          ),
                        ),
                        MediumSpace(),
                        boxtextBold(title: "Customer Language"),
                        SmallSpace(),
                        Container(
                          width: 100.w,
                          height: 6.h,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: selectLang == ""
                                  ? Text('Select Language',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"))
                                  : Text(
                                      selectLang,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                    ),
                              items: <String>["English"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.black,
                                        fontFamily: "railLight"),
                                  ),
                                );
                              }).toList(),
                              onChanged: null,
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
          ),
        ));
  }
}
