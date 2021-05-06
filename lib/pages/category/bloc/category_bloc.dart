import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';

import 'category_state.dart';

enum CategoryStatus { Fetch, Init,FetchFromInput}

class CategoryEvent{
  final Category category;
  final String location;
  final CategoryStatus status;
  final String structureName;

  CategoryEvent({@required this.status,@required this.category,@required this.location,this.structureName});
}


class CategoryBloc extends Bloc<CategoryEvent,CategoryState > {
  final MainRepository mainRepository;
  Section section;
  final LocationAppCubit locationAppCubit;

  CategoryBloc({this.mainRepository,this.locationAppCubit}) : super(CategoryInitState());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    switch (event.status) {
      case CategoryStatus.Init:
        yield CategoryLoading();
        var structures = await mainRepository.findAllByCategory(event.category.name,event.location,locationAppCubit.positionLocation.position);
        section = new Section(name: event.category.name,structures: structures);
        yield CategoryLoaded(section: section);
        break;
      case CategoryStatus.Fetch:
        yield CategoryLoading();
        var structures = await mainRepository.findAllByCategory(event.category.name,event.location,locationAppCubit.positionLocation.position);
        section = new Section(name: event.category.name,structures: structures);
        yield CategoryLoaded(section: section);
        break;
      case CategoryStatus.FetchFromInput:
        yield CategoryLoading();
        var sections = await mainRepository.findAdvancedStructuresByInputName(event.structureName, {"category":event.category.name,"location":event.location},locationAppCubit.positionLocation.position);
        if(sections != null && sections.isNotEmpty){
          section = sections[0];
          yield CategoryLoaded(section: section);
        }else{
          yield CategoryError();
        }
        break;
    }
  }
}
