import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialgooglesignin/screens/loginscreen.dart';
import 'package:socialgooglesignin/utils/circularimage.dart';
import 'package:socialgooglesignin/utils/commonbutton.dart';
import 'package:socialgooglesignin/utils/extensions.dart';

class Homescreen extends StatelessWidget {
  final String? userProfileUrl;
  final String? username;
  final String? userEmail;
  final String? signInType;
  const Homescreen(
      {this.userProfileUrl, this.username, this.userEmail, this.signInType});

  @override
  Widget build(BuildContext context) {
    void onLogoutButtonClicked() {
      print('sign in provider type is $signInType');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('#006596'),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: HexColor.fromHex('#8CFFFFFF')),
        title: Text('Home Screen',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: CircularCachedNetwork(url: userProfileUrl!),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              username!,
              style: TextStyle(color: Colors.black, fontSize: 17.0),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              userEmail!,
              style: TextStyle(color: Colors.black, fontSize: 17.0),
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              buttonLabel: 'Sign Out',
              btnBackgroundColor: '#cc390c',
              btnTextColor: '#FFFFFF',
              buttonHeight: 40.0,
              buttonWidth: 125,
              onButtonPressed: onLogoutButtonClicked,
            ),
          ],
        ),
      ),
    );
  }
}
