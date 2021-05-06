import 'package:flutter/material.dart';
import 'package:geopic_polimi/core/app_shapes.dart';

/// UI Class to create a unified type of input field for the app
class InputTextField extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final bool enabledTextField;
  final String hintText;
  final IconData icon;
  final double marginVertical;
  final double marginHorizontal;
  final bool obfuscatedText;

  InputTextField({
    Key key,
    @required this.width,
     this.height,
    @required this.controller,
    @required this.enabledTextField,
    @required this.icon,
    this.hintText='',
    this.marginVertical=0,
    this.marginHorizontal=0,
    this.obfuscatedText=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: marginVertical,horizontal: marginHorizontal ),
        width: width,
        height: height,
        child: TextField(
          obscureText: obfuscatedText,
          controller: controller,
          style: Theme.of(context).textTheme.bodyText1,
          textAlignVertical: TextAlignVertical.center,
          enabled: enabledTextField,
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
              border: appInputBorder,
              focusedBorder: appInputBorder,
              hintText: hintText),
        ));
  }
}
