// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:geopic_polimi/core/models/position_location.dart';

///Defines all the possible LocationApp status
enum LocationAppStatus{Init,Loaded,Error,Loading,Default}

///Define the Location App state, defining all the data it has
class LocationAppState {
  LocationAppState({@required this.positionLocation,@required this.status});
  final LocationAppStatus status;
  final PositionLocation positionLocation;

}
