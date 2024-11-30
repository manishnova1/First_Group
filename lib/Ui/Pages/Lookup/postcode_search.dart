import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/DividerShadow.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/common/service/toast_service.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../common/locator/locator.dart';
import '../../../common/service/dialog_service.dart';
import '../../../common/service/navigation_service.dart';
import '../../../data/local/sqlite.dart';
import '../../../data/model/auth/login_model.dart';
import '../../../data/model/ufn/AddressListModel.dart';
import '../../../data/model/ufn/FullAddressListModel.dart';
import '../../../data/repo/ufn_repo.dart';
import '../../Utils/DeviceSize.dart';
import '../../Utils/defaultPadiing.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/PrimaryButton.dart';
import '../../Widgets/SpaceWidgets.dart';
import '../../Widgets/backButton.dart';
import '../../Widgets/top_header_case.dart';

class PostCodeSearch extends StatefulWidget {
  @override
  _PostCodeSearchState createState() => _PostCodeSearchState();
}

class _PostCodeSearchState extends State<PostCodeSearch> {
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
    } else {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(context!).submitAddressMap;
      Map<String, dynamic> dumpMap = {'manual': "1"};
      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(context!).submitAddressMap = subMap;
      if (res.error.isNotEmpty) {
        FocusScope.of(context).unfocus();
        listData = [];
        locator<ToastService>()
            .showLong("Connection Timeout: Please enter address manually.");
        locator<NavigationService>().pop("timeout");
      } else {
        FocusScope.of(context).requestFocus(inputNode);
      }
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
        Navigator.pop(context, dataFullAddress);
        isLocalitySelected = false;
      }
    }
  }

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = getHeight(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      backgroundColor: secondryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: gradientDecoration,
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingText(
                      title: "Find Address",
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boxtextBold(title: "Post Code"),
                          InkWell(
                            onTap: () {
                              locator<NavigationService>().pop([
                                "timeout",
                                _typeAheadController.text.toString()
                              ]);
                            },
                            child: Card(
                                color: primaryColor,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    child: subheadingTextBOLD(
                                        title: " OVERRIDE ADDRESS"))),
                          ),
                        ]),
                    SizedBox(
                      height: 2.h,
                    ),
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
                                decoration: InputDecoration(
                                  hintText: ' Search...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.search,
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  fillColor: white,
                                ),
                                controller: _typeAheadController,
                              ),
                              debounceDuration: const Duration(milliseconds: 400),
                              suggestionsBoxDecoration:
                                  const SuggestionsBoxDecoration(
                                      color: Colors.transparent,
                                      shadowColor: Colors.transparent),
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
                                DataAddress dataAddress =
                                    suggestion as DataAddress;
                                return itemBox(dataAddress);
                              },
                              hideSuggestionsOnKeyboardHide: false,
                              hideKeyboard: false,
                              onSuggestionSelected: (suggestion) async {
                                DataAddress dataAddress =
                                    suggestion as DataAddress;
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
                                  Future.delayed(
                                      const Duration(milliseconds: 400), () {
                                    FocusScope.of(context)
                                        .requestFocus(inputNode);
                                  });
                                }
                              },
                              noItemsFoundBuilder: (context) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: PrimaryButton(
                                    title: "Address not found, enter it manually",
                                    onAction: () {
                                      locator<NavigationService>().pop("timeout");
                                    }),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('Something Went Wrong'));
                        }
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBox(data) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 3.w,
          leading: Icon(
            CupertinoIcons.location_solid,
            color: primaryColor,
          ),
          title: Text(
            /*isNormalStation ? data.value :*/
            data.descriptionaddress ?? "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 11.sp,
              fontFamily: "railLight",
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DividerShadow(),
      ],
    );
  }
}
