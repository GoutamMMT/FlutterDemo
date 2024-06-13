import 'package:flutter/material.dart';
import 'package:socialgooglesignin/utils/extensions.dart';

typedef void OnButtonClick();

class CustomElevatedButton extends StatelessWidget {
  final String buttonLabel;
  final double buttonWidth;
  final double buttonHeight;
  final String btnBackgroundColor;
  final String btnTextColor;
  final OnButtonClick onButtonPressed;
  const CustomElevatedButton(
      {required this.buttonLabel,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.btnBackgroundColor,
      required this.btnTextColor,
      required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onButtonPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: HexColor.fromHex(btnBackgroundColor),
        fixedSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(color: HexColor.fromHex(btnTextColor), fontSize: 16.0),
      ),
    );
  }
}
