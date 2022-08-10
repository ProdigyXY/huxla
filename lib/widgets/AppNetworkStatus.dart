import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huxla/utils/animations/SlideFromBottomAsModal.dart';
import 'package:huxla/widgets/AppNoNetworkSheet.dart';

class AppNetworkStatus extends StatefulWidget {
  final Widget child;

  AppNetworkStatus({
    this.child,
  });

  @override
  _AppNetworkStatus createState() => _AppNetworkStatus();
}

class _AppNetworkStatus extends State<AppNetworkStatus> {
  String currentConnectionStatus = 'Unknown';

  Future<void> getCurrentNetworkStatus() async {
    ConnectivityResult result;

    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    super.initState();
    getCurrentNetworkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.none:
        setState(() {
          currentConnectionStatus = result.toString();
        });
        print(currentConnectionStatus);
        if (currentConnectionStatus == 'ConnectivityResult.none') {
          Navigator.pushReplacement(
            context,
            SlideFromBottomAsModal(
                page: AppNoNetworkSheet(parent: this.widget)),
          );
        }

        break;
      default:
        setState(() {
          currentConnectionStatus = 'failed to get connectivity';
        });
        print(currentConnectionStatus);
        break;
    }
  }
}
