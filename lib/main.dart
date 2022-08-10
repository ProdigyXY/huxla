import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:huxla/providers/app_data.dart';
import 'package:huxla/screens/loginpage.dart';
import 'package:huxla/providers/connectivity_service.dart';
import 'package:huxla/widgets/AppNetworkStatus.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppData()),
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController.stream),
      ],
      child: MaterialApp(
        title: 'Huxla',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins-Regular',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: AppNetworkStatus(child: LoginPage()),
      ),
    );
  }
}
