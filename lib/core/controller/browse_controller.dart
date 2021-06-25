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
import '../app_extensions.dart';
import 'implementations/impl_browse_controller.dart';

/// BrowseController class to manage the device position permission and retriving the actual position
class BrowseController implements ImplBrowseController{
  // Default error Location
  final errorLocation = new LatLng(41.9027835,12.4963655);

  /// this method check the actual permission status and if is not granted it will ask for it
  Future<Position> garantLocationPermissions() async {
    GeolocationStatus geolocationStatus =
    await Geolocator().checkGeolocationPermissionStatus();
    Position position;
    if (geolocationStatus == GeolocationStatus.granted) {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    } else if (geolocationStatus == GeolocationStatus.restricted) {
      position = await Geolocator().getCurrentPosition();
    }

    return position;
  }

  /// Retrive the user position and animate the Google Map managed by the controller passed as a parameter
  Future<String> viewMyLocation(
      GoogleMapController controller, ImplMainRepository repo) async {
    Position position = await garantLocationPermissions();

    animateCameraPosition(
        LatLng(position.latitude, position.longitude), controller,false);

    String positionName = await repo.getPositionName(position);
    return positionName;
  }

  /// Manage the actual Google Map camera position and animate it to a new position passed as a parameter
  void animateCameraPosition(
      LatLng newpos, GoogleMapController controller,bool ovunque) async {
    try {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(newpos.latitude, newpos.longitude), zoom: ovunque? 5: 10),
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  /// Manage the event of changing city, also animate the camera to the new city location
  Future<bool> onChangedCity(String namePosition, GoogleMapController controller, MainRepository repo) async {
    if(namePosition!=null){
      namePosition = namePosition.trim();

      if(namePosition.toLowerCase()=='ovunque'){
        animateCameraPosition(errorLocation, controller, true);
        return true;
      }

      PositionLocation positionResponse = await repo.getPosition(namePosition);

      if (positionResponse != null) {
        double _lat = positionResponse.position.latitude;
        double _long = positionResponse.position.longitude;

        try {
          animateCameraPosition(LatLng(_lat, _long), controller,false);
          return true;
        } catch (err) {
          print("Err" + err.toString());
          return false;
        }
      }
    }

  }

  /// Factory method to generate a custom colored marker
  BitmapDescriptor _factoryMarker(String customColor) {
    BitmapDescriptor customIcon;
    Color color = HexColor.fromHex(customColor);
    customIcon =
        BitmapDescriptor.defaultMarkerWithHue(HSLColor.fromColor(color).hue);
    return customIcon;
  }

  /// Markerd build method which assemble a marker passing as a parameter all the data like the icon , the id and the info about location ecc..
  Marker _buildMarker(
      BitmapDescriptor customIcon, MarkerId markerId, GeoPicMarker geopicMarker) {
    return Marker(
      icon: customIcon,
      markerId: markerId,
      position: LatLng(
        geopicMarker.latitude,
        geopicMarker.longitude,
      ),
      infoWindow: InfoWindow(
          title: geopicMarker.name,
          snippet: geopicMarker.category.name,
          onTap: () => Navigator.pushNamed(
              navigatorKey.currentContext, cardPageRoute,
              arguments: {
                "structureId": geopicMarker.id,
                "structure": null,
                "heroTag": ""
              })),
    );
  }

  /// Create a list of unique markers (SET) given a list of geopicMarkers which contains only the information about the location
  Set<Marker> createMarkers(List<GeoPicMarker> geopicMarkers) {
    Set<Marker> markers = new Set();

    for (GeoPicMarker gerisMarker in geopicMarkers) {
      final MarkerId markerId = MarkerId(gerisMarker.name);
      BitmapDescriptor customIcon = _factoryMarker(gerisMarker.category.color);
      Marker marker = _buildMarker(customIcon, markerId, gerisMarker);
      markers.add(marker);
    }

    return markers;
  }
}
