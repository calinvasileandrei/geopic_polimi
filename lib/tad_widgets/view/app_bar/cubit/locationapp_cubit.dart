// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:bloc/bloc.dart';
import 'package:geopic_polimi/core/app_constants.dart';
import 'package:geopic_polimi/core/controller/location_controller.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_status.dart';


/// This type of class witch extends a Cubit class allows us to implement a powerfull architecture based on stream/events
/// We can see a cubit as a stream of data , the data is inserted into the stream with the emit of a new CubitState
/// In out case this Cubit manages the Location of the user and every other Cubit/Bloc can subscribe to it to get notified when the position changes
class LocationAppCubit extends Cubit<LocationAppState> {
  PositionLocation positionLocation;
  MainRepository mainRepository;
  LocationController locationController;

  LocationAppCubit({MainRepository mainRepository}) : super(LocationAppState(positionLocation:null,status: LocationAppStatus.Init)) {
    this.mainRepository = mainRepository;
    this.locationController = new LocationController(defaultAppPositionLocation);
    //Initialize the state with the default value
    emit(LocationAppState(positionLocation: defaultAppPositionLocation,status: LocationAppStatus.Default));
  }

  ///Initialize the position,location based on the position in case of error emit a error state
  void init()async{
    try {
      var position = await locationController.getPermissionAndPosition();
      var location = await mainRepository.getPositionName(position);
      positionLocation = new PositionLocation(position: position, location: location);
      emit(LocationAppState(positionLocation:positionLocation,status: LocationAppStatus.Loaded));
    } catch (err) {
      positionLocation = defaultAppPositionLocation;
      emit(LocationAppState(positionLocation:positionLocation, status: LocationAppStatus.Error ));
    }
  }

  /// Emit new Location retrived by current position
  void updateLocationFromPosition() async{
    var position = await locationController.getPermissionAndPosition();
    var _location = await mainRepository.getPositionName(position);
    positionLocation = new PositionLocation(position: position, location: _location);
    emit(LocationAppState(positionLocation:positionLocation,status: LocationAppStatus.Loaded ));
  }

  ///Emit new Location Name
  void updateLocationName(String newLocation){
    if(positionLocation != null){
      positionLocation.location = newLocation;
      emit(LocationAppState(positionLocation: positionLocation,status: LocationAppStatus.Loaded));
    }
  }
}
