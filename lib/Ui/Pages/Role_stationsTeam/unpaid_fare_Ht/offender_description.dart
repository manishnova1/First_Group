import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/data/model/lookup_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/UFN_HT_BLoc/submit_form_bloc.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../bloc/global_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/dropdownFIeldWidget.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../Lookup/pfn_offender_lookups_list.dart';

class OffenderDescriptionHt extends StatefulWidget {
  @override
  _OffenderDescriptionHtState createState() => _OffenderDescriptionHtState();
}

class _OffenderDescriptionHtState extends State<OffenderDescriptionHt> {
  TextEditingController date = TextEditingController();
  String menu = "";
  String selectStation = "";
  String issueDateTime = "";

  String selectTravelClass = "";

  List<String> reasonSelectionList = [];
  String bodyCamera = "Yes";
  String hairColor = "";
  String eyeColor = "";
  String buildd = "";
  String glasses = "";
  String facialhair = "";
  String selectIssueAt = "";
  String occupation = "";
  List<String> hairColorList = [];

  // List<String> eyeColorLists=[];
  List<String> builddList = [];
  bool taatoo = false;

  LookupModel? lookupModel;

  List<PERSON_HAIR_COLOURBean> hairList = [];
  PERSON_HAIR_COLOURBean? selectedHairColor;

  List<PERSON_EYE_COLOURBean> eyeColorList = [];
  PERSON_EYE_COLOURBean? selectedEye;

  List<PERSON_BUILDBean> buildList = [];
  PERSON_BUILDBean? selectedBuild;

  List<PERSON_GLASSESBean> glassesList = [];
  PERSON_GLASSESBean? selectedGlasses;

  List<PERSON_FACIAL_HAIR_TYPEBean> beardList = [];
  PERSON_FACIAL_HAIR_TYPEBean? selectedBeard;

  List<OCCUPATIONBean> occupationList = [];
  OCCUPATIONBean? selectedOccupation;

  List<PERSON_ETHNICITYBean> ethnicityList = [];
  PERSON_ETHNICITYBean? selectedEthnicity;
  final tattoController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void initState() {
    lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
    super.initState();
  }

  // Future<void> getEthncityData(BuildContext context, String reason) async {
  //   final result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               pfn_offender_lookups_list("UFN(HT)", "Ethnicity", "")));
  //   setState(() {
  //     if (result.toString() != "null") {
  //       selectedEthnicity = result as PERSON_ETHNICITYBean;
  //     } else {
  //       selectedEthnicity = null;
  //     }
  //   });
  // }

