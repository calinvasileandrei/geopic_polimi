import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/controller/browse_controller.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'browse_state.dart';

enum BrowseStatus {
  Init,
  UpdateCameraPosition,
  CompleteMapController,
  ViewMyLocation
}

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
  final BrowseController browseController;
  final MainRepository mainRepository;
  final LocationAppCubit locationAppCubit;

  GoogleMapController mapController;
  Set<Marker> markers;
  MarkerId selectedMarker;

  List<GeoPicMarker> geopicMarkers;
  String location;
  bool initMap=false;

  BrowseBloc({this.mainRepository, this.browseController,this.locationAppCubit}) : super(BrowseInitState()){
    // listenerUpdates();
  }


  listenerUpdates(){
    print("listen updates bloc browse");
    location = locationAppCubit.positionLocation.location;
    if(location!=null){
      add(new BrowseEvent(status: BrowseStatus.Init));
      add(new BrowseEvent(status: BrowseStatus.UpdateCameraPosition, location: location));
      initMap=true;
    }

    locationAppCubit.stream.listen((LocationAppState locationAppState) {
      if(locationAppState.status == LocationAppStatus.Loaded){
        location = locationAppState.positionLocation.location;
        if(initMap){
          add(new BrowseEvent(status: BrowseStatus.UpdateCameraPosition, location: location));
        }else{
          add(new BrowseEvent(status: BrowseStatus.Init));
          add(new BrowseEvent(status: BrowseStatus.UpdateCameraPosition, location: location));
        }
      }
    });

  }

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
          print('location: '+location);

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
