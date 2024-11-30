import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../Ui/Pages/Role_stationsTeam/homescreen_issue_screen.dart';
import '../../bloc/offline_sync.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../constants/app_utils.dart';
import 'common_internet_check.dart';

class CommonOfflineStatusBar extends StatefulWidget {
  bool? isOfflineApiRequired;

  CommonOfflineStatusBar({required this.isOfflineApiRequired});

  @override
  State<CommonOfflineStatusBar> createState() => _CommonOfflineStatusBarState();
}

class _CommonOfflineStatusBarState extends State<CommonOfflineStatusBar> {
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};
  String? string;
  bool? network;
  bool syncdata = false;

  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    getUserSetting();
    InternetCheck()
        .checkUpdatedConnection(widget.isOfflineApiRequired, context);
    _networkConnectivity.initialise();
    subscription = _networkConnectivity.myStream.listen((source) {
      if (mounted) {
        setState(() {
          _source = source;
          switch (_source.keys.toList()[0]) {
            case ConnectivityResult.mobile:
              {
                string = _source.values.toList()[0]
                    ? 'Mobile: Online'
                    : 'Mobile: Offline';
                network = true;
                break;
              }
            case ConnectivityResult.wifi:
              {
                string = _source.values.toList()[0]
                    ? 'WiFi: Online'
                    : 'WiFi: Offline';
                network = true;
                break;
              }
            case ConnectivityResult.none:
            default:
              string = 'Offline';
              network = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Future<void> getUserSetting() async {
    int createdCaseCount = await AppUtils().getCreatedCaseCount();
    if (mounted) {
      setState(() {
        syncdata = createdCaseCount != 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 1.w,
        ),
        syncdata && network == false
            ? const Icon(
                Icons.warning_amber_rounded,
                size: 30,
                color: Colors.white,
              )
            : Container(),
        SizedBox(
          width: 1.w,
        ),
        BlocBuilder<OfflineSyncBloc, OfflineSyncState>(
          builder: (context, state) {
            if (state is OfflineOnlineCheckInternetStatusState) {
              if (state.isInternetAvailable && network == true) {
                syncdata = false;
              }
              return state.isInternetAvailable
                  ? const Icon(Icons.cloud_done_outlined, size: 30)
                  : const Icon(Icons.cloud_off, size: 30);
            } else {
              return network == false
                  ? const Icon(Icons.cloud_off, size: 30)
                  : const Icon(Icons.cloud_done_outlined, size: 30);
            }
          },
        ),
        SizedBox(
          width: 3.w,
        ),
        BlocBuilder<PrinterBloc, PrinterState>(builder: (context, state) {
          if (state is PrinterStatusUpdateState &&
              state.status == "Connected") {
            Icon(
              Icons.local_print_shop_outlined,
              color: Colors.white,
              size: 18.sp,
            );
          }

          if (state is PrinterStatusUpdateState &&
              state.status == "Disconnected") {
            return Icon(
              Icons.print_disabled_sharp,
              color: Colors.white,
              size: 18.sp,
            );
          } else {
            return Icon(
              BlocProvider.of<PrinterBloc>(context).status.isNotEmpty
                  ? Icons.local_print_shop_outlined
                  : Icons.print_disabled_sharp,
            );
          }
        }),
        SizedBox(
          width: 7.w,
        ),
      ],
    );
  }
}
