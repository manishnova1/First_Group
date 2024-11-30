import 'package:flutter/material.dart';

import '../../Ui/Utils/Colors.dart';
import '../../Ui/Widgets/PrimaryButton.dart';
import '../../Ui/Widgets/SecondryButton.dart';

class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  final Color _color = secondryColor;

  String? _title;
  String? _content;
  String? _yes;
  String? _no;
  late Function _yesOnPressed;

  late Function _noOnPressed;

  BaseAlertDialog(
      {Key? key,
      String? title,
      String? content,
      required Function yesOnPressed,
      required Function noOnPressed,
      String yes = "Yes",
      String no = "No"})
      : super(key: key) {
    _title = title;
    _content = content;
    _yesOnPressed = yesOnPressed;
    _noOnPressed = noOnPressed;
    _yes = yes;
    _no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title ?? ""),
      content: Text(_content ?? ""),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: PrimaryButton(
                    title: _yes ?? "Yes",
                    onAction: () {
                      _yesOnPressed();
                    }),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SecondryButton(
                  title: _no ?? "No",
                  onAction: () {
                    _noOnPressed();
                  }),
            )),
          ],
        )
      ],
    );
  }
}
