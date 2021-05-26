import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_bloc.dart';
import 'package:geopic_polimi/pages/browse/view/browse_map.dart';
import 'package:geopic_polimi/pages/browse/view/browse_map_searchbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BrowseSlideUp extends StatelessWidget {
  LatLng initialcameraposition;
  Set<Marker> markers;
  bool isLoading;

  BrowseSlideUp(this.initialcameraposition, this.markers, this.isLoading );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlidingUpPanel(
          margin: EdgeInsets.only(bottom: 150.h, right: 20.w, left: 20.w),
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.circular(20)),
          minHeight: 370.h,
          header: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: ScreenUtil().screenWidth * 0.8,
                    height: 150.h,
                    child: BrowseSearchBar()),
                Container(
                    child: IconButton(
                        icon: Icon(Icons.my_location),
                        onPressed: () => {
                          if (isLoading == false)
                            BlocProvider.of<BrowseBloc>(context).add(new BrowseEvent(status: BrowseStatus.ViewMyLocation,)),
                        } //viewMyLocation(),
                    )),
              ],
            ),
          ),
          panel: Center(
            child: Text('Usa la barra di ricerca per spostarti di località in località'),
          ),
          body: _buildMap()),
    );
  }

  ///Define the map ui builder for the loaded map or the loading map
  Widget _buildMap() {
    return Stack(children: [
      BrowseMap(initialcameraposition, markers, isLoading),
      isLoading
          ? SafeArea(
        child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: CircularProgressIndicator())),
      )
          : Container()
    ]);
  }
}
