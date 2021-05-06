import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/app_constants.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_status.dart';
import 'HomeState.dart';

enum HomeStatus { Fetch, Init, FetchFromInput}

class HomeEvent{
  final String location;
  final HomeStatus status;
  final String structureName;

  HomeEvent({@required this.status,@required this.location,this.structureName});
}


class HomeBloc extends Bloc<HomeEvent,HomeState > {
  final MainRepository mainRepository;
  final LocationAppCubit locationAppCubit;

  List<Section> sections;
  List<Category> categories;
  String location;
  Completer locationLoaded =new Completer();

  HomeBloc({this.mainRepository,this.locationAppCubit}) : super(HomeInitState()){
    this.add(new HomeEvent(status: HomeStatus.Init, location: defaultAppPositionLocation.location));
    listenerUpdates();
  }

  listenerUpdates(){
    locationAppCubit.stream.listen((LocationAppState locationAppState) {
      if(locationAppState.status == LocationAppStatus.Loaded){
        location = locationAppState.positionLocation?.location;
        if(location != null){
          if(!locationLoaded.isCompleted){
            locationLoaded.complete(true);
          }
          add(new HomeEvent(status: HomeStatus.Fetch));
        }
      }
    });
  }



  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.status) {
      case HomeStatus.Init:
          yield HomeLoading();
          await locationLoaded.future;
          sections= await mainRepository.getSections(location,locationAppCubit.positionLocation.position);
          categories = await mainRepository.getCategories();
          yield HomeLoaded(sections: sections,location: location,categories: categories);
        break;

      case HomeStatus.Fetch:
        try{

          yield HomeLoading();
          await locationLoaded.future;
          sections = await mainRepository.getSections(location,locationAppCubit.positionLocation.position);
          yield HomeLoaded(
              sections: sections, location: location, categories: categories);
        }catch(err){
          yield HomeError(error: err);

        }
        break;
      case HomeStatus.FetchFromInput:
        yield HomeLoading();
        await locationLoaded.future;
        sections = await mainRepository.findStructuresByInputName(event.structureName, {"location":event.location},locationAppCubit.positionLocation.position);
        yield HomeLoaded(sections: sections,location: location,categories: categories);
        break;
    }
  }
}
