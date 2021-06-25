// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/app/app.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:geopic_polimi/core/repositories/implementations/impl_main_repository.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/routing/router_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// BrowseController Implementation class to manage the device position permission and retriving the actual position
abstract class ImplBrowseController {

  /// this method check the actual permission status and if is not granted it will ask for it
  Future<Position> garantLocationPermissions();

  /// Retrive the user position and animate the Google Map managed by the controller passed as a parameter
  Future<String> viewMyLocation(
      GoogleMapController controller, ImplMainRepository repo);

  /// Manage the actual Google Map camera position and animate it to a new position passed as a parameter
  void animateCameraPosition(
      LatLng newpos, GoogleMapController controller,bool ovunque);

  /// Manage the event of changing city, also animate the camera to the new city location
  Future<bool> onChangedCity(String namePosition, GoogleMapController controller, MainRepository repo);

  /// Create a list of unique markers (SET) given a list of geopicMarkers which contains only the information about the location
  Set<Marker> createMarkers(List<GeoPicMarker> geopicMarkers);
}
