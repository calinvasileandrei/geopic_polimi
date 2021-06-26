// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/app_constants.dart';
import 'package:geopic_polimi/core/app_toast.dart';
import 'package:geopic_polimi/core/controller/implementations/impl_location_controller.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:geopic_polimi/core/repositories/implementations/impl_main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_status.dart';

import '../../../../main_production.dart';


/// This type of class witch extends a Cubit class allows us to implement a powerful architecture based on stream/events
/// We can see a cubit as a stream of data , the data is inserted into the stream with the emit of a new CubitState
/// In out case this Cubit manages the Location of the user and every other Cubit/Bloc can subscribe to it to get notified when the position changes
class LocationAppCubit extends Cubit<LocationAppState> {
  PositionLocation positionLocation;
  ImplMainRepository mainRepository;
  ImplLocationController locationController;

  LocationAppCubit({ImplMainRepository mainRepository,ImplLocationController locationController, PositionLocation initialPositionLocaiton}) : super(LocationAppState(positionLocation:defaultAppPositionLocation,status: LocationAppStatus.Init)) {
    this.mainRepository = mainRepository;
    this.locationController = locationController;
    if(initialPositionLocaiton != null){
      this.positionLocation = initialPositionLocaiton;
    }
    //Initialize the state with the default value
    emit(new LocationAppState(positionLocation: defaultAppPositionLocation,status: LocationAppStatus.Default));
  }

  ///Initialize the position,location based on the position in case of error emit a error state
  void init() async{
    emit(LocationAppState(status: LocationAppStatus.Loading));
    try {
      Position position = await locationController.getPermissionAndPosition();
      String location = await mainRepository.getPositionName(position);
      positionLocation = new PositionLocation(position: position, location: location);
      emit(new LocationAppState(positionLocation:positionLocation,status: LocationAppStatus.Loaded));
    } catch (err) {
      positionLocation = defaultAppPositionLocation;
      emit(LocationAppState(positionLocation:positionLocation, status: LocationAppStatus.Error ));
    }
  }

  /// Emit new Location retrieved by current position
  void updateLocationFromPosition() async{
    emit(LocationAppState(status: LocationAppStatus.Loading));
    Position position = await locationController.getPermissionAndPosition();
    String _location = await mainRepository.getPositionName(position);
    positionLocation = new PositionLocation(position: position, location: _location);
    emit(LocationAppState(positionLocation:positionLocation,status: LocationAppStatus.Loaded ));
  }

  ///Emit new Location Name
  void updateLocationName(String newLocation) async {
      emit(LocationAppState(status: LocationAppStatus.Loading));
      if(newLocation == 'Ovunque'){
        positionLocation = defaultAppPositionLocation;
        emit(LocationAppState(positionLocation: positionLocation,status: LocationAppStatus.Loaded));
      }else{
        PositionLocation newPosition= await mainRepository.getPosition(newLocation);
         if(newPosition !=null){
           positionLocation = newPosition;
           emit(LocationAppState(positionLocation: positionLocation,status: LocationAppStatus.Loaded));
         }else{
           showToastTop(message: 'Errore ricerca posizione',bgColor: Theme.of(navigatorKey.currentContext).backgroundColor);
         }
      }
  }
}
