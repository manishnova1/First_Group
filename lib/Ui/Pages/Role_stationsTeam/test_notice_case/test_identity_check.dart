import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/test_notice_case/test_missing_customer_information_personal.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/locator/locator.dart';
import '../../../../common/service/toast_service.dart';
import '../../../../data/model/ufn/Revpidentityarray.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../Utils/defaultPadiing.dart';
import '../../../Utils/strings.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/TextWidgets.dart';
import '../../../Widgets/TopBarwithTitle.dart';
import '../../../Widgets/backButton.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class TestIdentityCheckScreen extends StatefulWidget {
  final List<Revpidentityarray>? revpidentityarray;

  const TestIdentityCheckScreen({Key? key, this.revpidentityarray})
      : super(key: key);

  @override
  _TestIdentityCheckScreenState createState() =>
      _TestIdentityCheckScreenState();
}

class _TestIdentityCheckScreenState extends State<TestIdentityCheckScreen> {
  List titleList = ["Mr.", "Mrs."];
  String title = "";
  String dob = "";
  int selectedIndex = -1;

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    headingText(title: "Identity Check Results"),
                    SizedBox(
                      height: .5.h,
                    ),
                    subheadingText(title: "Select a name from the list below"),
                    SizedBox(
                      height: 3.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.revpidentityarray!.length,
                        itemBuilder: (BuildContext context, int index) {
                          dynamic d = widget.revpidentityarray![index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 16.0),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: index == selectedIndex
                                          ? primaryColor
                                          : Colors.white,
                                      width: 2),
                                  color: index == selectedIndex
                                      ? blueGrey
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(3.0)),
                              child: Text(
                                "${d.title} ${d.firstname} ${d.lastname}",
                                style: TextStyle(
                                    color: index == selectedIndex
                                        ? Colors.white
                                        : Colors.white,
                                    fontFamily: "railLight"),
                              ),
                            ),
                          );
                        }),
                    SmallSpace(),
                    LargeSpace(),
                    selectedIndex != -1
                        ? Container(
                            child: PrimaryButton(
                                title: "Proceed",
                                onAction: () {
                                  if (selectedIndex != -1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TestMissingCustomerInformationPersonal(
                                                  data:
                                                      widget.revpidentityarray![
                                                          selectedIndex],
                                                )));
                                  } else {
                                    locator<ToastService>()
                                        .showValidationMessage(
                                            context, 'Please select user');
                                  }
                                }),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                subheadingText(
                                    title:
                                        "No resident names could be found for this address."),
                                MediumSpace(),
                                SecondryButton(
                                    title: "Enter details manually",
                                    onAction: () {
                                      // if(selectedIndex != -1){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TestMissingCustomerInformationPersonal()));
                                    }),
                              ])
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
