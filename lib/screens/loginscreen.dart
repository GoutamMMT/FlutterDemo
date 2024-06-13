// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:socialgooglesignin/screens/homescreen.dart';
import 'package:socialgooglesignin/screens/signupscreen.dart';
import 'package:socialgooglesignin/utils/commonbutton.dart';
import 'package:socialgooglesignin/utils/commoninputfield.dart';
import 'package:socialgooglesignin/utils/constants.dart';
import 'package:socialgooglesignin/utils/extensions.dart';
import 'package:socialgooglesignin/utils/signin_controller.dart';
import 'package:socialgooglesignin/utils/webp_image_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_displayEmailContentValue);
    _passwordController.addListener(_displayPasswordContentValue);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _displayEmailContentValue() {
    final emailAddress = _emailController.text;
    log('email address is , $emailAddress');
    print('email address is , $emailAddress');
  }

  void _displayPasswordContentValue() {
    final password = _passwordController.text;
    print('password is , $password');
  }

  void _onLoginButtonClicked() {
    final emailAddress = _emailController.text;
    final password = _passwordController.text;
    if (emailAddress.isNotEmpty && password.isNotEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Homescreen(
          userProfileUrl: AppConstant.DEFAULT_USER_PROFILEPIC,
          username: 'Test User',
          userEmail: emailAddress,
          signInType: 'Normal',
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(ShowSnackMessage.fromMessage(
          'Email and password are required field', 'GOT IT', () {}));
    }
  }

  void _onFacebookSignInButtonClick() async {
    print('Facebook signin button click');
    try {
      final loginResult = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);
      if (loginResult.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        if (!mounted) {
          return;
        }
        if (userData != null) {
          print('facebook login data $userData');

          ScaffoldMessenger.of(context).showSnackBar(
            ShowSnackMessage.fromMessage(
                'Facebook Login successful with ${userData['email']}', 'OK',
                () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Homescreen(
                    userProfileUrl: userData['picture']['data']['url'],
                    username: userData['name'],
                    userEmail: userData['email'],
                    signInType: 'Facebook',
                  ),
                ),
              );
            }),
          );
        }
      }
    } catch (error) {
      print('facebook signin error $error');
    }
    // FacebookAuth.instance
    //     .login(permissions: ['public_profile', 'email']).then((onValue) {
    //   FacebookAuth.instance.getUserData().then((userData) async {
    //     print('facebook login data $userData');
    //     if (userData != null) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         ShowSnackMessage.fromMessage(
    //             'Fb Login successful with ${userData['email']}', 'OK', () {
    //           Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (context) => Homescreen(
    //                 userProfileUrl: userData['url'],
    //                 username: userData['name'],
    //                 userEmail: userData['email'],
    //                 signInType: 'Facebook',
    //               ),
    //             ),
    //           );
    //         }),
    //       );
    //     }
    //   });
    // });
  }

  void _onGoogleSignInButtonClick() async {
    print('Google sign in button click');
    try {
      final user = await UserSignInController.loginWithGoogle();
      if (!mounted) {
        return;
      }
      if (user != null) {
        print('google sign in done $user');
        if (user.providerData[0] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            ShowSnackMessage.fromMessage(
                'Login successful with ${user.providerData[0].email}', 'OK',
                () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Homescreen(
                    userProfileUrl: user.providerData[0].photoURL,
                    username: user.displayName,
                    userEmail: user.providerData[0].email,
                    signInType: 'Google',
                  ),
                ),
              );
            }),
          );
        }
      }
    } on FirebaseAuthException catch (ferr) {
      print('firebase auth error ${ferr.message}');
      ScaffoldMessenger.of(context).showSnackBar(
          ShowSnackMessage.fromMessage('${ferr.message}', 'OK', () {}));
    } catch (e) {
      print('google signin error $e');
      ScaffoldMessenger.of(context).showSnackBar(
          ShowSnackMessage.fromMessage(e.toString(), 'OK', () {}));
    }
  }

  void gotoSignUpScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => UserSignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('#006596'),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: HexColor.fromHex('#8CFFFFFF')),
        title: Text('Login Screen',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: WebPImageLoader(
                    assetPath: 'assets/images/app_icon_foreground.webp'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonInputfield(
                      isPassword: false,
                      hintText: 'Enter Email Address',
                      fieldMaxLength: 32,
                      labelText: 'Email Address',
                      startIcon: Icon(
                        Icons.email,
                        size: 17.0,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textController: _emailController),
                  SizedBox(
                    height: 25,
                  ),
                  CommonInputfield(
                      isPassword: true,
                      fieldMaxLength: 8,
                      hintText: 'Enter password',
                      labelText: 'Enter password',
                      startIcon: Icon(
                        Icons.lock,
                        size: 17.0,
                      ),
                      keyboardType: TextInputType.text,
                      textController: _passwordController),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              buttonLabel: 'SignIn',
              buttonWidth: 130,
              buttonHeight: 40,
              btnBackgroundColor: '#006596',
              btnTextColor: '#FFFFFF',
              onButtonPressed: () {
                _onLoginButtonClicked();
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 200,
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '----OR----',
                    style: TextStyle(fontSize: 17.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _onGoogleSignInButtonClick();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Text(
                'Continue with Google',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomElevatedButton(
                buttonLabel: 'Continue with Facebook',
                buttonWidth: 225,
                buttonHeight: 45,
                btnBackgroundColor: '#3b5998',
                btnTextColor: '#FFFFFF',
                onButtonPressed: _onFacebookSignInButtonClick),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      gotoSignUpScreen;
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                        children: [
                          TextSpan(
                            text: 'Doesn\u0027t having account?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0),
                          ),
                          TextSpan(
                            text: ' SignUp',
                            style: TextStyle(
                                color: HexColor.fromHex('#006596'),
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
