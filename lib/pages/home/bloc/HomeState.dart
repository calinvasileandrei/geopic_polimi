import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/section.dart';

abstract class HomeState extends Equatable{
  @override
  List<Object> get props =>[];
}

class HomeInitState extends HomeState{}

class HomeLoading extends HomeState{}

class HomeLoaded extends HomeState{
  final List<Section> sections;
  final String location;
  final List<Category> categories;
  HomeLoaded({this.sections,this.location,this.categories});
}

class HomeError extends HomeState{
  final error;
  HomeError({this.error});
}
