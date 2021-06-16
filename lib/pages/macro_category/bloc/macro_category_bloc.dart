// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/models/structure_section.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'macro_category_state.dart';

///Defines all the Status of an Event, base on this event type wil be executed a different action
enum MacroCategoryStatus { Fetch, Init, FetchFromInput }


///This class defines the input Event which contains all the parameter needed
class MacroCategoryEvent {
  final String macroCategory;
  final String location;
  final MacroCategoryStatus status;
  final String structureName;


  MacroCategoryEvent(
      {@required this.status,
        @required this.macroCategory,
        @required this.location,
        this.structureName});
}


/// This type of class witch extends a Bloc is an Evolution of the Cubit class allows us to implement a powerfull architecture based on stream/events
/// The difference with the Cubit class is that the Bloc class has a input stream and a out stream so we dont emit events but we add them to the stream
/// This allow a more precise management of the input events
/// Macro category bloc manages the detail page of a macro category.
class MacroCategoryBloc extends Bloc<MacroCategoryEvent, MacroCategoryState> {
  //Define the section variable which will be set on State Loaded
  StructureSection section;
  //Parameters
  final MainRepository mainRepository;
  //Cubit to subscribe
  final LocationAppCubit locationAppCubit;

  MacroCategoryBloc({this.mainRepository,this.locationAppCubit}) : super(MacroCategoryInitState());

  ///Map an input event to some action and finally to a state
  @override
  Stream<MacroCategoryState> mapEventToState(MacroCategoryEvent event) async* {
    switch (event.status) {

      case MacroCategoryStatus.Init:
        //Change the state to loading
        yield MacroCategoryLoading();
        //Retrieve the data
        var structures = await mainRepository.getMacroCategoryStructures(
            event.macroCategory, event.location,locationAppCubit.positionLocation.position);
        section = new StructureSection(name: event.macroCategory, sectionDataList: structures);
        //Change the state to loaded with the data retrieved
        yield MacroCategoryLoaded(section: section);
        break;

      case MacroCategoryStatus.Fetch:
        //Change the state to loading
        yield MacroCategoryLoading();
        //Retrieve the data
        var structures = await mainRepository.getMacroCategoryStructures(
            event.macroCategory, event.location,locationAppCubit.positionLocation.position);
        section =
        new StructureSection(name: event.macroCategory, sectionDataList: structures);
        //Change the state to loaded with the data retrieved
        yield MacroCategoryLoaded(section: section);
        break;

      case MacroCategoryStatus.FetchFromInput:
        //Change the state to loading
        yield MacroCategoryLoading();
        //Retrieve the data
        var sections = await mainRepository.findAdvancedStructuresByInputName(
            event.structureName,
            {"macroCategory": event.macroCategory, "location": event.location},locationAppCubit.positionLocation.position);
        section = sections[0];
        //Change the state to loaded with the data retrieved
        yield MacroCategoryLoaded(section: section);
        break;
    }
  }
}
