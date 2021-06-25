import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeBloc.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeState.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:test/test.dart';

import '../mock_controllers/mock_location_controller.dart';
import '../mock_data.dart';
import '../mock_repositories/mock_main_repository.dart';

void main() {
  group('HomeBloc', () {
    MockMainRepository mockMainRepository;
    LocationAppCubit locationAppCubit;
    HomeBloc homeBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      mockMainRepository = new MockMainRepository();
      locationAppCubit = new LocationAppCubit(mainRepository: mockMainRepository,locationController: new MockLocationController(),initialPositionLocaiton: MockData.positionLocation);
      locationAppCubit.updateLocationFromPosition();
      homeBloc = HomeBloc(
          mainRepository: mockMainRepository,
          locationAppCubit: locationAppCubit);
    });

    blocTest<HomeBloc, HomeState>(
      'Test Home Fetch',
      build: () => homeBloc,
      act: (bloc) => {
        bloc.locationComplete(),
        bloc.add(new HomeEvent(status: HomeStatus.Fetch , location: 'Roma')),
      },
      expect: () => [
        //Init Status called with constructor
        HomeLoading(),
        HomeLoaded(sections: MockData.structureSections,location: MockData.location, categories: MockData.categories),
        //Fetch Event
        HomeLoading(),
        HomeLoaded(sections: MockData.structureSections,location: MockData.location, categories: MockData.categories)
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Test Home FetchFromInput',
      build: () => homeBloc,
      act: (bloc) => {
        bloc.locationComplete(),
        bloc.add(new HomeEvent(status: HomeStatus.FetchFromInput , location: 'Roma', structureName: MockData.structure.name)),
      },
      expect: () => [
        //Init Status called with constructor
        HomeLoading(),
        HomeLoaded(sections: MockData.structureSections,location: null, categories: MockData.categories),
        //Fetch Event
        HomeLoading(),
        HomeLoaded(sections: MockData.structureSections,location: MockData.location, categories: MockData.categories)
      ],
    );
  });

}
