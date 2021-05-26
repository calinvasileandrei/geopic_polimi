// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

///This is the main repository witch manages all the main backend interaction like retrieving the structures,categories ecc...
class MainRepository {
  //Defining the request headers
  Map<String, String> headers = {'Content-Type': 'application/json'};

  MainRepository();

  ///Returns a list of section if error returns empty list
  Future<List<Section>> getSections(currentLocation,Position userPosition) async {
    List<Section> sections = [];
    var sectionsResponse;
    var body = {"location": currentLocation};
    try {
       sectionsResponse = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "structure/findAllStructuresByLocation"),
          headers: headers,
          body: json.encode(body));

      if (sectionsResponse.statusCode == 200) {
        var parsedSections =json.decode(utf8.decode(sectionsResponse.body.codeUnits)) as List;
        List<Section> sections = parsedSections.map((section) => Section.fromMap(section,userPosition.latitude,userPosition.longitude)).toList();
        return sections;
      }
    } catch (err) {
      if(err is FormatException){
        try{
          var parsedSections = json.decode(sectionsResponse.body) as List;
          return parsedSections.map((section) => Section.fromMap(section,userPosition.latitude,userPosition.longitude)).toList();
        }catch(err2){
          return sections;
        }
      }
      return sections;
    }
    return sections;
  }

  ///Given a position latitute and longiture return the name of the place with that coordinates
  Future<String> getPositionName(Position position) async {
    var body = {
      "latitude": position.latitude.toDouble(),
      "longitude": position.longitude.toDouble()
    };

    try {
      var response = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "place/cityname"),
          headers: headers,
          body: json.encode(body));

      if (response.statusCode == 200) {
        return json.decode(response.body)["name"];
      }
    } catch (err) {
      return "";
    }

    return "";
  }

  ///Given a cityname returns the position (latitude and longitude)
  Future getPosition(String name) async {
    try {
      var _positions =
      await http.get(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "place/" + name)
      );
      if (_positions.statusCode == 200) {
        var position = json.decode(_positions.body) as List;
        if (position.isNotEmpty) {
          return position[0];
        }
      }
    } catch (err) {
      return null;
    }
    return null;
  }

  ///Given a partial city name returns the full name suggestion
  Future getPositionSuggestions(String name) async {
    try {
      var _positions =
      await http.get(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "place/" + name)
      );
      if (_positions.statusCode == 200) {
        var position = json.decode(_positions.body) as List;
        return position;
      }
    } catch (err) {
      return null;
    }
    return null;
  }


  ///Returns all the db structures
  Future<List<Structure>> getStructures(Position userPosition) async {
    List<Structure> structures = [];
    try {
      final structuresRequest =
      await http.get(Uri.parse(DotEnv.env["BACKEND_URL"] + 'structure/findAll'));
      if (structuresRequest.statusCode == 200) {
        var parsedSection1 = json.decode(structuresRequest.body) as List;
        structures = parsedSection1.map((i) => Structure.fromMap(i,userPosition.latitude,userPosition.longitude)).toList();
        return structures;
      }
    } catch (err) {
      return structures;
    }

    return structures;
  }

  ///Given a macroCategory and a location returns all the structures
  Future<List<Structure>> getMacroCategoryStructures(
      String macroCategory, String location,Position userPosition) async {
    List<Structure> structures = [];
    var body = {"macroCategory": macroCategory, "location": location};

    try {
      final structuresRequest = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + 'structure/findSection'),
          headers: headers,
          body: json.encode(body));
      if (structuresRequest.statusCode == 200) {
        var parsedSection = json.decode(structuresRequest.body) as List;
        structures = parsedSection.map((i) => Structure.fromMap(i,userPosition.latitude,userPosition.longitude)).toList();
        return structures;
      }
    } catch (err) {
      return structures;
    }

    return structures;
  }

  ///Given an id of a structure returns it
  Future<Structure> getStructureByID(int id,Position userPosition) async {
    var body = {"id": id};

    try {
      final structureRequest = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + 'structure/findById'),
          headers: headers,
          body: json.encode(body));
      if (structureRequest.statusCode == 200) {
        var parsedStructure = json.decode(structureRequest.body);
        return Structure.fromMap(parsedStructure,userPosition.latitude,userPosition.longitude);
      }
    } catch (err) {
      return null;
    }
    return null;
  }

  ///Rerturns the description for the settings page
  Future<String> getSettingsDescription() async {
    try {
      var response =
      await http.get(Uri.parse(DotEnv.env["BACKEND_URL"] + "settingsdesctiption/"));
      if (response.statusCode == 200) {
        return json.decode(response.body)["description"];
      }
    } catch (err) {
      return null;
    }
    return null;
  }

  ///Returns a list of all the categories
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    try {
      var response =
      await http.get(Uri.parse(DotEnv.env["BACKEND_URL"] + "category/findAll"));
      if (response.statusCode == 200) {
        var categoriesResponse = json.decode(response.body) as List;
        categories = categoriesResponse
            .map((category) => Category.fromMap(category))
            .toList();
        return categories;
      }
    } catch (err) {
      return categories;
    }
    return categories;
  }

  ///Returns all the markers
  Future<List<GeoPicMarker>> getAllGeoPicMarkers() async {
    List<GeoPicMarker> markers = [];
    var body = {};
    try {
      var response = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "structure/markers"),
          body: json.encode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var markersResponse = json.decode(response.body) as List;
        markers = markersResponse
            .map((structure) => GeoPicMarker.fromMap(structure))
            .toList();
        return markers;
      }
    } catch (err) {
      return markers;
    }
    return markers;
  }

  ///Returns all the markers for a specific location
  Future<List<GeoPicMarker>> getGeoPicMarkersByLocation(String location) async {
    List<GeoPicMarker> markers = [];
    var body = {"location": location};

    try {
      var response = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "structure/markers"),
          body: json.encode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var markersResponse = json.decode(response.body) as List;
        markers = markersResponse
            .map((structure) => GeoPicMarker.fromMap(structure))
            .toList();
        return markers;
      }
    } catch (err) {
      return markers;
    }

    return markers;
  }

  //Search Endpoints

  ///Given a structure name and the user position return all the Section List with the different structures
  Future<List<Section>> findStructuresByInputName(
      String structureName, body,Position userPosition) async {
    List<Section> sections = [];
    try {
      final structures = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "structure/search/" + structureName),
          headers: headers,
          body: json.encode(body));
      if (structures.statusCode == 200) {
        var parsedSection = json.decode(structures.body) as List;
        List<Structure> structuresList = parsedSection
            .map((structure) => Structure.fromMap(structure,userPosition.latitude,userPosition.longitude))
            .toList();
        sections.add(new Section(name: "Ricerca", structures: structuresList));
        return sections;
      }
    } catch (err) {
      return sections;
    }
    return sections;
  }

  ///Given a category name and a city name(location) returns a list of the structures which matches the query
  Future<List<Structure>> findAllByCategory(
      String categoryName, String location,Position userPosition) async {
    List<Structure> structures = [];
    var body = {"category": categoryName, "location": location};
    try {
      var response = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "structure/findAllByCategory"),
          body: json.encode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var structuresResponse = json.decode(response.body) as List;
        structures = structuresResponse
            .map((structure) => Structure.fromMap(structure,userPosition.latitude,userPosition.longitude))
            .toList();
        return structures;
      }
    } catch (err) {
      return structures;
    }
    return structures;
  }

  ///Given a macroCategory/category and a location returns a the structure of that macroCategory/category in that location
  Future<List<Section>> findAdvancedStructuresByInputName(
      String structureName, body ,Position userPosition) async {
    List<Section> sections = [];
    try {
      final structures = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "structure/findSection/" + structureName),
          headers: headers,
          body: json.encode(body));
      if (structures.statusCode == 200) {
        var parsedSection = json.decode(structures.body) as List;
        List<Structure> structuresList = parsedSection
            .map((structure) => Structure.fromMap(structure,userPosition.latitude,userPosition.longitude))
            .toList();
        sections.add(new Section(name: "Ricerca", structures: structuresList));
        return sections;
      }
    } catch (err) {
      return sections;
    }
    return sections;
  }
}
