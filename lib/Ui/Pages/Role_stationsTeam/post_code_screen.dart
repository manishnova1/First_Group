import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/SpaceWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/common/Utils/utils.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/common/service/dialog_service.dart';
import 'package:railpaytro/common/service/toast_service.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../data/local/sqlite.dart';
import '../../../data/model/auth/login_model.dart';
import '../../../data/model/ufn/AddressListModel.dart';
import '../../../data/model/ufn/FullAddressListModel.dart';
import '../../../data/repo/ufn_repo.dart';

class PostCodeScreen extends StatefulWidget {
  const PostCodeScreen({Key? key}) : super(key: key);

  @override
  _PostCodeScreenState createState() => _PostCodeScreenState();
}

class _PostCodeScreenState extends State<PostCodeScreen> {
  String menu = "";
  String countrySelect = "";
  final searchCOnt = TextEditingController();
  TextEditingController addressOne = TextEditingController();
  TextEditingController addressTwo = TextEditingController();
  TextEditingController city = TextEditingController();
  UfnRepo ufnRepo = UfnRepo();
  List customerLanguages = ["English", "Welsh/Cymraeg"];
  String selectLang = "English";
  bool isLocalitySelected = true;
  List<DataAddress> listData = [];
  final TextEditingController _typeAheadController = TextEditingController();
  FocusNode inputNode = FocusNode();
  String? searchLocationPostCode;
  String? searchLocationId;

