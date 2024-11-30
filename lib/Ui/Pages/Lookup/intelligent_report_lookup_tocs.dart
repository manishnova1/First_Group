import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/global_bloc.dart';
import '../../../data/local/sqlite.dart';
import '../../../data/model/Affected_toc_Model.dart';
import '../../../data/model/auth/login_model.dart';
import '../../../data/model/lookup_model.dart';
import '../../../data/model/toc_selected_model.dart';
import '../../Widgets/SpaceWidgets.dart';
import '../../Widgets/top_header_case.dart';

class IntelligentReportTocList extends StatefulWidget {
  final List<String> tocsSelectedNamesList;

  IntelligentReportTocList(this.tocsSelectedNamesList, {Key? key})
      : super(key: key);

  @override
  _IntelligentReportTocListState createState() =>
      _IntelligentReportTocListState();
}

class _IntelligentReportTocListState extends State<IntelligentReportTocList> {
  String menu = "";
  final searchCOnt = TextEditingController();
  bool isNormalStation = true;
  late LookupModel? offenceModel;
  List<TocSelectedModel> affectedList = [];
  List<String> tocSelectedNames = [];
  List<bool> tocSelectedBool = [];

  REASON_FOR_ISSUE_FOR_PCNBean? offenceSelectionList;

  List<REVPTOCLISTARRAY?> tocslList = [];

  @override
  void initState() {
    super.initState();
    tocslList = BlocProvider.of<GlobalBloc>(context).revpAffectedTOCLIST;

    dataGet();
  }

  dataGet() async {
    affectedList.add(TocSelectedModel(toc_name: "Our TOCs"));
    affectedList.add(TocSelectedModel(toc_name: "First"));
    affectedList.add(TocSelectedModel(toc_name: "Other TOCs"));
    await Future.forEach(tocslList, (element) {
      REVPTOCLISTARRAY revptoclistarray = element as REVPTOCLISTARRAY;
      if (revptoclistarray.tocName.toString() != "First") {
        setState(() {
          affectedList.add(
              TocSelectedModel(toc_name: revptoclistarray.tocName.toString()));
        });
      } else {}
    });
    affectedList.add(TocSelectedModel(toc_controls: true));
    List<num> numberList = [];
    final RegExp regex = RegExp(r'\d+');
    for (var item in widget.tocsSelectedNamesList) {
      if (item is String) {
        final Iterable<Match> matches = regex.allMatches(item);
        if (matches.length > 0) {
          for (Match match in matches) {
            String matchString = match.group(0)!;
            if (matchString.length == item.length) {
              num parsedNum = num.parse(matchString);
              numberList.add(parsedNum);
            }
          }
        }
      }
    }

    // tocSelectedBool = List<bool>.filled( tocslList.length+3, false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        for (var i = 0; i < numberList.length; i++) {
          for (var j = 0; j < affectedList.length; j++) {
            if (numberList[i] == j) {
              affectedList[j]?.isSelectedIr = true;
            }
          }
        }
      });
    });
  }

  checkUser() async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    isNormalStation = user.RAILPAYSTATIONTYPE == "Common";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: gradientDecoration,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0),
                      child: headingText(
                        title: "Affected TOCs",
                      )),
                  LargeSpace(),
                  Expanded(
                    child: RawScrollbar(
                      trackVisibility: true,
                      thumbColor: primaryColor,
                      trackColor: Colors.black54,
                      trackRadius: const Radius.circular(20),
                      thumbVisibility: true,
                      //always show scrollbar
                      thickness: 8,
                      //width of scrollbar
                      radius: const Radius.circular(20),

                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        itemCount: affectedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (affectedList[index].toc_name == "Our TOCs" ||
                              affectedList[index].toc_name == "Other TOCs") {
                            return ListTile(
                              title: Text(
                                affectedList[index].toc_name.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "railLight",
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          } else {
                            return Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: CheckboxListTile(
                                activeColor: Colors.white,
                                checkColor: Colors.black,
                                title: Text(
                                  affectedList[index].toc_name.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "railLight",
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                value: affectedList[index]?.isSelectedIr,
                                onChanged: (val) {
                                  setState(() {
                                    affectedList[index]?.isSelectedIr = val!;
                                  });
                                },
                              ),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.white,
                            thickness: 0.3,
                            height: 10,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                child: TopHeaderCase(
                    title: "Intelligent Report",
                    icon: "Assets/icons/warning.png")),
            Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  for (var j = 0; j < affectedList.length; j++) {
                    if (affectedList[j].isSelectedIr == true) {
                      affectedList[j].isSelectedIr = true;
                      tocSelectedNames.add(affectedList[j].toc_name.toString());
                      int selectedIndex = affectedList.indexWhere(
                          (item) => item.toc_name == tocSelectedNames.last);
                      tocSelectedNames.add(selectedIndex.toString());
                    }
                  }

                  Navigator.pop(context, tocSelectedNames);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 100.w,
                  height: 6.8.h,
                  color: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subheadingTextBOLD(title: "Confirm "),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 14.sp,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
