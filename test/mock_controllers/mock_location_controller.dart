import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/controller/implementations/impl_location_controller.dart';

///Location Controller class which manages the location request and the permissions
class MockLocationController implements ImplLocationController {

  ///Check or Ask the location permission to the user and then retrieves the position
  Future<Position> getPermissionAndPosition() {
    return Future.delayed(Duration(seconds: 2), () => new Position(latitude: 41.902782,longitude: 12.496366));
  }

  ///Returns the current location
  Future<Position> getCurrentLocation()
  {
    return Future.delayed(Duration(seconds: 2), () => new Position(latitude: 41.902782,longitude: 12.496366));
  }

}
