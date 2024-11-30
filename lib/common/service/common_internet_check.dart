import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global_bloc.dart';
import '../../bloc/offline_sync.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';

class InternetCheck {
  StreamSubscription? listener;

  checkUpdatedConnection(bool? isOfflineApiRequired, BuildContext context) {
    listener = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.name == "none") {
        BlocProvider.of<OfflineSyncBloc>(context)
            .add(OfflineOnlineCheckInternetStatusEvent(false));
      } else {
        BlocProvider.of<OfflineSyncBloc>(context)
            .add(OfflineOnlineCheckInternetStatusEvent(true));
      }
    });
  }
}
