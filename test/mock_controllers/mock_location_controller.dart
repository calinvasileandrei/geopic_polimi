// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/controller/implementations/impl_location_controller.dart';
import '../mock_data.dart';

///Location Controller class which manages the location request and the permissions
class MockLocationController implements ImplLocationController {
  ///Check or Ask the location permission to the user and then retrieves the position
  Future<Position> getPermissionAndPosition() {
    return Future.delayed(
        Duration(seconds: 2), () => MockData.positionRomeMock);
  }

  ///Returns the current location
  Future<Position> getCurrentLocation() {
    return Future.delayed(
        Duration(seconds: 2), () => MockData.positionRomeMock);
  }
}
