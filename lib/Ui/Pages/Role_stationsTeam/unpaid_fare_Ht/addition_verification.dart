import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/data/model/lookup_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/UFN_HT_BLoc/submit_form_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../bloc/global_bloc.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/dropdownFIeldWidget.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../../verinotes.dart';

class additionVerificationHT extends StatefulWidget {
  @override
  _additionVerificationHTState createState() => _additionVerificationHTState();
}

class _additionVerificationHTState extends State<additionVerificationHT> {
  // List verificationTypeList = ["British Army ID", "Driving License", "Employer's ID Card","Other","Passport","Rail Staff Travel ID","Royal Navy ID","Senior/Disabled Bus Pass","Student ID","UK Residence Permit","Unable to verify","Utility Bill/Later","Young Scot Card"];
  // String verificationType = "";
  List<CASE_VERIFICATION_TYPEBean> verificationTypeList = [];
  CASE_VERIFICATION_TYPEBean? verificationType;
  LookupModel? lookupModel;

  TextEditingController notesController = TextEditingController();

  Future<void> getVerificationType(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                verifilist("UFN HT", "Verification Type", "")));
    setState(() {
      if (result.toString() != "null") {
        verificationType = result as CASE_VERIFICATION_TYPEBean;
      } else {
        verificationType = null;
      }
    });
  }

  @override
  void initState() {
    lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
    verificationTypeList = lookupModel?.CASE_VERIFICATION_TYPE ?? [];

    var submitAddressMap =
        BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
    notesController.text = "${submitAddressMap["additional_info"] ?? ""}";

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
              if (verificationType == null) {
                locator<ToastService>()
                    .showValidationMessage(context, "Please Select an option");
              } else if (verificationType?.lookup_data_value !=
                      'Unable to Verify' &&
                  notesController.text.isEmpty) {
                locator<ToastService>().showValidationMessage(context,
                    "Please enter some verification notes (e.g. document number)");
              } else {
                BlocProvider.of<SubmitFormBlocHTHT>(context).add(
                    AdditionalVerifyEvent(
                        context: context,
                        type: verificationType?.lookup_data_id ?? '',
                        notes: notesController.text));
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
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(deviceWidth: 10.w, color: primaryColor),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    headingText(title: "Verification Details"),
                    MediumSpace(),
                    LargeSpace(),
                    boxtextBold(title: "Verification Type"),
                    SmallSpace(),
                    DropdownField(
                        onTap: () {
                          getVerificationType(context, "");
                        },
                        title: verificationType == null
                            ? "Manual Verification method"
                            : (verificationType?.lookup_data_value ?? '')
                                .toString()),
                    MediumSpace(),
                    if (verificationType != null &&
                        verificationType?.lookup_data_value !=
                            'Unable to Verify')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boxtextBold(title: "Verification Notes"),
                          SmallSpace(),
                          SizedBox(
                            width: 100.w,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black,
                                  fontFamily: "railLight"),
                              controller: notesController,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                // hintText: 'Use this section to recorded serial number.'
                                //     '\nReference or other information available to you ',
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
                        ],
                      )
                    else
                      Container(),
                    LargeSpace(),
                    SmallSpace(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Unpaid Fare Notice (HT) ",
                  icon: "Assets/icons/bandge.png")),
        ],
      ),
    );
  }
}
