import 'package:flutter/material.dart';
import 'package:huxla/utils/app_colors.dart';
import 'package:huxla/widgets/AppDivider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'AppSearchButton.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: AppColors.colorPrimary,
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(color: AppColors.colorPrimary),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      'assets/images/user_icon.png',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'John Doe',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-Bold',
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'View Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AppDivider(),
            Container(
              height: 535,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(OMIcons.history, color: Colors.black),
                    title: Container(
                      transform: Matrix4.translationValues(10.0 - 30, 0.0, 0.0),
                      child: Text(
                        'Booking History',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                    onTap: () {},
                    onLongPress: () {},
                  ),
                  ListTile(
                    leading: Icon(OMIcons.creditCard, color: Colors.black),
                    title: Container(
                      transform: Matrix4.translationValues(10.0 - 30, 0.0, 0.0),
                      child: Text(
                        'Payments',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    onTap: () {},
                    onLongPress: () {},
                  ),
                  ListTile(
                    leading: Icon(OMIcons.cardGiftcard, color: Colors.black),
                    title: Container(
                      transform: Matrix4.translationValues(10.0 - 30, 0.0, 0.0),
                      child: Text(
                        'Coupons',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    onTap: () {},
                    onLongPress: () {},
                  ),
                  ListTile(
                    leading: Icon(OMIcons.contactSupport, color: Colors.black),
                    title: Container(
                      transform: Matrix4.translationValues(10.0 - 30, 0.0, 0.0),
                      child: Text(
                        'Support',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    onTap: () {},
                    onLongPress: () {},
                  ),
                  ListTile(
                    leading: Icon(OMIcons.info, color: Colors.black),
                    title: Container(
                      transform: Matrix4.translationValues(10.0 - 30, 0.0, 0.0),
                      child: Text(
                        'About',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    onTap: () {},
                    onLongPress: () {},
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: AppSearchButton(
                title: 'SIGN UP AS AN ARTISAN',
                size: 50,
                color: AppColors.colorPrimary,
                onPressed: () {},
                icon: null,
                paddingLeft: 33,
                paddingRight: 0,
                isDisabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
