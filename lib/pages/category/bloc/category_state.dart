import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/core/models/section.dart';

abstract class CategoryState extends Equatable{
  @override
  List<Object> get props =>[];
}

class CategoryInitState extends CategoryState{}

class CategoryLoading extends CategoryState{}

class CategoryLoaded extends CategoryState{
  final Section section;
  CategoryLoaded({this.section});

  List<Object> get props =>[section];
}

class CategoryError extends CategoryState{
  final error;
  CategoryError({this.error});
}
