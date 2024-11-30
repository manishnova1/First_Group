import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
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

class OffenderDescriptionFaceHT extends StatefulWidget {
  @override
  _OffenderDescriptionFaceHTState createState() =>
      _OffenderDescriptionFaceHTState();
}

class _OffenderDescriptionFaceHTState extends State<OffenderDescriptionFaceHT> {
  TextEditingController date = TextEditingController();
  String menu = "";
  String selectStation = "";
  String issueDateTime = "";

  String selectTravelClass = "";

  List<String> reasonSelectionList = [];
  String bodyCamera = "";
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

  Future<void> gethairData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pfn_offender_lookups_list("UFN(HT)", "Hair Colour and Style", "")));
    setState(() {
      if (result.toString() != "null") {
        selectedHairColor = result as PERSON_HAIR_COLOURBean;
      } else {
        selectedHairColor = null;
      }
    });
  }

  Future<void> getEyeData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pfn_offender_lookups_list("UFN(HT)", "Eye Colour", "")));
    setState(() {
      if (result.toString() != "null") {
        selectedEye = result as PERSON_EYE_COLOURBean;
      } else {
        selectedEye = null;
      }
    });
  }

  Future<void> getGlassesData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pfn_offender_lookups_list("UFN(HT)", "Glasses", "")));
    setState(() {
      if (result.toString() != "null") {
        selectedGlasses = result as PERSON_GLASSESBean;
      } else {
        selectedGlasses = null;
      }
    });
  }

  Future<void> getFacialData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pfn_offender_lookups_list("UFN(HT)", "Facial Hair", "")));
    setState(() {
      if (result.toString() != "null") {
        selectedBeard = result as PERSON_FACIAL_HAIR_TYPEBean;
      } else {
        selectedBeard = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);

    return Scaffold(
      drawer: const DrawerWidget(),
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
                            ProgressBarThin(
                                deviceWidth: 18.w,
                                color: primaryColor.withOpacity(.5)),
                            Column(
                              children: [
                                Image.asset(
                                  "Assets/icons/body.png",
                                  width: 20.sp,
                                  color: primaryColor.withOpacity(.5),
                                ),
                                SizedBox(
                                  height: .3.h,
                                ),
                                subheadingText(title: "Body")
                              ],
                            ),
                            ProgressBarThin(
                                deviceWidth: 18.w,
                                color: primaryColor.withOpacity(.5)),
                            Column(
                              children: [
                                Image.asset("Assets/icons/user.png",
                                    width: 20.sp, color: primaryColor),
                                SizedBox(
                                  height: .3.h,
                                ),
                                subheadingText(title: "Face")
                              ],
                            ),
                            ProgressBarThin(
                                deviceWidth: 18.w, color: primaryColor)
                          ],
                        ),
                        LargeSpace(),
                        MediumSpace(),
                        boxtextBold(title: "Hair Colour and Style"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              gethairData(context, "");
                            },
                            title: selectedHairColor == null
                                ? "Please choose"
                                : "${selectedHairColor?.lookup_data_value ?? ''}"
                                    .toString()),
                        MediumSpace(),
                        boxtextBold(title: "Eye Colour"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              getEyeData(context, "");
                            },
                            title: selectedEye == null
                                ? "Please choose"
                                : "${selectedEye?.lookup_data_value ?? ''}"
                                    .toString()),
                        MediumSpace(),
                        boxtextBold(title: "Glasses"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              getGlassesData(context, "");
                            },
                            title: selectedGlasses == null
                                ? "Please choose"
                                : "${selectedGlasses?.lookup_data_value ?? ''}"
                                    .toString()),
                        MediumSpace(),
                        boxtextBold(title: "Facial Hair"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              getFacialData(context, "");
                            },
                            title: selectedBeard == null
                                ? "Please choose"
                                : "${selectedBeard?.lookup_data_value ?? ''}"
                                    .toString()),
                        LargeSpace(),
                        SmallSpace(),
                        PrimaryButton(
                            title: "Submit",
                            onAction: () {
                              if (selectedHairColor == null) {
                                locator<ToastService>().showValidationMessage(
                                    context, 'Hair Colour required');
                              } else if (selectedEye == null) {
                                locator<ToastService>().showValidationMessage(
                                    context, 'Eye Colour required');
                              } else if (selectedGlasses == null) {
                                locator<ToastService>().showValidationMessage(
                                    context, 'Glasses Description required');
                              } else if (selectedBeard == null) {
                                locator<ToastService>().showValidationMessage(
                                    context,
                                    'Facial Hair Description required');
                              } else {
                                BlocProvider.of<SubmitFormBlocHTHT>(context)
                                    .add(OffenderDescriptionEvent(
                                  context: context,
                                  eveColor: selectedEye?.lookup_data_id,
                                  facialHair: selectedBeard?.lookup_data_id,
                                  glasses: selectedGlasses?.lookup_data_id,
                                  hairColor: selectedHairColor?.lookup_data_id,
                                ));
                              }
                            }),
                        LargeSpace(),
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
                  title: "Unpaid Fare Notice (HT) ",
                  icon: "Assets/icons/bandge.png")),
        ],
      ),
    );
  }
}
