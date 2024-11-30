import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class ShareService {
  whatsAppShare(String message) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/?text=${Uri.encodeFull(message)}";
      } else {
        return "whatsapp://send?text=${Uri.encodeFull(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.black);
  }
}
