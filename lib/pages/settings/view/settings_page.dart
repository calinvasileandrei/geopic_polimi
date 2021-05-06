// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Defines the Ui of the Settings Page
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    //Text page definition
    String defaultDescription =
        "Geopic e' un servizio per la visualizzazione di strutture convenzionate che mettono a disposizione degli sconti per i nostri clienti!";
    String clausola =
        "Quest'applicazione è puramente a scopo illustrativo, i dati presenti sono presei casualmente da internet e non sono utilizzati a scopi commerciali. I dati qui presenti non sono di geopic e non vengono distribuiti in alcun modo.";

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth * 0.8,
            height: ScreenUtil().screenHeight * 0.3,
            child: new Image.asset('./assets/images/logo.png'),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
            child: Text(
              defaultDescription,
              style: TextStyle(fontSize: 48.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
            child: Text(
              clausola,
              style: TextStyle(fontSize: 48.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
