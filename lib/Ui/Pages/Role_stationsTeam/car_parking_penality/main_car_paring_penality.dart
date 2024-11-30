import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import '../../../../bloc/car_parking_pelanty_bloc/bloc_car_penalty_submit.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Widgets/DividerShadow.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/Ui/Widgets/dropdownFIeldWidget.dart';
import 'package:railpaytro/Ui/Widgets/top_header_case.dart';
import 'package:railpaytro/bloc/car_parking_pelanty_bloc/bloc_car_penalty.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/service/navigation_service.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/toast_service.dart';
import '../../../../data/local/sqlite.dart';
import '../../../../data/model/car_parking_penalty/car_parking_penalty.dart';
import '../../../../data/model/car_parking_penalty/location_car_park.dart';
import '../../../../data/model/lookup_model.dart';
import '../../../../data/model/station/revp_station_model.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/whiteButton.dart';
import 'images_car_parking_penality.dart';

class CarParkingPenalityMain extends StatefulWidget {
  String issueTitle;

  CarParkingPenalityMain(this.issueTitle, {Key? key});

  @override
  _CarParkingPenalityMainState createState() => _CarParkingPenalityMainState();
}

class _CarParkingPenalityMainState extends State<CarParkingPenalityMain> {
  String menu = "";
  bool manual = false;
  bool noInternet = false;
  bool auto = true;
  String? stationResult;
  String? reasonIssueID;
  String? reasonIssueTitle;
  REASON_FOR_ISSUE_FOR_PCNBean? offenceSelectionList;
  List<REASON_FOR_ISSUE_FOR_PCNBean> offenceList = [];

  //For location DropDown
  dynamic dataobj;
  List<REVPPARKINGLOCATIONSARRAYBean?> carparklocationlist = [];
  List<DropdownMenuItem<REVPPARKINGLOCATIONSARRAYBean>> _dropdownMenuItems = [];
  REVPPARKINGLOCATIONSARRAYBean? _selectedLocation;

  String offenceDateTime = "";
  DateTime? offenceDateTimeRaw;
  String station = "";
  String formatedTime = "";
  String formatedDate = "";
  TextEditingController dateController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController makeController = TextEditingController();

