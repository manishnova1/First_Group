import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/DrawerWidget.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import '../../common/service/common_offline_status.dart';
import 'package:railpaytro/bloc/auth_bloc/change_password_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_utils.dart';
import '../Utils/HelpfullMethods.dart';
import '../Utils/Utillities.dart';
import '../Widgets/SpaceWidgets.dart';
import '../Widgets/backButton.dart';

class ChangeCurrentPassword extends StatefulWidget {
  const ChangeCurrentPassword({Key? key}) : super(key: key);

  @override
  _ChangeCurrentPasswordState createState() => _ChangeCurrentPasswordState();
}

class _ChangeCurrentPasswordState extends State<ChangeCurrentPassword> {
  String menu = "";
  TextEditingController passCont = TextEditingController();
  TextEditingController cPassCont = TextEditingController();
  TextEditingController passCurrent = TextEditingController();

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  bool _obscuredConfirm = true;
  bool _obscuredCurrent = true;
  String PASSWORD = "";

  @override
  void initState() {
    getpass();
    super.initState();
  }

  getpass() async {
    String userPassword = await AppUtils().getUserPassword();
    setState(() {
      PASSWORD = userPassword;
    });
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscuredCurrent() {
    setState(() {
      _obscuredCurrent = !_obscuredCurrent;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscuredConfirm() {
    setState(() {
      _obscuredConfirm = !_obscuredConfirm;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      backgroundColor: secondryColor,
      body: Stack(children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: gradientDecoration,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headingText(
                                  title: "Change your password",
                                ),
                                MediumSpace(),
                                LargeSpace(),
                                boxtextBold(title: "Current Password"),
                                SmallSpace(),
                                TextFormField(
                                  controller: passCurrent,
                                  validator: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Enter current password ';
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: _obscuredCurrent,
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        child: GestureDetector(
                                          onTap: _toggleObscuredCurrent,
                                          child: Icon(
                                            !_obscuredCurrent
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            size: 24,
                                            color: primaryColor,
                                          ),
                                        )),
                                    hintText: 'Enter Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    fillColor: white,
                                  ),
                                ),
                                LargeSpace(),
                                boxtextBold(title: "New Password"),
                                SmallSpace(),
                                TextFormField(
                                  controller: passCont,
                                  validator: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Enter new password ';
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: _obscured,
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        child: GestureDetector(
                                          onTap: _toggleObscured,
                                          child: Icon(
                                            !_obscured
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            size: 24,
                                            color: primaryColor,
                                          ),
                                        )),
                                    hintText: 'Enter Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    fillColor: white,
                                  ),
                                ),
                                LargeSpace(),
                                boxtextBold(title: "Confirm New Password"),
                                SmallSpace(),
                                TextFormField(
                                  controller: cPassCont,
                                  obscureText: _obscuredConfirm,
                                  validator: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Enter confirm Password ';
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        child: GestureDetector(
                                          onTap: _toggleObscuredConfirm,
                                          child: Icon(
                                            !_obscuredConfirm
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            size: 24,
                                            color: primaryColor,
                                          ),
                                        )),
                                    hintText: 'Enter Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    fillColor: white,
                                  ),
                                ),
                                LargeSpace(),
                                LargeSpace(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber,
                                      color: primaryColor,
                                    ),
                                    subheadingTextBOLD(
                                        title: "  Password Policy")
                                  ],
                                ),
                                MediumSpace(),
                                subheadingText(
                                    title:
                                        "Password must be a minimum of 8 characters.\nAt least one number.\nAt least one symbol character.\nCurrent password required.\nConfirm password as new password."),
                                MediumSpace(),
                                LargeSpace(),
                              ],
                            ),
                            PrimaryButton(
                              onAction: () {
                                if (passCurrent.text.isEmpty) {
                                  Dialogs.showValidationMessage(
                                      context, "Enter current password");
                                } else if (passCont.text.isEmpty) {
                                  Dialogs.showValidationMessage(
                                      context, "Enter new password");
                                } else if (cPassCont.text.isEmpty) {
                                  Dialogs.showValidationMessage(
                                      context, "Enter confirm new password");
                                } else if (PASSWORD != passCurrent.text) {
                                  Dialogs.showValidationMessage(
                                      context, "Enter correct  password");
                                } else if (validateStructure(passCont.text) ==
                                        false ||
                                    passCont.text.length < 8) {
                                  Dialogs.showValidationMessage(context,
                                      "Password is not meeting password policy");
                                } else if (validateStructure(cPassCont.text) ==
                                        false ||
                                    cPassCont.text.length < 8) {
                                  Dialogs.showValidationMessage(context,
                                      "Confirm Password is not meeting password policy");
                                } else if (passCont.text != cPassCont.text) {
                                  Dialogs.showValidationMessage(context,
                                      "Confirm Password is not meeting password policy");
                                } else {
                                  BlocProvider.of<ChangePasswordBloc>(context)
                                      .add(ChangePasswordRefreshEvent(
                                          password: passCont.text));
                                }
                              },
                              title: 'Change your password',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ),
        Positioned(
          bottom: 0,
          child: backButton(),
        )
      ]),
    );
  }
}
