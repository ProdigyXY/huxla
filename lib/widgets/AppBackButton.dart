import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          splashColor: Colors.white24,
          highlightColor: Colors.white24,
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 15),
                Text(
                  'BACK',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins-SemiBold',
                      // fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
