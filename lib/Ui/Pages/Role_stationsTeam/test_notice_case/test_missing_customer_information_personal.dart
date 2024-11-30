import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';

import '../../../../bloc/global_bloc.dart';
import '../../../../bloc/test_bloc/test_address_bloc.dart';
import '../../../../bloc/test_bloc/test_information_screen_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/service/toast_service.dart';
import '../../../../data/model/lookup_model.dart';
import '../../../../data/model/ufn/Revpidentityarray.dart';
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

class TestMissingCustomerInformationPersonal extends StatefulWidget {
  final Revpidentityarray? data;

  const TestMissingCustomerInformationPersonal({Key? key, this.data})
      : super(key: key);

  @override
  _TestMissingCustomerInformationPersonalState createState() =>
      _TestMissingCustomerInformationPersonalState();
}

class _TestMissingCustomerInformationPersonalState
    extends State<TestMissingCustomerInformationPersonal> {
  List<String> titleList = [];
  late LookupModel? titleModel;

  String title = "";
  String dob = "";
  int ageDiff = 20;

  TextEditingController dateController = TextEditingController();
  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController parentCont = TextEditingController();
  final jobRoleDropdownCtrl = TextEditingController();

  @override
  void initState() {
    List<String> list = [];
    //LookupModel user = SqliteDB.instance.getLookUpData();
    titleModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
    for (var element in titleModel!.PERSON_TITLE!) {
      list.add(element.lookup_data_value!);
    }
    titleList = list;
    if (widget.data != null) {
      title = widget.data?.title ?? '';
      fNameCont.text = widget.data?.firstname ?? '';
      lNameCont.text = widget.data?.lastname ?? '';
    } else {
      var submitAddressMap =
          BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
      fNameCont.text = "${submitAddressMap["forename"] ?? ""}";
      lNameCont.text = "${submitAddressMap["surname"] ?? ""}";
      parentCont.text = "${submitAddressMap["parent"] ?? ""}";
      title = "${submitAddressMap["title"] ?? ""}";
      dob = "${submitAddressMap["dateofbirth"] ?? ""}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
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
              if (title.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Select Title');
              } else if (fNameCont.text.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Enter Forename');
              } else if (lNameCont.text.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Enter Surname');
              } else if (dob.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Enter Date of Birth');
              } else if (ageDiff < 18 && parentCont.text.isEmpty) {
                locator<ToastService>().showValidationMessage(
                    context, 'Enter Parent/Guardian name');

                Fluttertoast.showToast(msg: 'Enter Parent/Guardian name');
              } else {
                BlocProvider.of<TestInfoAddressBloc>(context).add(
                    TestInfoPersonalButtonEvent(
                        context: context,
                        title: title,
                        name: fNameCont.text,
                        surname: lNameCont.text,
                        parent: parentCont.text,
                        dobString: dob));
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
      backgroundColor: secondryColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      body: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: gradientDecoration,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
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
                              ProgressBar(
                                  deviceWidth: 10.w, color: primaryColor),
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
                            ProgressBarThin(
                                deviceWidth: 8.w, color: primaryColor),
                            Column(
                              children: [
                                Image.asset(
                                  "Assets/icons/user.png",
                                  width: 25.sp,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  height: .3.h,
                                ),
                                subheadingText(title: "Personal")
                              ],
                            ),
                            ProgressBarThin(deviceWidth: 8.w, color: blueGrey),
                            Column(
                              children: [
                                Image.asset(
                                  "Assets/icons/pin.png",
                                  width: 25.sp,
                                  color: blueGrey,
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
                                Image.asset(
                                  "Assets/icons/contact.png",
                                  width: 25.sp,
                                ),
                                SizedBox(
                                  height: .3.h,
                                ),
                                subheadingText(title: "Contact")
                              ],
                            ),
                            ProgressBarThin(deviceWidth: 8.w, color: blueGrey),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        boxtextBold(title: "Title"),
                        SmallSpace(),
                        Container(
                            width: 100.w,
                            height: 5.5.h,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              hint: title == ""
                                  ? Text('Select Title',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"))
                                  : Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                    ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: 16.sp,
                              ),
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: "railLight"),
                              items: titleList.map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    title = val.toString();
                                  },
                                );
                              },
                            ))),
                        MediumSpace(),
                        boxtextBold(title: "Forename "),
                        SmallSpace(),
                        SizedBox(
                          width: 100.w,
                          height: 5.5.h,
                          child: TextField(
                            controller: fNameCont,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontFamily: "railLight"),
                            decoration: InputDecoration(
                                hintText: 'Enter Forename ',
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
                        boxtextBold(title: "Surname"),
                        SmallSpace(),
                        SizedBox(
                          width: 100.w,
                          height: 5.5.h,
                          child: TextField(
                            controller: lNameCont,
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontFamily: "railLight"),
                            decoration: InputDecoration(
                                hintText: 'Enter Surname',
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
                        boxtextBold(title: "Date of Birth"),
                        SmallSpace(),
                        Container(
                          height: 12.h,
                          child: CupertinoTheme(
                            data: CupertinoThemeData(
                              textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                              brightness: Brightness.dark,
                            ),
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime:
                                  DateTime(DateTime.now().year - 20),
                              minimumYear: 1920,
                              maximumDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              maximumYear: DateTime.now().year - 1,
                              onDateTimeChanged: (DateTime newDateTime) {
                                setState(() {
                                  dob = DateFormat("d MMMM, yyyy")
                                      .format(newDateTime);
                                  ageDiff =
                                      DateTime.now().year - newDateTime.year;

                                  if ((DateTime.now().month <
                                      newDateTime.month)) {
                                    ageDiff = ageDiff - 1;
                                  }
                                  if ((DateTime.now().month ==
                                      newDateTime.month)) {
                                    if ((DateTime.now().day <
                                        newDateTime.day)) {
                                      ageDiff = ageDiff - 1;
                                    } else {
                                      ageDiff = ageDiff;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        LargeSpace(),
                        dob != ""
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MediumSpace(),
                                  Center(
                                      child: headingTextThree(
                                          title: "Customer Age: $ageDiff")),
                                ],
                              )
                            : Container(),
                        LargeSpace(),
                        ageDiff < 18
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MediumSpace(),
                                  boxtextBold(title: "Parent/Guardian"),
                                  SmallSpace(),
                                  SizedBox(
                                    width: 100.w,
                                    height: 5.5.h,
                                    child: TextField(
                                      controller: parentCont,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Parent/Guardian Name',
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontFamily: "railLight"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        fillColor: white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        MediumSpace(),
                        SmallSpace(),
                      ],
                    ),
                  ),
                ],
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
