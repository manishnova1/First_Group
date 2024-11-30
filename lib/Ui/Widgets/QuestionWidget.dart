import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Utils/Colors.dart';
import 'SpaceWidgets.dart';
import 'TextWidgets.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget(
      {Key? key,
      required this.questionOne,
      required this.answerOne,
      required this.index})
      : super(key: key);

  final TextEditingController questionOne;
  final TextEditingController answerOne;
  int index;
  String displayText = "NO COMMENT";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LargeSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boxtextBold(title: "Question ${index}"),
          ],
        ),
        SmallSpace(),
        SizedBox(
          height: 6.4.h,
          width: 40.5.h,
          child: TextField(
            style: TextStyle(fontSize: 12.sp),
            controller: questionOne,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: '',
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
            ),
          ),
        ),
        MediumSpace(),
        boxtextBold(title: "Answer"),
        SmallSpace(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            height: 6.4.h,
            width: 35.0.h,
            child: TextField(
              controller: answerOne,
              style: TextStyle(fontSize: 12.sp),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
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
              ),
            ),
          ),
          IconButton(
            color: Colors.red,
            icon: const Icon(Icons.speaker_notes_off_outlined),
            onPressed: () {
              if (answerOne.text.isEmpty) {
                insert("NO COMMENT");
              }
            },
          ),
        ])
      ],
    );
  }

  void insert(String content) {
    var text = answerOne.text;
    // var pos = answerOne.selection.start;
    answerOne.value = TextEditingValue(
      text: text.substring(
            0,
          ) +
          content +
          text.substring(0),
      //selection: TextSelection.collapsed(offset: pos + content.length),
    );
  }
}
