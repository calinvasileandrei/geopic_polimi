// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/circular_rounded_container.dart';
import 'package:geopic_polimi/app_widgets/position_alert_dialog.dart';
import 'package:geopic_polimi/core/app_extensions.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_status.dart';

///Custom App Bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  ///Reload the Location App given a location name
  _reloadData(String newLocation, BuildContext context) {
    if (newLocation != null && newLocation != "") {
      BlocProvider.of<LocationAppCubit>(context).updateLocationName(newLocation);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularRoundedContainer(
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).accentColor,),
                  onPressed: ()=>Scaffold.of(context).openDrawer(),
                ),
                width: 120.h,
                height: 120.h,
              ),
              GestureDetector(
                //On tap open the position alert dialog
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return PositionAlertDialog();
                    }).then((newLocation) => _reloadData(newLocation, context)),
                child: CircularRoundedContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).accentColor,
                      ),
                      BlocBuilder<LocationAppCubit, LocationAppState>(
                          builder: (_, LocationAppState state) {
                            if(state.status == LocationAppStatus.Loaded){
                              String currentLocation = state.positionLocation.location;
                              return Text(
                                currentLocation != null && currentLocation.isNotEmpty
                                    ? currentLocation.capitalize()
                                    : "Posizione non trovata",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              );
                            }else if(state.status == LocationAppStatus.Error){
                              return Text("Errore posizione",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              );
                            }else{
                              return Text("...",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              );
                            }
                          }),
                    ],
                  ),
                  height: 130.h,
                  paddingHorizzontal: 70.w,
                ),
              )
            ],
          ),
        ));
  }
}
