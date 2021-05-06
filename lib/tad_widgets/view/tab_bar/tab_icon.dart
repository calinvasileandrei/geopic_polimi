// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';

///Defines the UI for a Tab Icon
class TabIcon extends StatelessWidget {
  const TabIcon({Key key, this.callback, @required this.icon})
      : super(key: key);

  final callback;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      width: 50,
      child: Tab(
        icon: IconButton(
          onPressed: callback,
          icon: Icon(
            icon,
            size: 30,
          ),
        ),
      ),
    );
  }
}