  Future<dynamic> getAddressList(postCode, container, context) async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    try {
      var res = await ufnRepo.getAddressList(
          userId: user.STUSER!.ID!,
          postCode: postCode ?? "",
          container: container ?? "",
          sessionId: user.STCONFIG!.SAPPSESSIONID!,
          macAddress: user.STUSER!.MACADRESS!);
      if (res.isSuccess) {
        Iterable listAddress = res.data;
        listData = listAddress.map((e) => DataAddress.fromJson(e)).toList();
        isLocalitySelected = true;
      }
    } catch (e, stacktrace) {
      print(e.toString());
      FocusScope.of(context).unfocus();
      listData = [];
    }
  }

  Future<dynamic> getFullAddressList(id, context) async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    locator<DialogService>().showLoader();
    var res = await ufnRepo.getFullAddressList(
        userId: user.STUSER!.ID!,
        sessionId: user.STCONFIG!.SAPPSESSIONID!,
        macAddress: user.STUSER!.MACADRESS!,
        id: id);
    if (res.isSuccess) {
      Iterable listAddress = res.data;
      List<DataFullAddress> fullAdddressList =
          listAddress.map((e) => DataFullAddress.fromJson(e)).toList();
      locator<DialogService>().hideLoader();
      if (fullAdddressList.isNotEmpty) {
        DataFullAddress dataFullAddress = fullAdddressList[0];
        _typeAheadController.text = dataFullAddress.postalcode.toString();
        setState(() {
          countrySelect = dataFullAddress.countryname.toString();
        });
        addressOne.text = dataFullAddress.line1.toString();
        addressTwo.text = dataFullAddress.line2.toString();
        city.text = dataFullAddress.city.toString();
        searchLocationId = dataFullAddress.id.toString();
        searchLocationPostCode = dataFullAddress.postalcode.toString();

        BlocProvider.of<AddressUfnBloc>(context)
            .add(OnFullAddressSelectEvent(context, dataFullAddress));
        isLocalitySelected = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressUfnBloc>(context).add(AddressUfnInitializeEvent());
    _typeAheadController.addListener(() {
      if (_typeAheadController.text.isEmpty) {
        searchLocationPostCode = null;
        searchLocationId = null;
        city.text = "";
        addressTwo.text = "";
        addressTwo.text = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boxtextBold(title: "Postcode"),
                BlocBuilder<AddressUfnBloc, AddressUfnState>(
                  builder: (c, s) {
                    if (s is AddressUfnLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 188.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (s is AddressUfnSuccessState) {
                      return Container(
                        width: 100.w,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 00, vertical: 10),
                        child: TypeAheadFormField(
                          keepSuggestionsOnLoading: false,
                          textFieldConfiguration: TextFieldConfiguration(
                            autofocus: true,
                            enabled: true,
                            focusNode: inputNode,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Search by postcode',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            controller: _typeAheadController,
                          ),
                          debounceDuration: const Duration(milliseconds: 400),
                          suggestionsCallback: (pattern) async {
                            if (pattern.isNotEmpty) {
                              await getAddressList(
                                  searchLocationPostCode ?? pattern,
                                  searchLocationId ?? "",
                                  context);
                            }
                            return listData;
                          },
                          itemBuilder: (context, suggestion) {
                            DataAddress dataAddress = suggestion as DataAddress;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      dataAddress.descriptionaddress ?? "",
                                      style: TextStyle(fontSize: 12.sp)),
                                ),
                                const Divider()
                              ],
                            );
                          },
                          hideSuggestionsOnKeyboardHide: false,
                          hideKeyboard: false,
                          onSuggestionSelected: (suggestion) async {
                            DataAddress dataAddress = suggestion as DataAddress;
                            if (dataAddress.type == "Address" &&
                                isLocalitySelected) {
                              FocusScope.of(context).unfocus();
                              /*   _typeAheadController.text =
                                    dataAddress.descriptionaddress.toString();*/
                              await getFullAddressList(
                                  dataAddress.id ?? "", context);
                            } else {
                              searchLocationPostCode = dataAddress.postcode;
                              searchLocationId = dataAddress.id;
                              Future.delayed(const Duration(milliseconds: 400),
                                  () {
                                FocusScope.of(context).requestFocus(inputNode);
                              });
                            }
                          },
                          noItemsFoundBuilder: (context) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address not found, enter it manually",
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                const Icon(
                                  Icons.add_circle,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('Something Went Wrong'));
                    }
                  },
                ),
                LargeSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boxtextBold(title: "Address Line 1"),
                    SmallSpace(),
                    SizedBox(
                      width: 100.w,
                      height: 6.4.h,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 12.sp),
                        controller: addressOne,
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
                    boxtextBold(title: "Address Line 2"),
                    SmallSpace(),
                    SizedBox(
                      width: 100.w,
                      height: 6.4.h,
                      child: TextField(
                        controller: addressTwo,
                        style: TextStyle(fontSize: 12.sp),
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
                    boxtextBold(title: "Town / City"),
                    SmallSpace(),
                    Container(
                      width: 100.w,
                      height: 6.4.h,
                      child: TextField(
                        controller: city,
                        style: TextStyle(fontSize: 12.sp),
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
                    boxtextBold(title: "Customer Language"),
                    SmallSpace(),
                    Container(
                        width: 100.w,
                        height: 6.4.h,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          value: selectLang,
                          hint: selectLang == ""
                              ? Text('Select Language',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp))
                              : Text(
                                  selectLang,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 16.sp,
                          ),
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                          items: customerLanguages.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val,
                                    style: TextStyle(fontSize: 12.sp)),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                selectLang = val.toString();
                              },
                            );
                          },
                        ))),
                    LargeSpace(),
                    PrimaryButton(
                        title: "Confirm",
                        onAction: () async {
                          if (addressOne.text.isEmpty) {
                            locator<ToastService>()
                                .show("Address Line 1 is required.");
                          } else if (city.text.isEmpty) {
                            locator<ToastService>().show("Enter Town/City ");
                          } else {
                            bool checkInternet = await Utils.checkInternet();
                            if (checkInternet) {
                              Navigator.pop(context, "$searchLocationPostCode");
                            } else {
                              BlocProvider.of<AddressUfnBloc>(context).add(
                                  OfflineAddressSavedEvent(
                                      context,
                                      _typeAheadController.text,
                                      addressOne.text,
                                      addressTwo.text,
                                      city.text,
                                      selectLang));
                              Navigator.pop(
                                  context, "${_typeAheadController.text}");
                            }
                          }
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List countriesList = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua & Deps",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Rep",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Congo {Democratic Rep}",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland {Republic}",
    "Israel",
    "Italy",
    "Ivory Coast",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea North",
    "Korea South",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar, {Burma}",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russian Federation",
    "Rwanda",
    "St Kitts & Nevis",
    "St Lucia",
    "Saint Vincent & the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome & Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tonga",
    "Trinidad & Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
}
