// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:geopic_polimi/core/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'circular_rounded_container.dart';

///Defines a Simple App Bar for the details page witch are outside the default tab view
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  //Text UI Value to be displayed
  final String text;

  SimpleAppBar({this.text});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircularRoundedContainer(
                paddingHorizzontal: 40.w,
                child: Text(
                  this.text?.capitalize(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                height: 120.h,
              ),
            ],
          ),
        ));
  }
}
