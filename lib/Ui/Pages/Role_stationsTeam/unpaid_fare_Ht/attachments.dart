import 'dart:io';
import 'dart:ui';

import 'package:camera_camera/camera_camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_Ht/payment_details.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_issue/payment_details.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/bloc/UFN_HT_BLoc/image_submit_bloc.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/locator/locator.dart';
import '../../../../common/service/dialog_service.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../photo_view.dart';

class Unpaid_attachments_HT extends StatefulWidget {
  @override
  _Unpaid_attachments_HTState createState() => _Unpaid_attachments_HTState();
}

class _Unpaid_attachments_HTState extends State<Unpaid_attachments_HT> {
  TextEditingController date = TextEditingController();
  String menu = "";
  List<File> imageslist = []; //
  final ImagePicker _picker = ImagePicker();

  File? imageFile;

  ///get from Camera
  openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) {
            Navigator.pop(context);
            _handleImageSelection(File(file.path));
          },
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Limit to images
      allowMultiple: false, //
      allowCompression: true, // Allow compressed files
    );
    if (result != null && result.files.isNotEmpty) {
      File pickedFile = File(result.files.first.path!);
      _handleImageSelection(pickedFile);
    }
  }


  _handleImageSelection(File selectedImage) {
    if (imageslist.length < 4) {
      BlocProvider.of<ImageSubmitBlocHTHT>(context).add(
          UploadImageEvent(context: context, image: selectedImage));
    }
  }

  openImageDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: darksecondryColor,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Attachment',
                  ),
                )),
            content: subheadingText(title: "Select any option"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        openCamera();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: blueGrey,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(15),
                        width: 30.w,
                        height: 6.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                            subheadingTextBOLD(title: "  Camera")
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _getFromGallery();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: 30.w,
                        height: 6.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera_back,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                            subheadingTextBOLD(title: "  Gallery"),
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 3.h,
              )
            ],
          );
        });
  }
  @override
  void initState() {
    if (imageslist.isEmpty) {
      BlocProvider.of<ImageSubmitBlocHTHT>(context).imageMapList.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    // var deviceHeight = getHeight(context);
    return Scaffold(
      bottomNavigationBar: Row(
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
          BlocListener<ImageSubmitBlocHTHT, ImageSubmitState>(
              listener: (BuildContext context, state) {
                if (state is ImageSubmitSuccessState) {
                  // locator<DialogService>().hideLoader();
                  setState(() {
                    imageslist.add(state.img);
                  });
                } else if (state is ImageUploadProgressPercentState) {
                  // locator<DialogService>()
                  //     .showLoader(dismissable: false);
                } else if (state is ImageSubmitErrorState) {
                  // locator<DialogService>().hideLoader();
                }
              },
              child: InkWell(
                  onTap: () {
                    if (imageslist.isNotEmpty) {
                      BlocProvider.of<ImageSubmitBlocHTHT>(context)
                          .add(AttachmentNextButton(context: context));
                    } else {
                      locator<ToastService>().showValidationMessage(
                          context, "Please select Image first");
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
      ),
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
              child: Column(
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Padding(
                    padding: screenPadding,
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
                        ProgressBar(deviceWidth: 10.w, color: primaryColor),
                        ProgressBar(deviceWidth: 10.w, color: blueGrey),
                        ProgressBar(deviceWidth: 10.w, color: blueGrey),
                        ProgressBar(deviceWidth: 10.w, color: blueGrey),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boxtextBoldH2(title: "Photographic Evidence"),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Unpaid_PaymentDetailsHTHT()));
                            },
                            child: Card(
                              color: primaryColor,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: subheadingText(
                                    title: "Skip",
                                  )),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.flag_fill,
                          color: primaryColor,
                        ),
                        Container(
                          width: 77.w,
                          child: Text(
                              "Do not attach any images of payment cards, "
                              "sensitive documents or information",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "railLight")),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subheadingText(
                            title:
                                "You can use this section to take photographs of tickets, railcards or other evidence relevant to the case."),
                        LargeSpace(),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (imageslist.length < 4) {
                                    openImageDialog(context);
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
                                trailing: BlocListener<ImageSubmitBlocHTHT,
                                        ImageSubmitState>(
                                    listener: (BuildContext context, state) {
                                      if (state is ImageDeleteSuccessState) {
                                        setState(() {
                                          imageslist = state.imageslist;
                                        });
                                      }
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<ImageSubmitBlocHTHT>(
                                                context)
                                            .add(ImageDeleteEvent(
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
                        LargeSpace(),
                        MediumSpace(),
                        LargeSpace(),
                        MediumSpace(),
                        BlocBuilder<ImageSubmitBlocHTHT, ImageSubmitState>(
                          builder: (BuildContext context, state) {
                            if (state is ImageUploadProgressPercentState) {
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
                                      value: double.parse(
                                              state.percentage ?? "0.0") /
                                          100,
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
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Unpaid Fare Notice (HT) ",
                  icon: "Assets/icons/bandge.png")),
        ],
      ),
    );
  }
}
