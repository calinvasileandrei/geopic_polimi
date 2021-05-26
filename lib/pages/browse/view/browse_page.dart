import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geopic_polimi/core/models/geopic_marker.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_bloc.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'browse_map_slideup.dart';

class BrowsePage extends StatefulWidget {
  BrowsePage({Key key}) : super(key: key);
  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  MarkerId selectedMarker;
  Set<Marker> markers;
  List<GeoPicMarker> geopicMarkers;
  LatLng initialcameraposition = LatLng(41.902782, 12.496366);
  bool isLoading = false;

  ///Define the UI base on the BLOC status
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseBloc, BrowseState>(
        builder: (_, BrowseState state) {
          if (state is BrowseLoaded) {
            markers = state.markers;
            isLoading = false;
          } else if (state is BrowseLoading) {
            isLoading = true;
          } else if (state is BrowseInitState) {
            isLoading = false;
          } else if (state is BrowseError) {
            isLoading = false;
            return Center(
              child: Text(state.error),
            );
          }
          return BrowseSlideUp(
              initialcameraposition, markers, isLoading);
        });
  }
}
