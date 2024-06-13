import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialgooglesignin/utils/extensions.dart';
import 'package:socialgooglesignin/utils/webp_image_loader.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
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
          ],
        ),
      ),
    );
  }
}
