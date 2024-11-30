import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/summary_car_parking_penality.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';

import '../../../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/bloc/car_parking_pelanty_bloc/bloc_capture_image_upload.dart';
import 'package:railpaytro/bloc/car_parking_pelanty_bloc/bloc_image_upload.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/router/router.gr.dart';
import 'package:railpaytro/common/service/navigation_service.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/locator/locator.dart';
import '../../../../common/service/dialog_service.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/TextWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../photo_view.dart';

class CaputreImageCarParking extends StatefulWidget {
  Map<String, dynamic> dataobj;
  var imageList;
  var refNo;

  CaputreImageCarParking(this.dataobj, this.imageList, this.refNo);

  @override
  _CaputreImageCarParkingState createState() => _CaputreImageCarParkingState();
}

class _CaputreImageCarParkingState extends State<CaputreImageCarParking> {
  String menu = "";
  bool manual = false;
  bool auto = true;
  String? SearchResult;
  List<File> imageslist = [];
  var multipartImageList = [];
  bool imagelistbox = false;
  bool imageaddbox = true;
  String offenceDateTime = "";
  final ImagePicker _picker = ImagePicker();

  File? imageFile;

  ///get from Camera
  _getFromCamera() async {
    XFile? pickedFile = (await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        preferredCameraDevice: CameraDevice.rear));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imagelistbox = true;
        imageaddbox = false;
        imageslist.add(imageFile!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            ProgressBar(
                                deviceWidth: 20.w,
                                color: primaryColor.withOpacity(.5)),
                            ProgressBar(
                                deviceWidth: 20.w,
                                color: primaryColor.withOpacity(.5)),
                            ProgressBar(
                                deviceWidth: 20.w,
                                color: primaryColor.withOpacity(.5)),
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
                      BlocBuilder<RevpCaptureImageUploadBloc,
                          RevpCaptureImageUploadState>(
                        builder: (BuildContext context, state) {
                          if (state is RevpCaptureImageProgressPercentState) {
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
                        locator<NavigationService>().pushAndRemoveUntil(
                            UnPaidFareIssueMainRoute(
                                isOfflineApiRequired: false));

                        locator<ToastService>().showValidationMessage(
                            context, "Case details added successfully");
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 50.w,
                        height: 6.8.h,
                        color: secondryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [subheadingTextBOLD(title: " Skip")],
                        ),
                      )),
                  BlocListener<RevpCaptureImageUploadBloc,
                          RevpCaptureImageUploadState>(
                      listener: (BuildContext context, state) {
                        if (state is RevpCaptureImageUploadSucessState) {
                          /* Map<String,dynamic> data ={
                                  "TICKETIMAGESIZE":state.data['TICKETIMAGESIZE'],
                                  "TICKETIMAGEPATH":state.data['TICKETIMAGEPATH'],
                                  "onlinefilesname": state.data['TICKETIMAGEPATH'],
                                  "s3onlinefilesize":state.data['TICKETIMAGESIZE'],
                                };
                                var e = widget.dataobj;
                                e.addAll(data);
                                locator<NavigationService>().pushAndRemoveUntil(
                                    const StationsTeamHomescreenRoute());*/
                        }
                      },
                      child: InkWell(
                          onTap: () {
                            if (imageslist.isEmpty) {
                              locator<ToastService>().showValidationMessage(
                                  context, "Please select image");
                            } else {
                              BlocProvider.of<RevpCaptureImageUploadBloc>(
                                      context)
                                  .add(RevpCaptureImageUploadButtonEvent(
                                      imageslist, widget.refNo, context));
                              //     Utils.showToast('Case details added successfully')	;
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
