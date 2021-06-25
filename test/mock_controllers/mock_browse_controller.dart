import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/controller/implementations/impl_browse_controller.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/repositories/implementations/impl_main_repository.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../mock_data.dart';

/// BrowseController Implementation class to manage the device position permission and retriving the actual position
class MockBrowseController implements ImplBrowseController {

  /// this method check the actual permission status and if is not granted it will ask for it
  Future<Position> garantLocationPermissions(){
    return Future.delayed(Duration(seconds: 2), () => MockData.positionRomeMock);
  }

  /// Retrive the user position and animate the Google Map managed by the controller passed as a parameter
  Future<String> viewMyLocation(GoogleMapController controller, ImplMainRepository repo){
    return Future.delayed(Duration(seconds: 2), () => MockData.location);
  }

  /// Manage the actual Google Map camera position and animate it to a new position passed as a parameter
  void animateCameraPosition(LatLng newpos, GoogleMapController controller,bool ovunque){
  }

  /// Manage the event of changing city, also animate the camera to the new city location
  Future<bool> onChangedCity(String namePosition, GoogleMapController controller, MainRepository repo){
    return Future.delayed(Duration(seconds: 2), () => true);
  }

  /// Create a list of unique markers (SET) given a list of geopicMarkers which contains only the information about the location
  Set<Marker> createMarkers(List<GeoPicMarker> geopicMarkers){
    return MockData.markers;
  }
}
