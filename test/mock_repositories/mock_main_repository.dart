import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'package:geopic_polimi/core/models/structure_section.dart';
import 'package:geopic_polimi/core/repositories/implementations/impl_main_repository.dart';

import '../mock_data.dart';

class MockMainRepository implements ImplMainRepository {
  @override
  Future<List<StructureSection>> findAdvancedStructuresByInputName(String structureName, body, Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structureSections);
  }

  @override
  Future<List<StructureSection>> findStructuresByInputName(String structureName, String location, Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structureSections);

  }

  @override
  Future<List<GeoPicMarker>> getAllGeoPicMarkers() {
    return Future.delayed(Duration(seconds: 2), () => MockData.geoPicMarkers);
  }

  @override
  Future<List<Category>> getCategories() {
    return Future.delayed(Duration(seconds: 2), () => MockData.categories);

  }

  @override
  Future<List<GeoPicMarker>> getGeoPicMarkersByLocation(String location) {
    return Future.delayed(Duration(seconds: 2), () => MockData.geoPicMarkers);

  }

  @override
  Future<List<Structure>> getMacroCategoryStructures(String macroCategory, String location, Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structures);

  }

  @override
  Future<PositionLocation> getPosition(String name) {
    return Future.delayed(Duration(seconds: 2), () => MockData.positionLocation);
  }

  @override
  Future<String> getPositionName(Position position) {
    return Future.delayed(Duration(seconds: 2), () => MockData.location);
  }

  @override
  Future<List> getPositionSuggestions(String name) {
    return Future.delayed(Duration(seconds: 2), () => MockData.positionSuggestion);
  }

  @override
  Future<List<StructureSection>> getSections(currentLocation, Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structureSections);
  }

  @override
  Future<String> getSettingsDescription() {
    return Future.delayed(Duration(seconds: 2), () => MockData.description);
  }

  @override
  Future<Structure> getStructureByID(int id, Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structure);
  }

  @override
  Future<List<Structure>> getStructures(Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structures);
  }

  @override
  Future<List<Structure>> findAllByCategory(String categoryName, String location, Position userPosition) {
    return Future.delayed(Duration(seconds: 2), () => MockData.structures);
  }

}
