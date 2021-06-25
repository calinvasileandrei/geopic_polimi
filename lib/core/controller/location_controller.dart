// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:permission_handler/permission_handler.dart';
import '../app_toast.dart';
import 'implementations/impl_location_controller.dart';

///Location Controller class which manages the location request and the permissions
class LocationController implements ImplLocationController {
  //Default position in case of error
  final PositionLocation defaultPosition;

  LocationController(this.defaultPosition);

  ///Check or Ask the location permission to the user and then retrieves the position
  Future<Position> getPermissionAndPosition() async{
    //Get the current permission status
    PermissionStatus permission = await Permission.location.status;

    //If the permission status is not granted request it
    if(permission!=PermissionStatus.granted)
    {
      await Permission.location.request();
    }

    //Initialize a geolocator
    var geolocator = Geolocator();

    //Check again the permission
    GeolocationStatus geolocationStatus=await geolocator.checkGeolocationPermissionStatus();

    //Manage all the possible cases
    switch(geolocationStatus)
    {
      case GeolocationStatus.disabled:
        showToastBottomAccentColor('Posizione disabilitata');
        return defaultPosition.position;
        break;
      case GeolocationStatus.restricted:
        showToastBottomAccentColor('Posizione limitata');
        return defaultPosition.position;
        break;
      case GeolocationStatus.denied:
        showToastBottomAccentColor('Posizione negata');
        return defaultPosition.position;
        break;
      case GeolocationStatus.unknown:
        showToastBottomAccentColor('Posizione sconosciuta');
        return defaultPosition.position;
        break;
      case GeolocationStatus.granted:
        showToastBottomAccentColor('Posizione autorizzata');
        return await getCurrentLocation();
        break;
    }

  }

  ///Returns the current location
  Future<Position> getCurrentLocation() async
  {
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

}
