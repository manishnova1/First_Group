import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';

import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/data/model/issuing_history_IR.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloc/global_bloc.dart';
import '../../../../data/model/Issuing_History_Model.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/SpaceWidgets.dart';

class IntelligenceHistory extends StatefulWidget {
  String issueTitle;

  IntelligenceHistory(this.issueTitle, {Key? key}) : super(key: key);

  @override
  _IntelligenceHistoryState createState() => _IntelligenceHistoryState();
}

class _IntelligenceHistoryState extends State<IntelligenceHistory> {
  List<STCASEDETAILS_IR?> issuingHistoryList = [];
  List<STCASEDETAILS_IR?> searchlist = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    issuingHistoryList =
        BlocProvider.of<GlobalBloc>(context).issuingHistoryListIR;
    searchlist = issuingHistoryList;

    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<STCASEDETAILS_IR?> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = issuingHistoryList;
    } else {
      results = issuingHistoryList
          .where((data) => data!.cASENUM.toString().contains(enteredKeyword))
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
      backgroundColor: secondryColor,
      body: Column(
        children: [
          TopBarwithTitle(
            title: "Intelligence Report History",
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 7.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.search,
                          color: Colors.black54,
                          size: 16.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 70.w,
                          child: TextField(
                            controller: searchController,
                            onChanged: _runFilter,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Search"),
                            style: TextStyle(
                                fontSize: 13.sp,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: searchlist.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var history = searchlist[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ExpansionTile(
                            leading: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Image.asset(
                                  "Assets/icons.png",
                                  height: 46,
                                  fit: BoxFit.cover,
                                )),
                            title: Text(
                              history!.cASENUM.toString(),
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black),
                            ),
                            subtitle: Text(
                                "${history!.cREATEDDT} ${history!.cREATEDTIME.toString()}",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                            children: [
                              // LargeSpace(),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Status",
                              //         style: TextStyle(fontSize: 10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         history!.pEPORT.toString(),
                              //         style: TextStyle(fontSize: 12.sp, color: primaryColor,fontWeight:FontWeight.bold),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Origin",
                              //         style: TextStyle(fontSize:10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         "Edinburgh",
                              //         style: TextStyle(fontSize: 12.sp, color:Colors.black),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Destination",
                              //         style: TextStyle(fontSize: 10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         "Aberdeen",
                              //         style: TextStyle(fontSize: 12.sp, color:Colors.black),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Zero Fare No.",
                              //         style: TextStyle(fontSize:10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         "123456",
                              //         style: TextStyle(fontSize: 12.sp, color:Colors.black),)
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Fare",
                              //         style: TextStyle(fontSize: 10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         "\£ 45.00",
                              //         style: TextStyle(fontSize: 12.sp, color:Colors.black),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Admin Fee",
                              //         style: TextStyle(fontSize:10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         "\£ 45.00",
                              //         style: TextStyle(fontSize:12.sp, color:Colors.black),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Divider(),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:5),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Total Value",
                              //         style: TextStyle(fontSize:10.sp, color: Colors.black54),
                              //       ),
                              //       Text(
                              //         "\£ 45.00",
                              //         style: TextStyle(fontSize: 12.sp, color:Colors.black,fontWeight:FontWeight.bold),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(height:14,)
                            ],
                          ),
                        );
                      })))
        ],
      ),
    );
  }
}
