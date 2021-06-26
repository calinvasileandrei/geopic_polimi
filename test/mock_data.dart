// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:geolocator/geolocator.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/core/models/person.dart';
import 'package:geopic_polimi/core/models/position_location.dart';
import 'package:geopic_polimi/core/models/secretery.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'package:geopic_polimi/core/models/structure_section.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockData{
  static String description = 'testDescription';
  static String location = 'Roma';
  static Position positionRomeMock = new Position(latitude: 41.9027835,longitude: 12.4963655);
  static PositionLocation positionLocation = new PositionLocation(location: location,position: positionRomeMock);
  static Map positionMap = {'latitude':positionRomeMock.latitude,'longitude':positionRomeMock.longitude};
  static Secretary secretary = new Secretary(id: 0, address: 'address', email: 'email', name: 'name', phone: 'phone');
  static Person referralPerson = new Person(id: 0, name: 'name', surname: 'surname', email: 'email', phone: 'phone', secretary: secretary);
  static Category category = new Category(id: 0, name: 'name', color: 'color');
  static Category categoryForSection = new Category(id: 0, name: 'sectionTest', color: 'color');
  static List<Category> categories = [category];
  static Structure structure = new Structure(
      id: 0,
      address: 'address',
      description: description,
      discount: 1,
      email: 'email',
      expireDateConvention: '1/1/2020',
      latitude: positionRomeMock.latitude,
      longitude: positionRomeMock.longitude,
      logo: '',
      macroCategory: 'macroCategory',
      name: 'name',
      phone: 'phone',
      website: 'website',
      category: category,
      referralPerson: referralPerson,
      secretary: secretary,
      distanceFromYou: 10,
      userLatitude: positionRomeMock.latitude,
       userLongitude: positionRomeMock.longitude);
  static List<Structure> structures = [structure];
  static StructureSection structureSectionInit = new StructureSection(name: 'sectionTestInit',sectionDataList: structures);
  static StructureSection structureSection = new StructureSection(name: 'sectionTest',sectionDataList: structures);
  static List<StructureSection> structureSections = [structureSection];
  static List positionSuggestion = [{"comune":"Roma"}];
  static GeoPicMarker geoPicMarker = new GeoPicMarker(id: 0, name: 'name', category: category, color: 'color', latitude: positionRomeMock.latitude, longitude: positionRomeMock.longitude);
  static List<GeoPicMarker> geoPicMarkers = [geoPicMarker];
  static MarkerId markerId = new MarkerId('markerIdTest');
  static Marker marker = new Marker(markerId: markerId);
  static Set<Marker> markers = new Set.from([marker]);
}
