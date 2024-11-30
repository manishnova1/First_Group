import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import '../../../../bloc/printer_bloc/printer_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/issuing_bloc/issuing_history_list.dart';
import '../../../../common/service/printing_service.dart';
import '../../../../constants/app_utils.dart';
import '../../../../data/model/Issuing_History_Model.dart';
import '../../../Utils/dialogCancel.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/backbutton1.dart';
import '../../../Widgets/top_header_case.dart';
import 'Reprint_submit.dart';

class IssuingHistoryMain extends StatefulWidget {
  String issueTitle;

  IssuingHistoryMain(this.issueTitle, {Key? key}) : super(key: key);

  @override
  _IssuingHistoryMainState createState() => _IssuingHistoryMainState();
}

class _IssuingHistoryMainState extends State<IssuingHistoryMain> {
  List<STCASEDETAILS?> issuingHistoryList = [];
  List<STCASEDETAILS?> searchlist = [];
  TextEditingController searchController = TextEditingController();
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
  @override
  void initState() {
    getprinterConnnected();
    // TODO: implement initState
    BlocProvider.of<IssuingHistoryBloc>(context)
        .add(IssuingHistoryInitRefresh());

    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<STCASEDETAILS?> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = issuingHistoryList;
    } else {
      results = issuingHistoryList
          .where((data){

        return data!.cASENUM.toString().contains(enteredKeyword) || data!.cREATEDDT.toString().contains(enteredKeyword);
      })
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchlist = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions:  [
            CommonOfflineStatusBar(isOfflineApiRequired: false)
          ],
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
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height:7.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subheadingText(title: "    Details"),
                          subheadingText(title: "                                Status"),
                          subheadingText(title: "Action"),
                        ],
                      ),

                      SizedBox(height:2.h),


                      BlocConsumer<IssuingHistoryBloc, IssuingHistoryState>(
                          listener: (context, state) {
                            if (state is IssuingHistorySuccessState) {
                              issuingHistoryList = state.issuingHistoryList;
                              searchlist = issuingHistoryList;
                            }
                          }, builder: (context, state) {
                        if (state is IssuingHistorySuccessState) {
                          return Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: searchlist.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var history = searchlist[index];

                                  var current=DateTime.now();
                                  DateTime dt2 = current;
                                  DateTime dt1 = DateFormat('dd/MM/yyyy HH:mm:ss').parse("${history!.cREATEDDT.toString()} ${history!.cREATEDTIME.toString()}");

                                  Duration diff = dt2.difference(dt1);
                                  var mins=diff.inMinutes;
                                  log(mins.toString());
                                  return Card(
                                    color: secondryColor,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(

                                                      children: [
                                                        IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month), color: primaryColor),
                                                        Text(
                                                            "${history!.cREATEDDT}", style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 9.sp,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "railLight")),

                                                        IconButton(onPressed: () {}, icon: Icon(Icons.access_time),
                                                          color: primaryColor, ),
                                                        Text(
                                                            " ${history!.cREATEDTIME.toString()}",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 9.sp,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: "railLight")),
                                                      ]
                                                  ),
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        IconButton(onPressed: () {}, icon: const Icon(Icons.description_outlined,), color: Colors.blueGrey,
                                                            iconSize: 20),
                                                        Text(
                                                          history!.cASENUM.toString(),
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize:11.sp,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: "railLight"),
                                                          maxLines: 2,
                                                        ),



                                                        SizedBox(width: 1.h),]

                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 3.w),

                                                      history!.sTATUSDESC
                                                          .toString() ==
                                                          'Open'
                                                          ? SizedBox(
                                                        height: 6.h,
                                                        width: 34.w,
                                                        child: Card(
                                                            color:
                                                            Colors.orange,
                                                            child: TextButton(
                                                                onPressed:
                                                                    () async {},
                                                                child: Text(
                                                                  history!
                                                                      .sTATUSDESC
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      8.5.sp),
                                                                ))),
                                                      )
                                                          : history!.cLOSUREREASONDESC
                                                          .toString() ==
                                                          'Closed with no money outstanding'
                                                          ? SizedBox(
                                                          height: 6.h,
                                                          width: 68.w,
                                                          child: Card(
                                                              color: Colors
                                                                  .lightGreen,
                                                              child:
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {

                                                                  },
                                                                  child:
                                                                  Text(
                                                                    history!.cLOSUREREASONDESC
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 8.5.sp),
                                                                  ))))
                                                          : SizedBox(
                                                        height: 6.h,
                                                        width: 68.w,
                                                        child: Card(
                                                          color: Colors
                                                              .red,
                                                          child: TextButton(
                                                              onPressed:
                                                                  () async {},
                                                              child: Text(
                                                                history!.cLOSUREREASONDESC
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                    8.5.sp),
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ],


                                                  ),
                                                  SizedBox(height: 0.3.h),
                                                ],
                                              )
                                            ]
                                        ),

                                        history!.sTATUSDESC.toString() == "Open" &&
                                            mins<30
                                            ?  Icon(CupertinoIcons.lock_open_fill, color: Colors.blueGrey, size:18.sp)
                                            :  Icon(CupertinoIcons.lock_fill, color: Colors.red, size:18.sp),
                                        history!.sTATUSDESC.toString()  == "Open" && mins<30
                                            ? SizedBox(
                                            height: 4.5.h,
                                            child: Card(
                                                color: primaryColor,
                                                child: TextButton(
                                                    onPressed: () async {
                                                      BlocProvider.of<AddressUfnBloc>(context)
                                                          .submitAddressMap
                                                          .clear();

                                                      var value =
                                                      await showDialog(
                                                          barrierDismissible:
                                                          true,
                                                          context:
                                                          context,
                                                          builder:
                                                              (BuildContext
                                                          context) {
                                                            return PaymentHistorySearchDialog(
                                                                history.cASEID
                                                                    .toString(),history.cASENUM.toString()); //call the alert dart
                                                          });

                                                      if(value==null)
                                                      {
                                                        BlocProvider.of<
                                                            IssuingHistoryBloc>(
                                                            context)
                                                            .add(
                                                            IssuingHistoryInitRefresh());

                                                      }
                                                    },
                                                    child: Text(
                                                      "ADMIN ",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontSize: 6.sp),
                                                    )
                                                )
                                            )
                                        )
                                            : Container()
                                      ],
                                    ),
                                  );
                                }),

                          );

                        }
                        else {
                          return Container();
                        }

                      }

                      ),

                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: TopHeaderCase(
                      title: "Manage Previous Notices",
                      icon: "Assets/icons/history.png")),
              const Positioned(
                bottom:0,
                child:backButtondark(),
              )
            ]
        )
    );

  }
}
