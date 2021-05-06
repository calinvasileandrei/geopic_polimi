import 'package:flutter/material.dart';
import 'package:geopic_polimi/pages/card/card.dart';
import 'package:geopic_polimi/pages/category/category.dart';
import 'package:geopic_polimi/pages/home/home.dart';
import 'package:geopic_polimi/pages/macro_category/macro_category.dart';
import 'package:geopic_polimi/routing/router_constants.dart';
import 'package:geopic_polimi/pages/settings/settings.dart';
import 'package:geopic_polimi/tad_widgets/view/tab_bar/tab_bar_controller.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case tabControllerPageRoute:
      return MaterialPageRoute(builder: (context) => TabBarController());
    case homePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case settingsPageRoute:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case cardPageRoute:
      var parameters = settings.arguments as Map<String,dynamic>;
      var structureId = parameters["structureId"];
      var structure = parameters["structure"];
      var heroTag = parameters["heroTag"];
      return MaterialPageRoute(builder: (context) => CardPage(structureId: structureId,structure: structure,heroTag: heroTag,));
    case categoryPageRoute:
      var parameters = settings.arguments as Map<String,dynamic>;
      var category = parameters["category"];
      var location = parameters["location"];
      return MaterialPageRoute(builder: (context) => CategoryPage(category: category,location: location,));
    case macroCategoryPageRoute:
      var parameters = settings.arguments as Map<String,dynamic>;
      var macroCategory = parameters["macroCategory"];
      var location = parameters["location"];
      return MaterialPageRoute(builder: (context) => MacroCategoryPage(macrocategory: macroCategory,location: location,));

    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
