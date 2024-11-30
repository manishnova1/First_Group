import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import '../../data/constantes/constants.dart';
import '../Utils/DeviceSize.dart';
import '../Widgets/SpaceWidgets.dart';
import 'Role_stationsTeam/homescreen_issue_screen.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  List<String> atStationLocation = [
    'Delhi',
    'MUMBAI',
    'Raipur',
    'Bilaspur',
    'CHENNAI'
  ];
  List<String> onTrainLocation = [
    'Delhi',
    'MUMBAI',
    'Raipur',
    'Bilaspur',
    'CHENNAI'
  ];
  List<String> roamingInspectorList = [
    'Delhi',
    'MUMBAI',
    'Raipur',
    'Bilaspur',
    'CHENNAI'
  ];

  String menu = "";
  String atStation = "";
  String onTrain = "";
  String roamingInspector = "";

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
      backgroundColor: secondryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                  height: deviceHeight * 0.2,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Image.asset(
                        logoURl,
                        height: deviceHeight * 0.2,
                        width: deviceWidth * 0.5,
                      ),
                    ),
                  ))),
          Padding(
            padding: screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingText(
                  title: "Please confirm your \nlocation or train to proceed",
                ),
                MediumSpace(),
                subheadingText(
                  title:
                      "Please select an option below that matches where your recieved your notice",
                ),
                LargeSpace(),
                MediumSpace(),
                Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.07,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      hint: atStation == ""
                          ? const Text('At Stations',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                          : Text(
                              atStation,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black54),
                      items: atStationLocation.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            atStation = val.toString();
                          },
                        );
                      },
                    ))),
                LargeSpace(),
                Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.07,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      hint: onTrain == ""
                          ? const Text('On Train',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                          : Text(
                              onTrain,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      icon: const Icon(
                        Icons.train_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black54),
                      items: onTrainLocation.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            onTrain = val.toString();
                          },
                        );
                      },
                    ))),
                LargeSpace(),
                Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.07,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white38),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      hint: roamingInspector == ""
                          ? const Text('Roaming Inspector',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                          : Text(
                              roamingInspector,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                      icon: const Icon(
                        CupertinoIcons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black54),
                      items: roamingInspectorList.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            roamingInspector = val.toString();
                          },
                        );
                      },
                    ))),
                LargeSpace(),
                PrimaryButton(
                    title: "Next",
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UnPaidFareIssueMain(
                                isOfflineApiRequired: false)),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
