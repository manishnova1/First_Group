import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/test_notice_case/test_offender_description.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/common/service/dialog_service.dart';
import '../../../../bloc/printer_bloc/printer_bloc.dart';
import '../../../../bloc/test_bloc/test_address_bloc.dart';
import '../../../../bloc/test_bloc/test_image_submit_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/navigation_service.dart';
import '../../../../data/local/sqlite.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../data/model/auth/login_model.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Utils/common_printer_dialog.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class TestUnpaidfareNoticeSuccessfull extends StatefulWidget {
  final String caseNumber;

  const TestUnpaidfareNoticeSuccessfull({Key? key, required this.caseNumber})
      : super(key: key);

  @override
  _TestUnpaidfareNoticeSuccessfullState createState() =>
      _TestUnpaidfareNoticeSuccessfullState();
}

class _TestUnpaidfareNoticeSuccessfullState
    extends State<TestUnpaidfareNoticeSuccessfull> {
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
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "Add Physical Description",
                              onAction: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OffenderDescriptionTest()));
                              }),
                        ),
                      ],
                    ),
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

                                BlocProvider.of<AddressUfnBloc>(context)
                                    .submitAddressMap
                                    .clear();
                                BlocProvider.of<TestImageSubmitBloc>(context)
                                    .imageMapList
                                    .clear();
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

  onPrintSucessDialog(BuildContext context) async {
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
                    title: 'Print Successful',
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
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "Add Physical Description",
                              onAction: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OffenderDescriptionTest()));
                              }),
                        ),
                      ],
                    ),
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

                                BlocProvider.of<AddressTestBloc>(context)
                                    .submitAddressMap
                                    .clear();
                                BlocProvider.of<TestImageSubmitBloc>(context)
                                    .imageMapList
                                    .clear();
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
          if (user?.ISREVPOFFENDERDESCRIPTIONCAPTURE ?? false) {
            openAppDialog(context);
          } else {
            locator<NavigationService>().pushAndRemoveUntil(
                UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

            BlocProvider.of<AddressTestBloc>(context).submitAddressMap.clear();
            BlocProvider.of<TestImageSubmitBloc>(context).imageMapList.clear();
          }
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
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
                                    deviceWidth: 10.w, color: primaryColor),

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              headingTextOne(title: "Test Notice\nSuccessful"),
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
                          boxtextSmall(title: "Notice Reference:"),
                          subheadingTextBOLD(title: "${widget.caseNumber}"),
                          LargeSpace(),
                          SmallSpace(),
                          Row(
                            children: [
                              Row(
                                children: [
                                  BlocListener<PrinterBloc, PrinterState>(
                                    listener: (context, state) {
                                      if (state
                                          is PrinterCheckStatusHeadState) {
                                        if (state.status == "Connected") {
                                          CommonPrinterDialog()
                                              .startPrintingDialog(context);
                                          BlocProvider.of<PrinterBloc>(context)
                                              .add(PrinterCaseEvent(
                                                  type: "TEST",
                                                  context: context));
                                        } else {
                                          CommonPrinterDialog()
                                              .showPrinterStatusDialog(
                                                  context, state.status);
                                        }
                                      } else if (state is PrintingDoneState) {
                                        if (state.status == "Failed") {
                                          Navigator.pop(context);
                                          CommonPrinterDialog()
                                              .cancelPrinterDialog(context,
                                                  onPressed: () {
                                            Navigator.pop(context, true);
                                            if (BlocProvider.of<PrinterBloc>(
                                                        context)
                                                    .status ==
                                                "Connected") {
                                              BlocProvider.of<PrinterBloc>(
                                                      context)
                                                  .add(
                                                      PrinterCheckStatusEvent());
                                            } else {
                                              CommonPrinterDialog()
                                                  .showPrinterDialog(context);
                                            }
                                          });
                                        } else if (state.status == "Done") {
                                          Navigator.pop(context);
                                          locator<DialogService>()
                                              .commonSuccessDialog(context,
                                                  continueAction: () {
                                            Navigator.pop(context);
                                            onPrintSucessDialog(context);
                                          }, rePrintAction: () {
                                            Navigator.pop(context);
                                            if (BlocProvider.of<PrinterBloc>(
                                                        context)
                                                    .status ==
                                                "Connected") {
                                              BlocProvider.of<PrinterBloc>(
                                                      context)
                                                  .add(
                                                      PrinterCheckStatusEvent());
                                            } else {
                                              CommonPrinterDialog()
                                                  .showPrinterDialog(context);
                                            }
                                          });
                                        }
                                      } else if (state
                                          is PrinterCommandReadyToPrintState) {
                                        BlocProvider.of<PrinterBloc>(context)
                                            .add(PrinterPrintCommandEvent(
                                                state.zplCommand));
                                      }
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        if (BlocProvider.of<PrinterBloc>(
                                                    context)
                                                .status ==
                                            "Connected") {
                                          BlocProvider.of<PrinterBloc>(context)
                                              .add(PrinterCheckStatusEvent());
                                        } else {
                                          CommonPrinterDialog()
                                              .showPrinterDialog(context);
                                        }
                                      },
                                      child: Container(
                                        width: 88.w,
                                        decoration: BoxDecoration(
                                          color: blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              boxtextBold(
                                                  title: "Print Test Notice"),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(Icons.print,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
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
