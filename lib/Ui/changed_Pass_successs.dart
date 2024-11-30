import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/navigation_service.dart';
import '../../../../data/local/sqlite.dart';
import '../../../../data/model/auth/login_model.dart';
import '../common/service/common_offline_status.dart';
import 'Widgets/DrawerWidget.dart';
import 'Widgets/PrimaryButton.dart';
import 'Widgets/SecondryButton.dart';
import 'Widgets/SpaceWidgets.dart';
import 'Widgets/progress_bar.dart';
import 'Widgets/top_header_case.dart';

class Successfullpassword extends StatefulWidget {
  const Successfullpassword({Key? key}) : super(key: key);

  @override
  _SuccessfullpasswordState createState() => _SuccessfullpasswordState();
}

class _SuccessfullpasswordState extends State<Successfullpassword> {
  TextEditingController notesController = TextEditingController();
  LoginModel? user;

  openAppDialog(BuildContext context) async {
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Confirmation',
                  ),
                )),
                Image.asset(
                  "Assets/icons/success.png",
                  width: 10.w,
                  fit: BoxFit.cover,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Return to Menu",
                              onAction: () {
                                locator<NavigationService>().pushAndRemoveUntil(
                                    UnPaidFareIssueMainRoute(
                                        isOfflineApiRequired: false));
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  getLoginModelData() async {
    user = await SqliteDB.instance.getLoginModelData();
  }

  @override
  void initState() {
    getLoginModelData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          locator<NavigationService>().pushAndRemoveUntil(
              UnPaidFareIssueMainRoute(isOfflineApiRequired: false));
        },
        child: Container(
          padding: EdgeInsets.all(15),
          width: 100.w,
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
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingTextOne(
                                title: "Password \Changed\nSuccessfully"),
                            Image.asset(
                              "Assets/icons/success.png",
                              width: 20.w,
                              height: 10.h,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        LargeSpace(),
                        MediumSpace(),
                        SmallSpace(),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
