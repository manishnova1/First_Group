import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/SpaceWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/issuing_bloc/issuing_submit.dart';
import 'package:sizer/sizer.dart';
import 'package:railpaytro/bloc/global_bloc.dart';

import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/service/toast_service.dart';
import '../../data/model/lookup_model.dart';

class AddQuestionDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddQuestionDialogState();
  }
}

class AddQuestionDialogState extends State<AddQuestionDialog> {
  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    question.dispose();
    answer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(color: primaryColor, width: 3)),
      insetPadding: EdgeInsets.all(20),
      backgroundColor: darksecondryColor,
      titlePadding:
          const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      title: Text('Add Question'.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "medium",
          )),
      actions: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 6,
              ),
              subheadingTextBOLD(title: "Question"),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 100.w,
                height: 5.5.h,
                child: TextField(
                  controller: question,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontFamily: "railLight"),
                  decoration: InputDecoration(
                      hintText: 'Enter Question',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: white,
                      suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            color: Colors.red,
                            size: 14.sp,
                          ))),
                ),
              ),
              SmallSpace(),
              subheadingTextBOLD(title: "Answer"),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 62.w,
                    height: 5.5.h,
                    child: TextField(
                      controller: answer,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontFamily: "railLight"),
                      decoration: InputDecoration(
                          hintText: 'Enter Answer',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(10),
                          fillColor: white,
                          suffixIcon: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.edit,
                                color: Colors.red,
                                size: 14.sp,
                              ))),
                    ),
                  ),
                  IconButton(
                    color: Colors.red,
                    icon: const Icon(Icons.speaker_notes_off_outlined),
                    onPressed: () {
                      if (answer.text.isEmpty) {
                        answer.text = "NO COMMENT";
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 20.w,
                      child: SecondryButton(
                        onAction: () {
                          Navigator.pop(context);
                        },
                        title: "No",
                      )),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                      child: PrimaryButton(
                    title: "Add",
                    onAction: () {
                      if (question.text.isNotEmpty && answer.text.isNotEmpty) {
                        var data = {
                          "question": question.text,
                          "answer": answer.text
                        };
                        Navigator.pop(context, data);
                      } else if (question.text.isEmpty) {
                        locator<ToastService>().showValidationMessage(
                            context, 'Please enter question');
                      } else if (answer.text.isEmpty) {
                        locator<ToastService>().showValidationMessage(
                            context, 'Please enter answer');
                      }
                    },
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ])
      ],
    );
  }
}
