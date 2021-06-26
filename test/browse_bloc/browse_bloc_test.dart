// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_bloc.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_state.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:test/test.dart';
import '../mock_controllers/mock_browse_controller.dart';
import '../mock_controllers/mock_location_controller.dart';
import '../mock_data.dart';
import '../mock_repositories/mock_main_repository.dart';

void main() {
  group('BrowseBloc', () {
    MockMainRepository mockMainRepository;
    LocationAppCubit locationAppCubit;
    MockBrowseController browseController;
    BrowseBloc browseBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      mockMainRepository = new MockMainRepository();
      locationAppCubit = new LocationAppCubit(mainRepository: mockMainRepository,locationController: new MockLocationController(),initialPositionLocaiton: MockData.positionLocation);
      browseController = new MockBrowseController();
      browseBloc = BrowseBloc(
          browseController: browseController,
          mainRepository: mockMainRepository,
          locationAppCubit: locationAppCubit);
    });

    blocTest<BrowseBloc, BrowseState>(
      'Test Browse Init',
      build: () => browseBloc,
      act: (bloc) => {
        bloc.add(new BrowseEvent(status: BrowseStatus.Init))
      },
      expect: () => [
        BrowseLoading(),
        BrowseLoaded(
            geopicMarkers: MockData.geoPicMarkers,
            selectedMarker: null,
            location: MockData.location,
            markers: MockData.markers),
      ],
    );

    blocTest<BrowseBloc, BrowseState>(
      'Test Browse CompleteMapController',
      build: () => browseBloc,
      act: (bloc) => {
        bloc.add(new BrowseEvent(status: BrowseStatus.CompleteMapController,location: MockData.location))
      },
      expect: () => [
        //CompleteMapController Loading
        BrowseLoading(),
        // Init Status
        BrowseLoaded(
            geopicMarkers: null,
            location: MockData.location,
            selectedMarker: null,
            markers: null),
        //Update Camera position
        BrowseLoading(),
        BrowseLoaded(
            geopicMarkers: MockData.geoPicMarkers,
            selectedMarker: null,
            location: MockData.location,
            markers: MockData.markers),
        //Final map Loading
        BrowseLoading(),
        BrowseLoaded(
            geopicMarkers: MockData.geoPicMarkers,
            selectedMarker: null,
            location: MockData.location,
            markers: MockData.markers),

      ],
    );

    blocTest<BrowseBloc, BrowseState>(
      'Test Browse UpdateCameraPosition',
      build: () => browseBloc,
      act: (bloc) => {
        bloc.add(new BrowseEvent(status: BrowseStatus.UpdateCameraPosition,location: MockData.location))
      },
      expect: () => [
        //Init
        BrowseLoading(),
        BrowseLoaded(
            geopicMarkers: null,
            location: null,
            selectedMarker: null,
            markers: null),
        //Update Camera Position
        BrowseLoading(),
        BrowseLoaded(
            geopicMarkers: MockData.geoPicMarkers,
            selectedMarker: null,
            location: MockData.location,
            markers: MockData.markers),

      ],
    );

    blocTest<BrowseBloc, BrowseState>(
      'Test Browse ViewMyLocation',
      build: () => browseBloc,
      act: (bloc) => {
        bloc.add(new BrowseEvent(status: BrowseStatus.ViewMyLocation,location: MockData.location))
      },
      expect: () => [
        //Init
        BrowseLoading(),
        BrowseLoaded(
            geopicMarkers: null,
            selectedMarker: null,
            location: MockData.location,
            markers: null),

      ],
    );

  });

}