  Future<void> getBuildData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pfn_offender_lookups_list("UFN(HT)", "Build", "")));
    setState(() {
      if (result.toString() != "null") {
        selectedBuild = result as PERSON_BUILDBean;
      } else {
        selectedBuild = null;
      }
    });
  }

  Future<void> getOccupationData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pfn_offender_lookups_list("UFN(HT)", "Occupation", "")));
    setState(() {
      if (result.toString() != "null") {
        selectedOccupation = result as OCCUPATIONBean;
      } else {
        selectedOccupation = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);

    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.w,
        child: InkWell(
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
                  subheadingTextBOLD(title: "  Go Back")
                ],
              ),
            )),
      ),
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
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                          ProgressBar(
                              deviceWidth: 10.w,
                              color: primaryColor.withOpacity(.5)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    headingText(title: "Customer Description"),
                    MediumSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProgressBarThin(deviceWidth: 18.w, color: primaryColor),
                        Column(
                          children: [
                            Image.asset(
                              "Assets/icons/body.png",
                              width: 20.sp,
                              color: primaryColor,
                            ),
                            SizedBox(
                              height: .3.h,
                            ),
                            subheadingText(title: "Body")
                          ],
                        ),
                        ProgressBarThin(deviceWidth: 18.w, color: blueGrey),
                        Column(
                          children: [
                            Image.asset("Assets/icons/user.png",
                                width: 20.sp, color: blueGrey),
                            SizedBox(
                              height: .3.h,
                            ),
                            subheadingText(title: "Face")
                          ],
                        ),
                        ProgressBarThin(deviceWidth: 18.w, color: blueGrey)
                      ],
                    ),
                    LargeSpace(),
                    SmallSpace(),
                    boxtextBold(title: "Bodycam Used?"),
                    SmallSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Radio(
                              activeColor: primaryColor,
                              value: "Yes",
                              groupValue: bodyCamera,
                              onChanged: (check) {
                                setState(() {
                                  bodyCamera = check.toString();
                                });
                              }),
                        ),
                        boxtextBold(title: "Yes"),
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Radio(
                              activeColor: primaryColor,
                              value: "No",
                              groupValue: bodyCamera,
                              onChanged: (check) {
                                setState(() {
                                  bodyCamera = "No";
                                });
                              }),
                        ),
                        boxtextBold(title: "No"),
                      ],
                    ),
                   Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // MediumSpace(),
                              // boxtextBold(title: "Ethnicity"),
                              // SmallSpace(),
                              // DropdownField(
                              //     onTap: () {
                              //       getEthncityData(context, "");
                              //     },
                              //     title: selectedEthnicity == null
                              //         ? "Please choose"
                              //         : "${selectedEthnicity?.lookup_data_value ?? ''}"
                              //             .toString()),
                              LargeSpace(),
                              boxtextBold(title: "Build"),
                              SmallSpace(),
                              DropdownField(
                                  onTap: () {
                                    getBuildData(context, "");
                                  },
                                  title: selectedBuild == null
                                      ? "Please choose"
                                      : "${selectedBuild?.lookup_data_value ?? ''}"
                                          .toString()),
                              MediumSpace(),
                              boxtextBold(title: "Height"),
                              SmallSpace(),
                              SizedBox(
                                width: 100.w,
                                height: 5.5.h,
                                child: TextField(
                                  controller: heightController,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black,
                                      fontFamily: "railLight"),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Height ',
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
                              boxtextBold(title: "Occupation"),
                              SmallSpace(),
                              DropdownField(
                                  onTap: () {
                                    getOccupationData(context, "");
                                  },
                                  title: selectedOccupation == null
                                      ? "Please choose"
                                      : "${selectedOccupation?.lookup_data_value ?? ''}"
                                          .toString()),
                              LargeSpace(),
                              boxtextBold(title: "Tattoo or Scars"),
                              SmallSpace(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.white),
                                    child: Radio(
                                        activeColor: primaryColor,
                                        value: true,
                                        groupValue: taatoo,
                                        onChanged: (check) {
                                          setState(() {
                                            taatoo = true;
                                          });
                                        }),
                                  ),
                                  boxtextBold(title: "Yes"),
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.white),
                                    child: Radio(
                                        activeColor: primaryColor,
                                        value: false,
                                        groupValue: taatoo,
                                        onChanged: (check) {
                                          setState(() {
                                            taatoo = false;
                                          });
                                        }),
                                  ),
                                  boxtextBold(title: "No"),
                                ],
                              ),
                              Visibility(
                                visible: taatoo,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MediumSpace(),
                                    boxtextBold(title: "Tattoo Description"),
                                    SmallSpace(),
                                    Container(
                                      width: 100.w,
                                      height: 5.5.h,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontFamily: "railLight"),
                                        keyboardType: TextInputType.text,
                                        controller: tattoController,
                                        decoration: InputDecoration(
                                          hintText: '',
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
                                ),
                              ),
                              MediumSpace(),
                              LargeSpace(),
                              SmallSpace(),
                              SecondryButton(
                                  title: "Continue with Facial Appearance",
                                  onAction: () {
                                    if (selectedBuild == null) {
                                      locator<ToastService>()
                                          .showValidationMessage(
                                              context, 'Build required');
                                    } else if (heightController.text.isEmpty) {
                                      locator<ToastService>()
                                          .showValidationMessage(
                                              context, 'Height required');
                                    } else if (heightController
                                            .text.isNotEmpty &&
                                        heightController.text.length > 20) {
                                      locator<ToastService>().showValidationMessage(
                                          context,
                                          'Height description should not be more than 20 characters');
                                    }
                                    // else if (selectedEthnicity == null) {
                                    //   locator<ToastService>()
                                    //       .showValidationMessage(context,
                                    //           'Ethnicity Description required');
                                    // }
                                    else if (taatoo &&
                                        tattoController.text.isEmpty) {
                                      locator<ToastService>()
                                          .showValidationMessage(context,
                                              'Tattoo Description required');
                                    } else if (selectedOccupation == null) {
                                      locator<ToastService>()
                                          .showValidationMessage(
                                              context, 'Occupation required');
                                    } else {
                                      BlocProvider.of<SubmitFormBlocHTHT>(
                                              context)
                                          .add(OffenderDescriptionEventBody(
                                        context: context,
                                        bodyCamera:
                                            bodyCamera == "Yes" ? '1' : '0',
                                        build: selectedBuild?.lookup_data_id,
                                        occupation:
                                            selectedOccupation?.lookup_data_id,
                                        height: heightController.text,
                                        ethnicity:
                                            "null",
                                        tatto: taatoo,
                                        tattoDis: tattoController.text,
                                      ));
                                    }
                                  }),
                              LargeSpace(),
                              SmallSpace(),
                            ],
                          )
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