import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/HelpfullMethods.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import '../../common/service/common_offline_status.dart';
import 'package:railpaytro/bloc/auth_bloc/change_password_bloc.dart';
import 'package:sizer/sizer.dart';
import '../Utils/Utillities.dart';
import '../Widgets/DrawerLogout.dart';
import '../Widgets/SpaceWidgets.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  String menu = "";
  TextEditingController passCont = TextEditingController();
  TextEditingController cPassCont = TextEditingController();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  bool _obscuredConfirm = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
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
      drawer: drawerLogout(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      backgroundColor: secondryColor,
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: gradientDecoration,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 85.h,
                padding: screenPadding,
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
                        boxtextBold(title: "New Password"),
                        SmallSpace(),
                        TextFormField(
                          controller: passCont,
                          validator: (val) {
                            if (val != null &&
                                val.isNotEmpty &&
                                validateStructure(passCont.text) == true &&
                                passCont.text.length >= 8) {
                              return null;
                            } else {
                              return 'Enter new password ';
                            }
                          },
                          keyboardType: TextInputType.text,
                          obscureText: _obscured,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                            subheadingTextBOLD(title: "  Password Policy")
                          ],
                        ),
                        MediumSpace(),
                        subheadingText(
                            title:
                                "Password must be a minimum of 8 characters.\nAt least one number.\nAt least one symbol character.\nConfirm password as new password."),
                        MediumSpace(),
                        LargeSpace(),
                      ],
                    ),
                    PrimaryButton(
                      onAction: () {
                        if (passCont.text.isEmpty) {
                          Dialogs.showValidationMessage(
                              context, "Please enter new Password");
                        } else if (validateStructure(passCont.text) == false ||
                            passCont.text.length < 8) {
                          Dialogs.showValidationMessage(context,
                              "Password is not meeting password policy");
                        } else if (validateStructure(cPassCont.text) == false ||
                            cPassCont.text.length < 8) {
                          Dialogs.showValidationMessage(context,
                              "Confirm Password is not meeting password policy");
                        } else if (cPassCont.text.isEmpty) {
                          Dialogs.showValidationMessage(
                              context, "Please enter confirm Password");
                        } else if (passCont.text != cPassCont.text) {
                          Dialogs.showValidationMessage(
                              context, "Password didn\'t matched");
                        } else {
                          BlocProvider.of<ChangePasswordBloc>(context).add(
                              ChangePasswordRefreshEvent(
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
      ),
    );
  }
}
