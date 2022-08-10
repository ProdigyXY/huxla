import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';

class HelperMethods {
  static void showSnackBar(scaffoldkey, String title) {
    final snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary),
            strokeWidth: 5.0,
          ),
          SizedBox(
            width: 25.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15, fontFamily: 'Poppins-SemiBold'),
          )
        ],
      ),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
}
