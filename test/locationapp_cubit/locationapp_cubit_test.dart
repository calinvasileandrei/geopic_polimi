// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_status.dart';
import 'package:test/test.dart';
import '../mock_controllers/mock_location_controller.dart';
import '../mock_data.dart';
import '../mock_repositories/mock_main_repository.dart';

void main() {
  group('LocationAppCubit', () {
    MockMainRepository mockMainRepository;
    LocationAppCubit locationAppCubit;
    MockLocationController locationController;

    setUp(() {
      EquatableConfig.stringify = true;
      mockMainRepository = new MockMainRepository();
      locationController = new MockLocationController();
      locationAppCubit = new LocationAppCubit(mainRepository: mockMainRepository,locationController: locationController);
    });

    blocTest<LocationAppCubit, LocationAppState>(
      'Test LocationApp Update Location Name',
      build: () => locationAppCubit,
      act: (cubit) => {
        cubit.updateLocationName(MockData.location)
      },
      expect: () => [
        LocationAppState(positionLocation: MockData.positionLocation, status: LocationAppStatus.Loaded)
      ],
    );
  });

}
