import 'package:flutter/material.dart';
import 'package:huxla/models/service_category.dart';
import 'package:huxla/providers/app_data.dart';
import 'package:huxla/widgets/AppDivider.dart';
import 'package:huxla/widgets/AppServicesListTile.dart';
import 'package:huxla/widgets/AppWave.dart';
import 'package:provider/provider.dart';

class AppSearchSheet extends StatefulWidget {
  AppSearchSheet({
    Key key,
    @required this.appData,
  }) : super(key: key);

  final AppData appData;

  @override
  _AppSearchSheetState createState() => _AppSearchSheetState();
}

class _AppSearchSheetState extends State<AppSearchSheet> {
  final List<ServiceCategory> serviceCategoryList = <ServiceCategory>[
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
    ServiceCategory(
        image: 'assets/images/user_icon.png',
        title: 'Category',
        subtitle: 'This is a service category'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppWave(
                isPushed: true,
                image: false,
                clipper: SecondBottomWaveClipper()),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: Container(
              height: 550,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
                      child: Text(
                        'Select A Service Category',
                        style: TextStyle(),
                      ),
                    ),
                    (serviceCategoryList.length > 0)
                        ? Material(
                            color: Colors.transparent,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 1.613,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: serviceCategoryList.length,
                                itemBuilder: (context, index) {
                                  return AppServicesListTile(
                                    serviceCategory: serviceCategoryList[index],
                                    isActive: index == 0 ? true : false,
                                    onPressed: () {
                                      if (widget.appData.selectedService ==
                                          ' ') {
                                        Provider.of<AppData>(context,
                                                listen: false)
                                            .selectedService = 'A/C Repairs';
                                      }

                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        AppDivider(),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
