
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/issuing_bloc/issuing_submit.dart';
import 'package:sizer/sizer.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import '../../bloc/issuing_bloc/issuing_history_list.dart';
import '../../bloc/printer_bloc/Reprint_bloc.dart';
import '../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../common/locator/locator.dart';
import '../../common/service/toast_service.dart';
import '../../data/model/lookup_model.dart';
import '../Pages/Role_stationsTeam/issuing_history/Reprint_submit.dart';
import 'common_printer_dialog.dart';

class PaymentHistorySearchDialog extends StatefulWidget {
  String caseID;
  String CaseNum;
  PaymentHistorySearchDialog(this.caseID, this.CaseNum);

  @override
  State<StatefulWidget> createState() {
    return PaymentHistorySearchDialogState();
  }
}

class PaymentHistorySearchDialogState extends State<PaymentHistorySearchDialog> {
  CASE_ISSUE_CANCEL_REASONBean? cancelSelectReason;

  List<CASE_ISSUE_CANCEL_REASONBean?> canceReasonList = [];

  late LookupModel? offenceModel;

  String? selectedValue;
  String? Casetype;

  @override
  void initState() {
    String prefix = widget.CaseNum.split("/")[1];
    List<CASE_ISSUE_CANCEL_REASONBean?> list = [];
    offenceModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
    for (var element in offenceModel!.CASE_ISSUE_CANCEL_REASON!) {
      list.add(element);
    }
    canceReasonList = list;
    setState(() {
      Casetype = prefix;
      print(Casetype);

    });
    super.initState();
  }
  onPrintSucessDialog(BuildContext context) async {
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: headingText(
                        title: 'Print Successful',
                      ),
                    )),
                Image.asset(
                  "Assets/icons/success.png",
                  width: 10.w,
                  fit: BoxFit.cover,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Return to Menu",
                              onAction: () {
                                Navigator.pop(context);
                                BlocProvider.of<AddressUfnBloc>(context).submitAddressMap.clear();

                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(
              color: primaryColor, width: 3
          )),
      backgroundColor:darksecondryColor,
      titlePadding: const EdgeInsets.only(top: 20, left: 20, right:20, bottom: 5),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20,vertical:20),
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Case Management',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "medium",
            ),
          ),


          ElevatedButton(
            onPressed: () {
              BlocProvider.of<IssuingSubmitReprintBloc>(context).add(
                issuingButtonReprintPressed(
                  context: context,
                  caseID: widget.caseID.toString(),
                  caseNum: widget.CaseNum.toString(),
                  // Navigator.pop(context);

                ),
              );
            },
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.teal[600]!),
            ),
            child: const Text("Print"),
          ),
        ],
      ),
      actions:[

        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:6,),
              subheadingTextBOLD(title: "Cancel Reason"),
              SizedBox(height:5,),
              Container(
                width: 100.w,
                height: 6.4.h,
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded:true,
                      hint: cancelSelectReason== null
                          ? Text('Select Reason for Cancellation',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: "railLight"),)
                          : Text(
                        "${cancelSelectReason?.lookup_data_value ?? ''}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black, fontSize: 10.sp),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 16.sp,
                      ),
                      style: TextStyle(fontSize: 10.sp),
                      items: canceReasonList.map(
                            (val) {
                          return DropdownMenuItem(
                              value: val,
                              enabled: true,
                              alignment: Alignment.centerLeft,
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[

                                  Padding(
                                      padding:EdgeInsets.symmetric(vertical:4),
                                      child:Text(val?.lookup_data_value ?? "",
                                          style: TextStyle(
                                              fontSize: 10.sp, color: Colors.black))),


                                ],
                              ));
                        },
                      ).toList(),
                      onChanged: ( x) {
                        setState(() {
                          cancelSelectReason= x as CASE_ISSUE_CANCEL_REASONBean?;
                        });
                      },
                    )),
              ),
              SizedBox(height:20,),
              subheadingTextBOLD(title: "Are you sure you wish to cancel this notice?"),
              SizedBox(height:10,),
              Row(
                children: [

                  Expanded(child:SecondryButton(
                    onAction:(){

                      Navigator.pop(context);
                    },
                    title:"No",
                  )),
                  SizedBox(width:20,),
                  Expanded(child:PrimaryButton(
                    title:"Yes",
                    onAction:(){
                      if(cancelSelectReason!= null)
                      {

                        BlocProvider.of<IssuingSubmitFormBloc>(context).add(
                            issuingButtonEventPressed(context: context, reasonID:cancelSelectReason!.lookup_data_id.toString() ,reasonTxt:cancelSelectReason!.lookup_data_value.toString(),
                                caseID:widget.caseID));

                        Navigator.pop(context);
                        BlocProvider.of<
                            IssuingHistoryBloc>(
                            context)
                            .add(
                            IssuingHistoryInitRefresh());
                      }
                      else{
                        locator<ToastService>().showValidationMessage(context,'Select a reason to proceed');



                      }
                    }
                    ,
                  ))
                ],
              ),
              SizedBox(height:10,),
            ])],

    );
  }
}