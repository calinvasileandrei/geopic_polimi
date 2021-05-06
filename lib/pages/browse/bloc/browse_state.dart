import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BrowseState extends Equatable {
  BrowseState();

  @override
  List<Object> get props => [];
}

class BrowseInitState extends BrowseState {
  BrowseInitState();
}

class BrowseLoading extends BrowseState {
  BrowseLoading();
}

class BrowseLoaded extends BrowseState {
  final String location;
  final MarkerId selectedMarker;
  final Set<Marker> markers;
  final List<GeoPicMarker> geopicMarkers;

  BrowseLoaded({
    this.geopicMarkers,
    this.location,
    this.selectedMarker,
    this.markers,
  });
}

class BrowseError extends BrowseState {
  final error;
  BrowseError({this.error});
}
