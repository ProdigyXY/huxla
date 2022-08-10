import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';

class AppProgressDialog extends StatelessWidget {
  final String status;

  AppProgressDialog({this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
                strokeWidth: 5.0,
              ),
              SizedBox(
                width: 25.0,
              ),
              Text(
                status,
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins-SemiBold'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
