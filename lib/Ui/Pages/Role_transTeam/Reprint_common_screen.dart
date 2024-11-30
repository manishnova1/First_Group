import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/common/service/dialog_service.dart';
import '../../../../bloc/test_bloc/test_address_bloc.dart';
import '../../../../bloc/test_bloc/test_image_submit_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../data/local/sqlite.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../data/model/auth/login_model.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/printer_bloc/Reprint_bloc.dart';
import '../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../common/Utils/utils.dart';
import '../../../common/service/printing_service.dart';
import '../../../constants/app_utils.dart';
import '../../Utils/common_printer_dialog.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/PrimaryButton.dart';
import '../../Widgets/SpaceWidgets.dart';
import '../../Widgets/progress_bar.dart';
import '../../Widgets/top_header_case.dart';
import '../Role_stationsTeam/issuing_history/issuing_history_main.dart';



class Reprint_section extends StatefulWidget {
  final String caseNumber;

  const Reprint_section({Key? key, required this.caseNumber}) : super(key: key);


  @override
  _Reprint_sectionState createState() => _Reprint_sectionState();
}

class _Reprint_sectionState extends State<Reprint_section> {



  TextEditingController notesController = TextEditingController();
  LoginModel? user;
  String? Casetype;
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
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Go Back",
                              onAction: () {
                                Navigator.pop(context);
                                BlocProvider.of<AddressUfnBloc>(context)
                                    .submitAddressMap
                                    .clear();
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
  getLoginModelData() async {
    connectToPrinterIfNotConnected(context);

    user = await SqliteDB.instance.getLoginModelData();
  }

  bool isPrinterConnected(BuildContext context) {
    final printerBloc = BlocProvider.of<PrinterReprintBloc>(context);
    return printerBloc.status == "Connected";
  }
  connectToPrinterIfNotConnected(BuildContext context) async {
    if (!isPrinterConnected(context)) {
      String printType = await AppUtils().getPrinterId();
      if (printType != null && printType != "") {
        locator<PrintingService>().connectToPrinter(printType);
      }
    }
  }
  @override
  void initState() {
    getLoginModelData();
    String prefix = widget.caseNumber.split("/")[0];
    super.initState();
    setState(() {
      Casetype = prefix;

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {

          return Future.value(false);
        },
        child:
        Scaffold(
          bottomNavigationBar: InkWell(
            onTap: () async {
              Navigator.pop(context);
              bool checkInternet =
              await Utils.checkInternet();
              if (checkInternet) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => IssuingHistoryMain("")));

              } else {
                openErrorDialogForVerication(context);
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
                  subheadingTextBOLD(title: "Return to Manage Previous Notices"),

                ],
              ),
            ),
          ),
          backgroundColor: secondryColor,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: primaryColor,
            actions:  [
              CommonOfflineStatusBar(isOfflineApiRequired: false,)
            ],
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
                                        deviceWidth: 10.w, color: primaryColor.withOpacity(.5)), ProgressBar(
                                        deviceWidth: 10.w, color: primaryColor.withOpacity(.5)), ProgressBar(
                                        deviceWidth: 10.w, color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w, color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w, color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 10.w, color: primaryColor.withOpacity(.5)),


                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
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
                                      BlocListener<PrinterReprintBloc, PrinterState>(
                                        listener: (context, state) {
                                          if (state is PrinterCheckStatusHeadState) {
                                            if (state.status == "Connected") {
                                              CommonPrinterDialog()
                                                  .startPrintingDialog(context);
                                              BlocProvider.of<PrinterReprintBloc>(context)
                                                  .add(PrinterCaseEvent(
                                                  type: Casetype,
                                                  context: context));
                                            } else {
                                              CommonPrinterDialog()
                                                  .showPrinterStatusDialog(
                                                  context, state.status);
                                            }
                                          } else if (state is PrintingDoneReprintState) {
                                            if (state.status == "Failed") {
                                              Navigator.pop(context);
                                              CommonPrinterDialog()
                                                  .cancelPrinterDialog(context,
                                                  onPressed: () {
                                                    Navigator.pop(context, true);
                                                    if (BlocProvider.of<PrinterReprintBloc>(
                                                        context)
                                                        .status ==
                                                        "Connected") {
                                                      BlocProvider.of<PrinterReprintBloc>(
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
                                              locator<DialogService>().commonSuccessDialog(context,
                                                  continueAction: (){
                                                    Navigator.pop(context);
                                                    onPrintSucessDialog(context);
                                                  },
                                                  rePrintAction: (){
                                                    Navigator.pop(context);
                                                    if (BlocProvider.of<PrinterReprintBloc>(context).status ==
                                                        "Connected") {
                                                      BlocProvider.of<PrinterReprintBloc>(context).add(PrinterCheckStatusEvent());
                                                    } else {

                                                      CommonPrinterDialog().showPrinterDialog(context);
                                                    }
                                                  });
                                            }
                                          } else if (state
                                          is PrinterCommandReadyToPrintState) {
                                            BlocProvider.of<PrinterReprintBloc>(context)
                                                .add(PrinterPrintCommandEvent(
                                                state.zplCommand));
                                          }
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            if (BlocProvider.of<PrinterReprintBloc>(context).status ==
                                                "Connected") {
                                              BlocProvider.of<PrinterReprintBloc>(context).add(PrinterCheckStatusEvent());

                                            } else {
                                              CommonPrinterDialog().showPrinterDialog(context);
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
                                                      title:
                                                      "Print  $Casetype "),
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
                  child: TopHeaderCasenoIcon(
                    title: "Reprint Notice ",
                  )),
            ],
          ),
        )
    );
  }
}
