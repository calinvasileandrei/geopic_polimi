import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/core/models/news_section.dart';

abstract class NewsViewState extends Equatable{
  @override
  List<Object> get props =>[];
}

class NewsInitState extends NewsViewState{}

class NewsLoading extends NewsViewState{}

class NewsLoaded extends NewsViewState{
  final NewsSection section;
  NewsLoaded({this.section});
}

class NewsError extends NewsViewState{
  final error;
  NewsError({this.error});
}
