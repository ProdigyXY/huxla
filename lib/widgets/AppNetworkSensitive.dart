import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huxla/providers/connectivity_service.dart';
import 'package:provider/provider.dart';

class AppNetworkSensitive extends StatelessWidget {
  final Widget child;

  AppNetworkSensitive({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = context.watch<ConnectivityStatus>();

    if (connectionStatus == ConnectivityStatus.Wifi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Cellular) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Offline) {
      _showToastMessage(
          "Can\'t connect to internet. Please check your network settings!");
    }

    return child;
  }

  void _showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }
}
