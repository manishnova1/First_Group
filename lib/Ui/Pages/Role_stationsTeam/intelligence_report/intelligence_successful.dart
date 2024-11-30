import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bloc/global_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../common/service/navigation_service.dart';
import '../../../../data/model/revpirDetailMode.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class IntelligenceSuccessfull extends StatefulWidget {
  final String caseNumber;

  IntelligenceSuccessfull(this.caseNumber);

  @override
  _IntelligenceSuccessfullState createState() =>
      _IntelligenceSuccessfullState();
}

class _IntelligenceSuccessfullState extends State<IntelligenceSuccessfull> {
  List<REVPIRDETAILSARRAY?> revirDetail = [];

  @override
  void initState() {
    revirDetail = BlocProvider.of<GlobalBloc>(context).revpirDetailLIST;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return WillPopScope(
        onWillPop: () async {
          locator<NavigationService>().pushAndRemoveUntil(
              UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

          return true;
        },
        child: Scaffold(
            bottomNavigationBar: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                      title: "Complete and Return to Menu",
                      onAction: () {
                        locator<NavigationService>().pushAndRemoveUntil(
                            UnPaidFareIssueMainRoute(
                                isOfflineApiRequired: false));
                      }),
                ),
              ],
            ),
            backgroundColor: secondryColor,
            drawer: const DrawerWidget(),
            appBar: AppBar(
              backgroundColor: primaryColor,
              actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
            ),
            body: Stack(alignment: Alignment.center, children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: gradientDecoration,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ProgressBar(
                                      deviceWidth: 20.w,
                                      color: primaryColor.withOpacity(.5)),
                                  ProgressBar(
                                      deviceWidth: 20.w,
                                      color: primaryColor.withOpacity(.5)),
                                  ProgressBar(
                                      deviceWidth: 20.w,
                                      color: primaryColor.withOpacity(.5)),
                                  ProgressBar(
                                      deviceWidth: 20.w, color: primaryColor),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                headingTextOne(title: "Report \nsubmitted"),
                                Image.asset(
                                  "Assets/icons/success.png",
                                  width: 20.w,
                                  height: 10.h,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                            LargeSpace(),
                            boxtextSmall(title: "Report Number:"),
                            subheadingTextBOLD(title: "${widget.caseNumber}"),
                            LargeSpace(),
                            const SizedBox(height: 10),
                            Html(
                                shrinkWrap: true,
                                data: revirDetail[0]
                                    ?.confermationMessage
                                    .toString(),
                                style: {
                                  // p tag with text_size
                                  "body": Style(
                                    fontSize: FontSize(12.sp),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "railLight",
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                    padding: EdgeInsets.zero,
                                  ),

                                  "a": Style(
                                    fontSize: FontSize(13.sp),
                                    padding: EdgeInsets.zero,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.start,
                                  ),
                                },
                                onLinkTap: (String? url,
                                    RenderContext context,
                                    Map<String, String> attributes,
                                    var e) async {
                                  Uri phoneno = Uri.parse(url.toString());
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                }),
                            LargeSpace(),
                            const SizedBox(height: 120),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: TopHeaderCase(
                      title: "Intelligence Report ",
                      icon: "Assets/icons/warning.png")),
            ])));
  }
}
