import 'package:geopic_polimi/core/models/news.dart';
import 'package:geopic_polimi/core/models/news_section.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsRepository {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  NewsRepository();

  ///Returns a news section if passed a string name section, on error returns empty section
  Future<NewsSection> getNewsBySection(String section) async {
    NewsSection newsSection;
    var body = {"section": section};
    try {
      final newsResponse = await http.post(
          Uri.parse(dotenv.env["BACKEND_URL"]  + "news/section"),
          headers: headers,
          body: json.encode(body));

      if (newsResponse.statusCode == 200) {
        var parsedNews = json.decode(utf8.decode(newsResponse.body.codeUnits)) as List;
        List<News> news = parsedNews.map((rawNews) => News.fromMap(rawNews)).toList();
        newsSection = NewsSection(name: section,sectionDataList: news);
        return newsSection;
      }

    } catch (err) {
      print('ERR '+err.toString());
      newsSection = NewsSection(name: section,sectionDataList: []);
      return newsSection;
    }
    newsSection = NewsSection(name: section,sectionDataList: []);
    return newsSection;
  }


  ///Returns all the news from section if passed a string name section and a search string like title of a news , on error returns empty section
  Future<NewsSection> getNewsBySectionSearch(String section,String searchString) async {
    NewsSection newsSection;
    var body = {"section": section};
    try {
      final newsResponse = await http.post(
          Uri.parse(dotenv.env["BACKEND_URL"]  + "news/search/"+searchString),
          headers: headers,
          body: json.encode(body));

      if (newsResponse.statusCode == 200) {
        var parsedNews = json.decode(utf8.decode(newsResponse.body.codeUnits)) as List;
        List<News> news = parsedNews.map((rawNews) => News.fromMap(rawNews)).toList();
        newsSection = NewsSection(name: section,sectionDataList: news);
        return newsSection;
      }
    } catch (err) {
      newsSection = NewsSection(name: section,sectionDataList: []);
      return newsSection;
    }
    newsSection = NewsSection(name: section,sectionDataList: []);
    return newsSection;

  }
}
