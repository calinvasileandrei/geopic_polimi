import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/models/news_section.dart';
import 'package:geopic_polimi/core/repositories/news_repository.dart';
import 'news_view_state.dart';

/// Define the possible Event Status
enum NewsViewStatus { Fetch, Init, FetchFromInput }

/// Define the Home Event
class NewsViewEvent {
  final NewsViewStatus status;
  final String newsName;
  final String newsSection;

  NewsViewEvent(
      {@required this.status, this.newsName, @required this.newsSection});
}

class NewsViewBloc extends Bloc<NewsViewEvent, NewsViewState> {
  //Define the repository used by this BLOC
  final NewsRepository newsRepository;

  String newsSection;
  NewsSection section;

  NewsViewBloc({this.newsRepository}) : super(NewsInitState());

  ///Map an input event to some action and finally to a state
  @override
  Stream<NewsViewState> mapEventToState(NewsViewEvent event) async* {
    switch (event.status) {
      case NewsViewStatus.Init:
        yield NewsLoading();
        try {
          newsSection = event.newsSection;
          section = await newsRepository.getNewsBySection(newsSection);
          yield NewsLoaded(section: section);
        } catch (err) {
          yield NewsError(error: err);
        }
        break;
      case NewsViewStatus.Fetch:
        yield NewsLoading();
        try {
          newsSection = event.newsSection;
          section = await newsRepository.getNewsBySection(newsSection);
          yield NewsLoaded(section: section);
        } catch (err) {
          yield NewsError(error: err);
        }
        break;
      case NewsViewStatus.FetchFromInput:
        yield NewsLoading();
        try {
          newsSection = event.newsSection;
          section = await newsRepository.getNewsBySectionSearch(
              newsSection, event.newsName);
          yield NewsLoaded(section: section);
        } catch (err) {
          yield NewsError(error: err);
        }
        break;
    }
  }
}
