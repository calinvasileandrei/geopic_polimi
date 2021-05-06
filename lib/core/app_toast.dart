// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

///Different Toast Popup

void showToastTop({Key key, message,bgColor}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor:  bgColor,
    textColor: Colors.red,
    fontSize: 16.0,
  );
}

void showToastBottom({Key key, message,bgColor}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor:  bgColor,
    textColor: Colors.red,
    fontSize: 16.0,
  );
}


void showToastBottomAccentColor(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Color(0xffFA7B58)  ,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
