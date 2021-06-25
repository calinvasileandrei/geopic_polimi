import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/controller/browse_controller.dart';
import 'package:geopic_polimi/core/controller/implementations/impl_browse_controller.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/repositories/implementations/impl_main_repository.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'browse_state.dart';

/// Define the possible Event Status
enum BrowseStatus {
  Init,
  UpdateCameraPosition,
  CompleteMapController,
  ViewMyLocation
}

/// Define the Browse Event
class BrowseEvent {
  final String location;
  final BrowseStatus status;
  final GoogleMapController controller;

  BrowseEvent(
      {@required this.status,
        this.location,
        this.controller,
      });
}

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  //Define the repository used by this BLOC
  final ImplMainRepository mainRepository;
  //Location Cubit
  final LocationAppCubit locationAppCubit;

  //Controllers
  final ImplBrowseController browseController;
  GoogleMapController mapController;

  //Markers data
  Set<Marker> markers;
  MarkerId selectedMarker;

  List<GeoPicMarker> geopicMarkers;
  String location;
  bool initMap=false;

  BrowseBloc({this.mainRepository, this.browseController,this.locationAppCubit}) : super(BrowseInitState());

  ///Map an input event to some action and finally to a state
  @override
  Stream<BrowseState> mapEventToState(BrowseEvent event) async* {
    switch (event.status) {

      case BrowseStatus.Init:
        yield BrowseLoading();
        try{
          location = await locationAppCubit.positionLocation.location;
          geopicMarkers = await mainRepository.getAllGeoPicMarkers();
          markers = await browseController.createMarkers(geopicMarkers);
        }catch(err){
          yield BrowseError(error: err);
        }
        yield BrowseLoaded(
            geopicMarkers: geopicMarkers,
            selectedMarker: selectedMarker,
            location: location,
            markers: markers);
        break;

      case BrowseStatus.CompleteMapController:
        yield BrowseLoading();
        try{
          mapController = event.controller;
          location = await locationAppCubit.positionLocation.location;

          if(location!=null) {
            add(new BrowseEvent(status: BrowseStatus.Init));
            add(new BrowseEvent(status: BrowseStatus.UpdateCameraPosition, location: location));
          }else{
            yield BrowseError(error:'Errore di posizione!');
          }

        }catch(err){
          yield BrowseError(error: err);
        }
        yield BrowseLoaded(
            geopicMarkers: geopicMarkers,
            selectedMarker: selectedMarker,
            location: location,
            markers: markers);
        break;

      case BrowseStatus.UpdateCameraPosition:
        yield BrowseLoading();
        if(!initMap){
          add(new BrowseEvent(status: BrowseStatus.Init));
        }

        try{
          if (mapController != null && event.location != null) {
            location = event.location;
            await browseController.onChangedCity(location, mapController, mainRepository);
            locationAppCubit.updateLocationName(location);
          }
        }catch(err){
          yield BrowseError(error: err);
        }
        yield BrowseLoaded(
            geopicMarkers: geopicMarkers,
            selectedMarker: selectedMarker,
            location: location,
            markers: markers);

        break;

      case BrowseStatus.ViewMyLocation:
        yield BrowseLoading();
        try{
          location = await browseController.viewMyLocation(mapController, mainRepository);
          locationAppCubit.updateLocationName(location);
        }catch(err){
          yield BrowseError(error: err);
        }
        yield BrowseLoaded(
            geopicMarkers: geopicMarkers,
            selectedMarker: selectedMarker,
            location: location,
            markers: markers);
        break;
    }
  }
}
