import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/summary_car_parking_penality.dart';
import 'package:railpaytro/Ui/Pages/photo_view.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/bloc/car_parking_pelanty_bloc/bloc_image_upload.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/service/common_offline_status.dart';

import '../../../../bloc/car_parking_pelanty_bloc/bloc_car_penalty_submit.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/dialog_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/TextWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../../Widgets/whiteButton.dart';

class CarParkingPenalityIImages extends StatefulWidget {
  Map<String, dynamic> dataobj;

  CarParkingPenalityIImages(this.dataobj);

  @override
  _CarParkingPenalityIImagesState createState() =>
      _CarParkingPenalityIImagesState();
}

class _CarParkingPenalityIImagesState extends State<CarParkingPenalityIImages> {
  String menu = "";
  bool manual = false;
  bool auto = true;
  String? SearchResult;
  List<File> imageslist = [];
  var multipartImageList = [];
  final ImagePicker _picker = ImagePicker();

  ///get from Camera
  _getFromCamera() async {
    XFile? pickedFile = (await _picker.pickImage(
        source: ImageSource.camera,
        // var image = File(_pickedImage.path.toString());
        imageQuality: 60,
        preferredCameraDevice: CameraDevice.front));
    if (pickedFile != null) {
      BlocProvider.of<PCNImageSubmitBloc>(context).add(
          PCNUploadImageEvent(context: context, image: File(pickedFile.path)));
    }
  }

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
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Warning',
                  ),
                )),
            content: subheadingText(
                title:
                    "You have not added any photographs to this Penalty Charge Notice."),
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
                          child: PrimaryButton(
                              title: "Add Photographs",
                              onAction: () {
                                Navigator.pop(context, true);
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
                          child: whiteButton(
                              title: "Skip and Continue",
                              onAction: () {
                                Navigator.pop(context, true);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SummaryCarParking(
                                            widget.dataobj!, imageslist!)));
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PenaltySubmitBloc>(context).add(PenaltySubmitInitEvent());
    BlocProvider.of<PCNImageSubmitBloc>(context).imageMapList.clear();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    return Scaffold(
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
            child: Column(
              children: [
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProgressBar(
                                deviceWidth: 20.w,
                                color: primaryColor.withOpacity(.5)),
                            ProgressBar(deviceWidth: 20.w, color: primaryColor),
                            ProgressBar(deviceWidth: 20.w, color: blueGrey),
                            ProgressBar(deviceWidth: 20.w, color: blueGrey),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      boxtextBoldH2(title: "Photographic Evidence"),
                      SizedBox(
                        height: 1.3.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (imageslist.length < 4) {
                                  _getFromCamera();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: imageslist.length == 4
                                      ? Colors.grey
                                      : blueGrey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      boxtextBold(title: "Add Photo"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.add,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      LargeSpace(),
                      MediumSpace(),
                      ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoView(imageslist)));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: blueGrey),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                              trailing: BlocListener<PCNImageSubmitBloc,
                                      PCNImageSubmitState>(
                                  listener: (BuildContext context, state) {
                                    if (state is PCNImageDeleteSuccessState) {
                                      setState(() {
                                        imageslist = state.imageslist;
                                      });
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<PCNImageSubmitBloc>(
                                              context)
                                          .add(PCNImageDeleteEvent(
                                              index, imageslist));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: blueGrey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: darkColor),
                                      child: Icon(
                                        CupertinoIcons.delete,
                                        color: primaryColor,
                                        size: 15.sp,
                                      ),
                                    ),
                                  )),
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                  boxtext(title: "   Photo ${index + 1}")
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(height: 1, color: blueGrey);
                          },
                          itemCount: imageslist.length),
                      BlocBuilder<PCNImageSubmitBloc, PCNImageSubmitState>(
                        builder: (BuildContext context, state) {
                          if (state
                              is PCNImageSubmitUploadImageProgressPercentState) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                      Text('Uploading...',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      Spacer(),
                                      Text("${state.percentage}.0%",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  LinearProgressIndicator(
                                    backgroundColor: primaryColor,
                                    value: double.parse(
                                            state.percentage ?? "0.0") /
                                        100,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.grey),
                                    minHeight: 10,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      LargeSpace(),
                      MediumSpace(),
                      LargeSpace(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Penalty Charge Notice ",
                  icon: "Assets/icons/car.png")),
          Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                            subheadingTextBOLD(title: " Go Back")
                          ],
                        ),
                      )),
                  BlocListener<PCNImageSubmitBloc, PCNImageSubmitState>(
                      listener: (BuildContext context, state) {
                        if (state is PCNImageSubmitSuccessState) {
                          // locator<DialogService>().hideLoader();
                          setState(() {
                            imageslist.add(state.img);
                          });
                        } else if (state
                            is PCNImageSubmitUploadImageProgressPercentState) {
                          print("uploading percent ${state.percentage}");
                          // locator<DialogService>()
                          //     .showLoader(dismissable: false);
                        } else if (state is PCNImageSubmitErrorState) {
                          // locator<DialogService>().hideLoader();
                        }
                      },
                      child: InkWell(
                          onTap: () {
                            if (imageslist.isEmpty) {
                              openAppDialog(context);
                            } else {
                              BlocProvider.of<PCNImageSubmitBloc>(context).add(
                                  PCNReviewNextButton(
                                      context: context,
                                      dataobj: widget.dataobj,
                                      imageslist: imageslist));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: 50.w,
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
                          ))),
                ],
              )),
        ],
      ),
    );
  }
}
