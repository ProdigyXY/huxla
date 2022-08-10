import 'package:flutter/material.dart';
import 'package:huxla/utils/animations/SlideFromRightToLeft.dart';
import 'package:huxla/screens/homepage.dart';
import 'package:huxla/screens/registrationpage.dart';
import 'package:huxla/utils/app_colors.dart';
import 'package:huxla/widgets/AppNetworkSensitive.dart';
import 'package:huxla/widgets/AppWave.dart';
import 'package:huxla/widgets/AppUnderlinedTextField.dart';
import 'package:huxla/widgets/AppRaisedButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  TextEditingController _phoneController = TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();

  TextEditingController _passwordController = TextEditingController();
  FocusNode _passwordFocusNode = FocusNode();

  bool passwordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _phoneController.text = '+234 814 034 4545';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: AppNetworkSensitive(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                AppWave(
                    isPushed: false,
                    image: true,
                    clipper: FirstBottomWaveClipper()),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style:
                            TextStyle(fontFamily: 'Poppins-Bold', fontSize: 24),
                      ),

                      SizedBox(height: 35),

                      // Phone Number
                      AppUnderlinedTextField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        label: 'Phone Number',
                        isObscure: false,
                        prefixIcon: null,
                        suffixIcon: Icon(
                          Icons.check_circle,
                          color: AppColors.colorSecondary,
                          size: 20,
                        ),
                      ),

                      SizedBox(height: 30),

                      // Password
                      AppUnderlinedTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        label: 'Password',
                        isObscure: passwordVisible ? false : true,
                        prefixIcon: null,
                        suffixIcon: passwordVisible
                            ? GestureDetector(
                                child: Icon(Icons.visibility_off,
                                    color: _phoneFocusNode.hasFocus
                                        ? AppColors.colorSecondary
                                        : Colors.grey),
                                onTap: () {
                                  togglePasswordVisibility();
                                })
                            : GestureDetector(
                                child: Icon(Icons.visibility,
                                    color: _phoneFocusNode.hasFocus
                                        ? AppColors.colorSecondary
                                        : Colors.grey),
                                onTap: () {
                                  togglePasswordVisibility();
                                }),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(205, 15, 0, 25),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.colorPrimary),
                          ),
                        ),
                      ),

                      // LoginButton
                      AppRaisedButton(
                        title: 'Login',
                        color: AppColors.colorPrimary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            SlideFromRightToLeft(
                                nextPage: HomePage(), prevPage: this.widget),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 40,
                        ),
                      ),

                      SizedBox(height: 20),

                      Padding(
                        padding: EdgeInsets.fromLTRB(60, 10, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              'New to Huxla?',
                              style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  SlideFromRightToLeft(
                                      nextPage: RegistrationPage(),
                                      prevPage: this.widget),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Signup!',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 15,
                                      color: AppColors.colorPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