  late RevpStationModel? revpStationModel;
  late LookupModel offenceModel = LookupModel();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    long = position.longitude.toString();
    lat = position.latitude.toString();
    print(long);
    print(lat);
    setState(() {});

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {});
    });
  }

  searchVehicledetail(BuildContext context,
      {regNum, String make = '', model = '', color = ''}) {
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow,
                    border: Border.all(color: Colors.black, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                    vehicleController.text.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 25),
                  )),
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: boxtextMediumBold(
                            title: "Make",
                          )),
                          Container(
                              width: 50.w,
                              child: boxtextMedium(
                                title: make,
                              )),
                        ],
                      ),
                    ),
                    DividerShadow(),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: boxtextMediumBold(
                            title: "Model",
                          )),
                          Container(
                              width: 50.w,
                              child: boxtextMedium(
                                title: model,
                              )),
                        ],
                      ),
                    ),
                    DividerShadow(),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: boxtextMediumBold(
                            title: "Colour",
                          )),
                          Container(
                              width: 50.w,
                              child: boxtextMedium(
                                title: color,
                              )),
                        ],
                      ),
                    ),
                    DividerShadow(),
                    SizedBox(
                      height: 3.h,
                    ),
                    PrimaryButton(
                        title: "Correct",
                        onAction: () {
                          setState(() {
                            makeController.text = make;
                            modelController.text = model;
                            colorController.text = color;
                            Navigator.pop(context, true);
                          });
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    whiteButton(
                        title: "Incorrect - Enter Manually",
                        onAction: () {
                          Navigator.pop(context, true);
                        }),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  errorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: primaryColor, width: 2)),
          backgroundColor: blackColor,
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          insetPadding: EdgeInsets.all(20),
          title: headingText(
            title: "Vehicle Registration Not Recognised",
          ),
          content: subheadingText(
            title:
                "Please check the vehicle registration number and re-enter if needed, else please enter the Make /Model and Colour manually.",
          ),
          actions: [
            PrimaryButton(
                title: "OK",
                onAction: () {
                  Navigator.pop(context);
                })
          ],
        );
        ;
      },
    );
  }

  Future<void> getFilterData(BuildContext context) async {
    final result = await locator<NavigationService>()
        .push(StationsListScreenRoute(caseType: "PCN"));
    setState(() {
      if (result.toString() != "null") {
        stationResult = result.toString();
      } else {
        stationResult = null;
      }
    });
  }

  Future<void> getIssueData(BuildContext context, String reason) async {
    final result = await locator<NavigationService>().push(
        PcnLookupListRoute(caseType: "PCN", categoryList: reason, exrta: ""));
    setState(() {
      if (result.toString() != "null") {
        offenceSelectionList = result as REASON_FOR_ISSUE_FOR_PCNBean;
      } else {
        offenceSelectionList = null;
      }
    });
  }

  Future<void> getLocationData(BuildContext context, String station) async {
    final result = await locator<NavigationService>().push(PcnLookupListRoute(
        caseType: "PCN", categoryList: "Car Park Location", exrta: station));
    setState(() {
      if (result.toString() != "null") {
        _selectedLocation = result as REVPPARKINGLOCATIONSARRAYBean?;
      } else {
        _selectedLocation = null;
      }
    });
  }

  @override
  void initState() {
    offenceDateTimeRaw = DateTime.now();
    formatedTime = DateFormat('HH:mm').format(DateTime.now());
    formatedDate = DateFormat.MMMEd().format(offenceDateTimeRaw!);
    offenceDateTime =
        DateFormat("d MMM yyyy  HH:mm").format(offenceDateTimeRaw!);
    print(offenceDateTime);
    if (_dropdownMenuItems.isNotEmpty) {
      // _selectedLocation =
      // _dropdownMenuItems[0].value;
    } // Offence List dropdown
    List<REASON_FOR_ISSUE_FOR_PCNBean> list = [];
    offenceModel = BlocProvider.of<GlobalBloc>(context).lookupModel!;
    for (var element in offenceModel.REASON_FOR_ISSUE_FOR_PCN!) {
      list.add(element);
    }
    offenceList = list;
    checkGps();
    super.initState();
  }

  List<DropdownMenuItem<REVPPARKINGLOCATIONSARRAYBean>> buildDropdownMenuItems(
      List<REVPPARKINGLOCATIONSARRAYBean?> companies) {
    List<DropdownMenuItem<REVPPARKINGLOCATIONSARRAYBean>> items = [];
    for (REVPPARKINGLOCATIONSARRAYBean? company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company?.location_name ?? "Station"),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(REVPPARKINGLOCATIONSARRAYBean? location) {
    setState(() {
      _selectedLocation = location!;
    });
  }

  Future<void> getStation(BuildContext context) async {
    final result = await locator<NavigationService>()
        .push(StationsListScreenRoute(caseType: "PCN"));
    setState(() {
      _selectedLocation = null;
      if (result.toString() != "null") {
        station = result.toString();
      } else {
        station = "";
      }
    });
    carparklocationlist =
        await SqliteDB.instance.getCarParkingListList(station);
    setState(() {
      //   //For location dropdown
      //   _selectedLocation = null;
      //   _dropdownMenuItems = buildDropdownMenuItems(carparklocationlist);
      if (carparklocationlist.isNotEmpty && carparklocationlist.length == 1) {
        _selectedLocation = carparklocationlist[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);

    return Scaffold(
      backgroundColor: secondryColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      body: Stack(children: [
        Container(
            width: 100.w,
            height: 100.h,
            decoration: gradientDecoration,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: screenPadding,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ProgressBar(
                                      deviceWidth: 20.w, color: primaryColor),
                                  ProgressBar(
                                      deviceWidth: 20.w, color: blueGrey),
                                  ProgressBar(
                                      deviceWidth: 20.w, color: blueGrey),
                                  ProgressBar(
                                      deviceWidth: 20.w, color: blueGrey),

                                  /* const SizedBox(
                                        width: 10,
                                      ),
                                      ProgressBox(deviceWidth: deviceWidth, color: primaryColor),*/
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: auto,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              boxtextBoldH2(
                                                  title: "Offence Date & Time"),
                                              LargeSpace(),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 3.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: primaryColor,
                                                        width: 2)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    boxtextBoldH1(
                                                        title: formatedDate),
                                                    Text(
                                                      "   |   ",
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 20.sp),
                                                    ),
                                                    boxtextBoldH1(
                                                        title: formatedTime),
                                                  ],
                                                ),
                                              ),
                                              LargeSpace(),
                                              LargeSpace(),
                                              boxtextBoldH2(
                                                  title: "Registration Number"),
                                              SmallSpace(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 5.h,
                                                      child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontFamily:
                                                                  "railBold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          controller:
                                                              vehicleController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .characters,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Enter Vehicle Registration',
                                                            hintStyle: TextStyle(
                                                                fontSize: 10.sp,
                                                                fontFamily:
                                                                    "RailLight",
                                                                color: Colors
                                                                    .black87),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none,
                                                              ),
                                                            ),
                                                            filled: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            fillColor:
                                                                Colors.yellow,
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  BlocListener<CarPenaltyBloc,
                                                          CarPenaltyState>(
                                                      listener:
                                                          (BuildContext context,
                                                              state) {
                                                        if (state
                                                            is VehicleFoundSuccessfully) {
                                                          callDialog(
                                                              state.data);
                                                        } else {
                                                          errorDialog(context);
                                                          // Utils.showToast(
                                                          //     "Unable to find Vehicle Please enter Details Manually");
                                                          setState(() {
                                                            auto = !auto;
                                                            manual = !manual;
                                                          });
                                                        }
                                                      },
                                                      child: SizedBox(
                                                          height: 5.h,
                                                          width: 100,
                                                          child: PrimaryButton(
                                                              title: "Search",
                                                              onAction: () {
                                                                if (vehicleController
                                                                    .text
                                                                    .isEmpty) {
                                                                  locator<ToastService>()
                                                                      .showValidationMessage(
                                                                          context,
                                                                          "Enter vehicle registration number");
                                                                } else {
                                                                  BlocProvider.of<
                                                                              CarPenaltyBloc>(
                                                                          context)
                                                                      .add(CarPenaltySearchEvent(
                                                                          regId:
                                                                              vehicleController.text));
                                                                }
                                                              })))
                                                ],
                                              ),
                                              SmallSpace(),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    auto = !auto;
                                                    manual = !manual;
                                                  });
                                                },
                                                child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child:
                                                        boxtextBold(title: "")),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            child: Visibility(
                                          visible: noInternet,
                                          child: SecondryButton(
                                              title: "Manual",
                                              onAction: () {
                                                setState(() {
                                                  auto = !auto;
                                                  manual = !manual;
                                                  noInternet = !noInternet;
                                                });
                                              }),
                                        )),
                                        LargeSpace(),
                                        Visibility(
                                          visible: manual,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              boxtextBoldH2(
                                                  title: "Vehicle Details"),

                                              SmallSpace(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 5.h,
                                                      child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontFamily:
                                                                  "railBold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          controller:
                                                              vehicleController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .characters,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Enter Vehicle Registration',
                                                            hintStyle: TextStyle(
                                                                fontSize: 10.sp,
                                                                fontFamily:
                                                                    "RailLight",
                                                                color: Colors
                                                                    .black87),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none,
                                                              ),
                                                            ),
                                                            filled: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            fillColor:
                                                                Colors.yellow,
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  BlocListener<CarPenaltyBloc,
                                                          CarPenaltyState>(
                                                      listener:
                                                          (BuildContext context,
                                                              state) {
                                                        if (state
                                                            is VehicleFoundSuccessfully) {
                                                          callDialog(
                                                              state.data);
                                                        } else {
                                                          errorDialog(context);
                                                          // Utils.showToast(
                                                          //     "Unable to find Vehicle Please enter Details Manually");
                                                          setState(() {
                                                            auto = !auto;
                                                            manual = !manual;
                                                          });
                                                        }
                                                      },
                                                      child: SizedBox(
                                                          height: 5.h,
                                                          width: 100,
                                                          child: PrimaryButton(
                                                              title: "Search",
                                                              onAction: () {
                                                                if (vehicleController
                                                                    .text
                                                                    .isEmpty) {
                                                                  locator<ToastService>()
                                                                      .showValidationMessage(
                                                                          context,
                                                                          "Enter vehicle registration number");
                                                                } else {
                                                                  BlocProvider.of<
                                                                              CarPenaltyBloc>(
                                                                          context)
                                                                      .add(CarPenaltySearchEvent(
                                                                          regId:
                                                                              vehicleController.text));
                                                                }
                                                              })))
                                                ],
                                              ),
                                              LargeSpace(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 42.w,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        boxtextBold(
                                                            title: "Make"),
                                                        SmallSpace(),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white)),
                                                          height: 5.5.h,
                                                          child: TextField(
                                                            enabled: true,
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "railLight"),
                                                            controller:
                                                                makeController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: TextStyle(
                                                                        fontSize: 10
                                                                            .sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "railLight"),
                                                                    hintText:
                                                                        'Enter Make..',
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        width:
                                                                            0,
                                                                        style: BorderStyle
                                                                            .none,
                                                                      ),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    contentPadding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    suffixIcon:
                                                                        GestureDetector(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Icon(
                                                                              Icons.edit,
                                                                              color: Colors.white,
                                                                              size: 14.sp,
                                                                            ))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 42.w,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        boxtextBold(
                                                            title: "Colour"),
                                                        SmallSpace(),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white)),
                                                          height: 5.5.h,
                                                          child: TextField(
                                                            enabled: true,
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "railLight"),
                                                            controller:
                                                                colorController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: TextStyle(
                                                                        fontSize: 10
                                                                            .sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "railLight"),
                                                                    hintText:
                                                                        'Enter Colour..',
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        width:
                                                                            0,
                                                                        style: BorderStyle
                                                                            .none,
                                                                      ),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    contentPadding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    suffixIcon:
                                                                        GestureDetector(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Icon(
                                                                              Icons.edit,
                                                                              color: Colors.white,
                                                                              size: 14.sp,
                                                                            ))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              MediumSpace(),
                                              boxtextBold(title: "Model"),
                                              SmallSpace(),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                height: 5.5.h,
                                                child: TextField(
                                                  enabled: true,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white,
                                                      fontFamily: "railLight"),
                                                  controller: modelController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      hintText: 'Enter Model..',
                                                      hintStyle: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "railLight"),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      suffixIcon:
                                                          GestureDetector(
                                                              onTap: () {},
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .white,
                                                                size: 14.sp,
                                                              ))),
                                                ),
                                              ),
                                              MediumSpace(),
                                              // if (_selectedLocation != null)
                                              LargeSpace(),
                                              boxtextBoldH2(
                                                  title: "Offence Details"),
                                              MediumSpace(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  boxtextBold(title: "Station"),
                                                  SmallSpace(),
                                                  DropdownField(
                                                    onTap: () {
                                                      getStation(context);
                                                    },
                                                    title: station == ""
                                                        ? "Search Station..."
                                                        : station.toString(),
                                                  ),
                                                ],
                                              ),
                                              MediumSpace(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  boxtextBold(
                                                      title:
                                                          "Car Park Location"),
                                                  SmallSpace(),
                                                  DropdownField(
                                                      onTap: () {
                                                        getLocationData(
                                                            context, station);
                                                      },
                                                      title: _selectedLocation ==
                                                              null
                                                          ? "Select Location"
                                                          : _selectedLocation!
                                                              .location_name
                                                              .toString()),
                                                ],
                                              ),
                                              MediumSpace(),
                                              boxtextBold(
                                                  title: "Issuing Reason"),
                                              SmallSpace(),
                                              DropdownField(
                                                  onTap: () {
                                                    getIssueData(context,
                                                        "Issuing Reason");
                                                  },
                                                  title: offenceSelectionList ==
                                                          null
                                                      ? "Select Reason"
                                                      : offenceSelectionList!
                                                          .lookup_data_value
                                                          .toString()),

                                              LargeSpace(),
                                            ],
                                          ),
                                        ),
                                      ])
                                ])),
                          ])),
                  Visibility(
                    visible: manual,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                auto = !auto;
                                manual = !manual;
                              });
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
                        InkWell(
                            onTap: () {
                              if (vehicleController.text.isEmpty) {
                                locator<ToastService>().showValidationMessage(
                                    context,
                                    "vehicle registration number is required");
                              } else if (makeController.text.isEmpty) {
                                locator<ToastService>().showValidationMessage(
                                    context, "Vehicle Make is required");
                              } else if (modelController.text.isEmpty) {
                                locator<ToastService>().showValidationMessage(
                                    context, "Vehicle Model is required");
                              } else if (colorController.text.isEmpty) {
                                locator<ToastService>().showValidationMessage(
                                    context, "Vehicle Colour is required");
                              } else if (station.isEmpty) {
                                locator<ToastService>().showValidationMessage(
                                    context, "Please select station");
                              } else if (_selectedLocation == null) {
                                locator<ToastService>().showValidationMessage(
                                    context, "Please select location");
                              } else if (offenceSelectionList == null) {
                                locator<ToastService>().showValidationMessage(
                                    context, "Please select an offence");
                              } else {
                                var dataobj = {
                                  "offencetime": offenceDateTime,
                                  "offencetimeRaw": offenceDateTimeRaw,
                                  "vehicle": vehicleController.text,
                                  "make": makeController.text,
                                  "model": modelController.text,
                                  "color": colorController.text,
                                  "location": _selectedLocation!.toJson(),
                                  'station': station,
                                  "reason_title":
                                      offenceSelectionList?.lookup_data_value ??
                                          "",
                                  "reason_id":
                                      offenceSelectionList?.lookup_data_id ??
                                          "",
                                };
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CarParkingPenalityIImages(
                                                dataobj)));
                                BlocProvider.of<PenaltySubmitBloc>(context)
                                    .add(SetLatLongEvent(lat, long));
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
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
        Positioned(
            top: 0,
            child: TopHeaderCase(
                title: "Penalty Charge Notice ", icon: "Assets/icons/car.png")),
      ]),
    );
  }

  callDialog(REVPVEHICLEDATAARRAYBean data) async {
    final result = await searchVehicledetail(context,
        regNum: vehicleController.text,
        color: data.COLOUR,
        make: data.MAKE!,
        model: data.MODEL);
    if (result == true) {
      setState(() {
        auto = !auto;
        manual = !manual;
      });
    }
  }
}
