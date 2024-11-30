import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import '../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/DrawerWidget.dart';

class PhotoView extends StatefulWidget {
  List<File> imagesList;

  PhotoView(this.imagesList);

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  int ind = 0;

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
        alignment: Alignment.center,
        children: [
          Container(
              width: 100.w,
              height: 100.h,
              color: blackColor,
              child: Center(
                child: Container(
                  height: 60.h,
                  margin: EdgeInsets.only(left: 0, right: 0),
                  width: 100.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imagesList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50.h,
                            width: 100.w,
                            child: Image.file(
                              widget.imagesList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: headingTextThree(
                                title: "Photo${index + 1}.jpg".toString()),
                          )
                        ],
                      );
                    },
                  ),
                ),
              )),
          Positioned(
              bottom: 14.h,
              left: 4.w,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: headingTextThree(title: ""),
              )),
          Positioned(
              top: 3.h,
              right: 8.w,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    subheadingTextBOLD(title: "Close    "),
                    Image.asset(
                      "Assets/icons/cross.png",
                      width: 4.w,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
          Positioned(
              bottom: 3.h,
              right: 8.w,
              child: widget.imagesList.length > 1
                  ? InkWell(
                      onTap: () {},
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.white60,
                        size: 25.sp,
                      ),
                    )
                  : Container()),
        ],
      ),
    );
  }
}
