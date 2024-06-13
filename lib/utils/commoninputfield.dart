import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialgooglesignin/utils/extensions.dart';

class CommonInputfield extends StatefulWidget {
  final String titleText;
  final TextAlign titleTextAlign;
  final bool isPassword;
  final String hintText;
  final String labelText;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String? obsecureCharacter;
  final Icon? startIcon;
  final int? fieldMaxLength;

  const CommonInputfield(
      {super.key,
      this.titleText = '',
      this.titleTextAlign = TextAlign.start,
      this.obsecureCharacter = '*',
      this.startIcon,
      this.fieldMaxLength,
      required this.isPassword,
      required this.hintText,
      required this.labelText,
      required this.keyboardType,
      required this.textController});

  @override
  State<CommonInputfield> createState() => _CommonInputfieldState();
}

class _CommonInputfieldState extends State<CommonInputfield> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.fieldMaxLength),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return getErrorMessage();
        }
        return null;
      },
      obscuringCharacter: widget.obsecureCharacter!,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        prefixIcon: widget.startIcon,
        constraints: BoxConstraints(
          maxHeight: height * 0.095,
          maxWidth: width,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle:
            TextStyle(color: HexColor.fromHex('#C1B8B8'), fontSize: 14.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: HexColor.fromHex('#7DC8EC'), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: HexColor.fromHex('#535453'), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              BorderSide(color: HexColor.fromHex('#014C70'), width: 1.0),
        ),
      ),
    );
  }

  String getErrorMessage() {
    return 'generic error';
  }
}
