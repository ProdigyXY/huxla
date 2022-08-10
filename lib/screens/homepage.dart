import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:huxla/providers/app_data.dart';
import 'package:huxla/utils/app_colors.dart';
import 'package:huxla/utils/globals.dart';
import 'package:huxla/widgets/AppBubbleDivider.dart';
import 'package:huxla/widgets/AppDivider.dart';
import 'package:huxla/widgets/AppDrawer.dart';
import 'package:huxla/widgets/AppNetworkSensitive.dart';
import 'package:huxla/widgets/AppProgressDialog.dart';
import 'package:huxla/widgets/AppSearchButton.dart';
import 'package:huxla/widgets/AppSearchSheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  double searchSheetHeight = Platform.isIOS || Platform.isMacOS ? 135 : 110;
  double serviceDetailsSheetHeight = 0;
  double serviceBarHeight = 75;
  bool selectedServiceVisible = false;
  bool drawerCanOpen = true;
  bool requestingService = false;
  double serviceRequestSheetHeight = 0;

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  Position currentPosition;

  Future<void> gotoCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 16.0);

    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  void showDetailSheet(context) {
    setState(() {
      serviceDetailsSheetHeight =
          Platform.isIOS || Platform.isMacOS ? 260 : 235;
      mapBottomPadding = Platform.isIOS || Platform.isMacOS ? 230 : 240;
      serviceBarHeight = 125;
      selectedServiceVisible = true;
      drawerCanOpen = false;
    });
  }

  void doServiceRequest(context) {
    setState(() {
      requestingService = true;
      drawerCanOpen = true;
    });
  }

  void doAcceptRequest(context) {
    setState(() {
      requestingService = false;
      serviceRequestSheetHeight =
          Platform.isIOS || Platform.isMacOS ? 260 : 235;
      mapBottomPadding = Platform.isIOS || Platform.isMacOS ? 230 : 240;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();

    if (appData.selectedService != ' ') {
      showDetailSheet(context);
    }

    return Scaffold(
      key: _scaffoldkey,
      drawer: AppDrawer(),
      body: AppNetworkSensitive(
        child: Container(
          child: Stack(
            children: [
              GoogleMap(
                padding: EdgeInsets.only(bottom: mapBottomPadding),
                mapType: MapType.normal,
                initialCameraPosition: initialPosition,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AppProgressDialog(status: 'Please wait..'),
                      barrierDismissible: false);

                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }

                  mapController = controller;

                  setState(() {
                    mapBottomPadding = Platform.isAndroid ? 120 : 130;
                  });

                  gotoCurrentPosition();

                  Navigator.pop(context);
                },
              ),

              // TitlePanel
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(80.0, 81.0, 0.0, 0.0),
                    child: Text(
                      'Book A Service',
                      style:
                          TextStyle(fontFamily: 'Poppins-Bold', fontSize: 18),
                    ),
                  ),
                ),
              ),

              // MenuButton
              Positioned(
                top: 74,
                left: 20,
                child: GestureDetector(
                  onTap: () async {
                    if (drawerCanOpen) {
                      _scaffoldkey.currentState.openDrawer();
                    } else {
                      await resetApp(context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.colorSecondary),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 1.0,
                              spreadRadius: 0.1,
                              offset: Offset(0.7, 0.7))
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 20,
                      child: Icon(
                        (drawerCanOpen) ? Icons.menu : Icons.arrow_back,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              // ProfileButton
              Positioned(
                top: 74,
                right: 30,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                              spreadRadius: 0.2,
                              offset: Offset(0.2, 0.2))
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Image.asset(
                        'assets/images/user_icon.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                ),
              ),

              // TopServiceBar
              Positioned(
                top: 130,
                left: 18,
                child: AnimatedSize(
                  vsync: this,
                  duration: new Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: Container(
                    height: serviceBarHeight,
                    width: MediaQuery.of(context).size.width - 35,
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white70, width: 5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 8.0,
                              spreadRadius: 3.5,
                              offset: Offset(0.7, 0.7))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: AppColors.colorSecondary,
                                      size: 10,
                                    ),
                                    SizedBox(height: 2),
                                    AppBubbleDivider(),
                                    Visibility(
                                      visible:
                                          selectedServiceVisible ? true : false,
                                      child: Column(
                                        children: [
                                          AppBubbleDivider(),
                                          SizedBox(height: 2),
                                          Icon(
                                            Icons.circle,
                                            color: AppColors.colorSecondary,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your current location',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins-Light',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Lagos Nigeria',
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 1.0,
                                width: MediaQuery.of(context).size.width - 100,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Visibility(
                                visible: selectedServiceVisible ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      'Selected service type',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Poppins-Light',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      appData.selectedService.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // LocationButton
              Positioned(
                bottom: 300,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    gotoCurrentPosition();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                              spreadRadius: 0.2,
                              offset: Offset(0.2, 0.2))
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.my_location,
                        color: AppColors.colorGreen,
                      ),
                    ),
                  ),
                ),
              ),

              // SearchSheet
              Positioned(
                bottom: 0,
                left: 15,
                child: AnimatedSize(
                  vsync: this,
                  duration: new Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: Container(
                    height: searchSheetHeight,
                    width: MediaQuery.of(context).size.width - 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 3),
                          Container(
                            height: 2.5,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFFC5CED5),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(height: 15),
                          AppSearchButton(
                            title: 'Select a Service Type',
                            size: 40,
                            color: AppColors.colorPrimary,
                            onPressed: () {
                              _scaffoldkey.currentState.showBottomSheet(
                                  (context) =>
                                      AppSearchSheet(appData: appData));
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              size: 25,
                              color: Colors.white,
                            ),
                            paddingLeft: 50.0,
                            paddingRight: 39.0,
                            isDisabled: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ServiceDetails Sheet
              Positioned(
                bottom: 0,
                left: 15,
                child: AnimatedSize(
                  vsync: this,
                  duration: new Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: Container(
                    height: serviceDetailsSheetHeight,
                    width: MediaQuery.of(context).size.width - 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 3),
                          Container(
                            height: 2.5,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFFC5CED5),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(height: 12),
                          Text('31 min',
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 12),
                          AppSearchButton(
                            title: requestingService
                                ? 'Requesting...'
                                : 'Request Service',
                            size: 40,
                            color: AppColors.colorPrimary,
                            onPressed: () async {
                              // HelperMethods.showSnackBar(
                              //     _scaffoldkey, 'Requesting service...');
                              doServiceRequest(context);
                              Future.delayed(Duration(seconds: 2000));
                              doAcceptRequest(context);
                            },
                            icon: Text(
                              '9+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 15),
                            ),
                            paddingLeft: 80.0,
                            paddingRight: 45.0,
                            isDisabled: requestingService ? true : false,
                          ),
                          SizedBox(height: 18),
                          AppDivider(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(FontAwesomeIcons.moneyBillWave,
                                      color: AppColors.colorSecondary),
                                  Text(
                                    'from 5k',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Cash',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.stars_rounded,
                                      color: AppColors.colorSecondary),
                                  Text(
                                    '3.75',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Rating',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.directions,
                                      color: AppColors.colorSecondary),
                                  Text(
                                    '4.8 km',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Distance',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ServiceRequest Sheet
              Positioned(
                bottom: 0,
                left: 15,
                child: AnimatedSize(
                  vsync: this,
                  duration: new Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: Container(
                    height: serviceRequestSheetHeight,
                    width: MediaQuery.of(context).size.width - 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 3),
                          Container(
                            height: 2.5,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFFC5CED5),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('2 mins',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 5),
                              Image.asset(
                                'assets/images/user_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(width: 5),
                              Text('0.5 mm',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Waiting for john to arrive...',
                            style: TextStyle(
                                fontFamily: 'Poppins-Light', fontSize: 12),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(FontAwesomeIcons.comment,
                                            color: AppColors.colorSecondary),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Chat',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Light',
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(FontAwesomeIcons.phone,
                                            color: AppColors.colorSecondary),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Call',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Light',
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        await resetApp(context);
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[350],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(FontAwesomeIcons.times,
                                            color: AppColors.colorSecondary),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Light',
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetApp(context) async {
    Provider.of<AppData>(context, listen: false).selectedService = ' ';

    setState(() {
      serviceDetailsSheetHeight = 0;
      searchSheetHeight = Platform.isIOS || Platform.isMacOS ? 135 : 110;
      serviceBarHeight = 75;
      mapBottomPadding = Platform.isIOS || Platform.isMacOS ? 130 : 120;
      selectedServiceVisible = false;
      drawerCanOpen = true;
      requestingService = false;
      serviceRequestSheetHeight = 0;
    });

    await gotoCurrentPosition();
  }
}
