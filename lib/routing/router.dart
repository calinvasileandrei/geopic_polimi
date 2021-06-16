import 'package:flutter/material.dart';
import 'package:geopic_polimi/pages/card/card.dart';
import 'package:geopic_polimi/pages/category/category.dart';
import 'package:geopic_polimi/pages/home/home.dart';
import 'package:geopic_polimi/pages/macro_category/macro_category.dart';
import 'package:geopic_polimi/pages/news/view/news_page.dart';
import 'package:geopic_polimi/pages/news_view/view/news_view_page.dart';
import 'package:geopic_polimi/routing/router_constants.dart';
import 'package:geopic_polimi/pages/settings/settings.dart';
import 'package:geopic_polimi/tad_widgets/view/tab_bar/tab_bar_controller.dart';

/// Route Generator for the app, it manages the redirection to a defined page given some settings
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case tabControllerPageRoute:
      return MaterialPageRoute(builder: (context) => TabBarController());
    case homePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case settingsPageRoute:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case cardPageRoute:
      var parameters = settings.arguments as Map<String, dynamic>;
      var structureId = parameters["structureId"];
      var structure = parameters["structure"];
      var heroTag = parameters["heroTag"];
      return MaterialPageRoute(
          builder: (context) => CardPage(
                structureId: structureId,
                structure: structure,
                heroTag: heroTag,
              ));
    case categoryPageRoute:
      var parameters = settings.arguments as Map<String, dynamic>;
      var category = parameters["category"];
      var location = parameters["location"];
      return MaterialPageRoute(
          builder: (context) => CategoryPage(
                category: category,
                location: location,
              ));
    case macroCategoryPageRoute:
      var parameters = settings.arguments as Map<String, dynamic>;
      var macroCategory = parameters["macroCategory"];
      var location = parameters["location"];
      return MaterialPageRoute(
          builder: (context) => MacroCategoryPage(
                macrocategory: macroCategory,
                location: location,
              ));
    case newsPageRoute:
      var parameters = settings.arguments as Map<String, dynamic>;
      var news = parameters["news"];
      var heroTag = parameters["heroTag"];
      return MaterialPageRoute(
          builder: (context) => NewsPage(
                news: news,
                heroTag: heroTag,
              ));
    case newsViewPageRoute:
      var parameters = settings.arguments as Map<String, dynamic>;
      var newsSection = parameters["newsSection"];
      return MaterialPageRoute(
          builder: (context) => NewsViewPage(
                newsSection: newsSection,
              ));
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
