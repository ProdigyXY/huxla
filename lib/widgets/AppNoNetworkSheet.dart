import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:huxla/utils/app_colors.dart';
import 'package:huxla/widgets/AppSearchButton.dart';

class AppNoNetworkSheet extends StatefulWidget {
  final Widget parent;

  AppNoNetworkSheet({this.parent});

  @override
  _AppNoNetworkSheetState createState() => _AppNoNetworkSheetState();
}

class _AppNoNetworkSheetState extends State<AppNoNetworkSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 300),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Can\'t connect to internet',
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Please check your network',
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'settings!',
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 200),
            Container(
              padding: EdgeInsets.all(50),
              child: AppSearchButton(
                title: 'TRY AGAIN',
                size: 60,
                color: AppColors.colorPrimary,
                onPressed: () {
                  Phoenix.rebirth(context);
                },
                icon: null,
                paddingLeft: 90,
                paddingRight: 60,
                isDisabled: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
