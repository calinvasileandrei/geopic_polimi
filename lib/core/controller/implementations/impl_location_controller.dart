import 'package:geolocator/geolocator.dart';

///Location Controller Implementation class which manages the location request and the permissions
abstract class ImplLocationController {
  ///Check or Ask the location permission to the user and then retrieves the position
  Future<Position> getPermissionAndPosition();

  ///Returns the current location
  Future<Position> getCurrentLocation();

}
