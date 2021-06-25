import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'package:geopic_polimi/core/models/structure_section.dart';

abstract class ImplMainRepository {
  ///Returns a list of section if error returns empty list
  Future<List<StructureSection>> getSections(currentLocation,
      Position userPosition);

  ///Given a position latitute and longiture return the name of the place with that coordinates
  Future<String> getPositionName(Position position);

  ///Given a cityname returns the position (latitude and longitude)
  Future<PositionLocation> getPosition(String name);

  ///Given a partial city name returns the full name suggestion
  Future<List> getPositionSuggestions(String name);

  ///Returns all the db structures
  Future<List<Structure>> getStructures(Position userPosition);

  ///Given a macroCategory and a location returns all the structures
  Future<List<Structure>> getMacroCategoryStructures(String macroCategory,
      String location, Position userPosition);

  ///Given an id of a structure returns it
  Future<Structure> getStructureByID(int id, Position userPosition);

  ///Rerturns the description for the settings page
  Future<String> getSettingsDescription();

  ///Returns a list of all the categories
  Future<List<Category>> getCategories();

  ///Returns all the markers
  Future<List<GeoPicMarker>> getAllGeoPicMarkers();

  ///Returns all the markers for a specific location
  Future<List<GeoPicMarker>> getGeoPicMarkersByLocation(String location);

  //Search Endpoints

  ///Given a structure name and the user position return all the Section List with the different structures
  Future<List<Section>> findStructuresByInputName(String structureName,
      String location, Position userPosition);

  ///Given a macroCategory/category and a location returns a the structure of that macroCategory/category in that location
  Future<List<StructureSection>> findAdvancedStructuresByInputName(
      String structureName, body, Position userPosition);

  @override

  ///Given a category name and a city name(location) returns a list of the structures which matches the query
  Future<List<Structure>> findAllByCategory(String categoryName,
      String location, Position userPosition);

}
