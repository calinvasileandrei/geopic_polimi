import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BrowseMap extends StatelessWidget {
  LatLng _initialcameraposition;
  Set<Marker> markers;
  bool isLoading;

  BrowseMap(this._initialcameraposition, this.markers,
      this.isLoading);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      initialCameraPosition:
      CameraPosition(target: _initialcameraposition, zoom: 10),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        BlocProvider.of<BrowseBloc>(context).add(new BrowseEvent( status: BrowseStatus.CompleteMapController, controller: controller));
      },
      markers:
      markers != null && isLoading == false ? markers : Set<Marker>.of([]),
    );
  }
}
