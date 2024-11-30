import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/Utillities.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Utils/strings.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/auth_bloc/auth_bloc.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/service/dialog_service.dart';
import 'package:railpaytro/constants/app_config.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/global_bloc.dart';
import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/common_offline_status.dart';
import '../../common/service/navigation_service.dart';
import '../../data/constantes/constants.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../main.dart';
import '../Utils/HelpfullMethods.dart';
import '../Widgets/DrawerLogout.dart';
import '../Widgets/SpaceWidgets.dart';
import 'Role_stationsTeam/homescreen_issue_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String DEFAULTREVENUEPROTECTIONTEAM = "";
  LoginModel user = LoginModel();
  String menu = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  static final Config config = Config(
      tenant: AppConfig.tenant,
      clientId: AppConfig.clientId,
      scope: AppConfig.scope,
      isB2C: false,
      redirectUri: AppConfig.redirectUri,
      navigatorKey: navigatorKey,
      loader: const Center(child: CircularProgressIndicator()));
  AadOAuth oauth = AadOAuth(config);

  @override
  void initState() {
    getUserSetting();
    DEFAULTREVENUEPROTECTIONTEAM = user.DEFAULTREVENUEPROTECTIONTEAM.toString();
    super.initState();
  }

  getUserSetting() async {
    // user = await SqliteDB.instance.getLoginModelData();
    setState(() {
      DEFAULTREVENUEPROTECTIONTEAM =
          user.DEFAULTREVENUEPROTECTIONTEAM.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondryColor,
        drawer: drawerLogout(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
        ),
        body: Container(
          decoration: gradientDecoration,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: screenPadding,
                  width: 100.w,
                  height: 75.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Image.asset(
                        mainlogo,
                        color: Colors.white,
                        height: 4.h,
                        width: 100.h,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Center(child: headingText(title: welcomeToRailPay)),
                      SizedBox(
                        height: 5.h,
                      ),
                      boxtextBold(title: email),
                      SmallSpace(),
                      TextFormField(
                        controller: emailController,
                        validator: (email) {
                          if (isEmail(email.toString())) {
                            return null;
                          } else {
                            return emailValidation;
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: email,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: white,
                        ),
                      ),
                      LargeSpace(),
                      boxtextBold(title: password),
                      SmallSpace(),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscured,
                        validator: (password) {
                          if (isPasswordValid(password.toString())) {
                            return null;
                          } else {
                            return passwordLengthValidation;
                          }
                        },
                        keyboardType: TextInputType.text,
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
                          hintText: password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          fillColor: white,
                        ),
                      ),
                      MediumSpace(),
                      GestureDetector(
                          onTap: () {
                            locator<NavigationService>()
                                .push(const ForgotPasswordRoute());
                          },
                          child: boxtextBoldUnderline(title: forgotPassword)),
                      LargeSpace(),
                      MultiBlocListener(
                        listeners: [
                          BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginLoadingState) {
                                locator<DialogService>().showLoader();
                              } else if (state is LoginSuccessState) {
                                if (state.loginModel
                                        ?.DEFAULTREVENUEPROTECTIONTEAM
                                        .toString()
                                        .toLowerCase() ==
                                    "roaming") {
                                  locator<DialogService>().hideLoader();
                                  locator<NavigationService>()
                                      .pushAndRemoveUntil(HomescreenRoute(
                                      isOfflineApiRequired: true));

                                  BlocProvider.of<GlobalBloc>(context)
                                      .add(GlobalInsertOfflineDataEvent());
                                } else {
                                  locator<DialogService>().hideLoader();


                                  locator<NavigationService>()
                                      .pushAndRemoveUntil(
                                      UnPaidFareIssueMainRoute(
                                          isOfflineApiRequired: false));
                                }
                              }
                            },
                          ),
                        ],
                        child: PrimaryButton(
                          onAction: () async {
                            if (emailController.text.isEmpty) {
                              Dialogs.showValidationMessage(
                                  context, emailEmptyValidation);
                            } else if (passwordController.text.isEmpty) {
                              Dialogs.showValidationMessage(
                                  context, passwordEmptyValidation);
                            } else {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginRefreshEvent(
                                      context,
                                      emailController.text,
                                      passwordController.text,
                                      "",
                                      "PASSWORD"));
                            }
                          },
                          title: signIn,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // PrimaryButton(
                      //   onAction: () async {
                      //     String? accessToken =   await ssoLogin();
                      //     if(accessToken != null && accessToken.isNotEmpty) {
                      //       BlocProvider.of<LoginBloc>(context).add(
                      //           LoginRefreshEvent(context, emailController.text,
                      //               passwordController.text, accessToken, "SSO"));
                      //     }
                      //     },
                      //   title: ssoLoginText,
                      //
                      // ),
                      LargeSpace(),
                    ],
                  ),
                ),
                ClipPath(
                    clipper: OvalTopBorderClipper(),
                    child: Container(
                        color: secondryColor,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            subheadingText(title: "Powered By:"),
                            SizedBox(
                              height: 1.h,
                            ),
                            Image.asset(
                              logoURl,
                              color: Colors.white,
                              height: 3.h,
                              width: 100.h,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        )))
              ],
            ),
          ),
        ));
  }

  Future<String?> ssoLogin() async {
    final result = await oauth.login();
    result.fold(
      (failure) => print(failure.toString()),
      (token) => print('Logged in successfully, your access token: $token'),
    );
    String? accessToken = await oauth.getAccessToken();
    logout();
    return accessToken;
  }

  void logout() async {
    await oauth.logout();
    Dialogs.showValidationMessage(context, 'Logged out');
  }
}
