import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/pages/category/bloc/category_bloc.dart';
import 'package:geopic_polimi/pages/category/bloc/category_state.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeBloc.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeState.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:test/test.dart';

import '../mock_controllers/mock_location_controller.dart';
import '../mock_data.dart';
import '../mock_repositories/mock_main_repository.dart';

void main() {
  group('CategoryBloc', () {
    MockMainRepository mockMainRepository;
    LocationAppCubit locationAppCubit;
    CategoryBloc categoryBloc;

    setUp(() {
      EquatableConfig.stringify = true;
      mockMainRepository = new MockMainRepository();
      locationAppCubit = new LocationAppCubit(mainRepository: mockMainRepository,locationController: new MockLocationController(),initialPositionLocaiton: MockData.positionLocation);
      categoryBloc = CategoryBloc(
          mainRepository: mockMainRepository,
          locationAppCubit: locationAppCubit);
    });

    blocTest<CategoryBloc, CategoryState>(
      'Test Category Init',
      build: () => categoryBloc,
      act: (bloc) => {
        bloc.add(new CategoryEvent(status: CategoryStatus.Init , location: 'Roma', category: MockData.categoryForSection)),
      },
      expect: () => [
        CategoryLoading(),
        CategoryLoaded(section: MockData.structureSection),
      ],
    );


    blocTest<CategoryBloc, CategoryState>(
      'Test Category Fetch',
      build: () => categoryBloc,
      act: (bloc) => {
        bloc.add(new CategoryEvent(status: CategoryStatus.Fetch , location: 'Roma',category: MockData.categoryForSection)),
      },
      expect: () => [
        CategoryLoading(),
        CategoryLoaded(section: MockData.structureSection),
      ],
    );

    blocTest<CategoryBloc, CategoryState>(
      'Test Category Fetch From Input',
      build: () => categoryBloc,
      act: (bloc) => {
        bloc.add(new CategoryEvent(status: CategoryStatus.FetchFromInput , location: 'Roma',category: MockData.categoryForSection)),
      },
      expect: () => [
        CategoryLoading(),
        CategoryLoaded(section: MockData.structureSection),
      ],
    );

  });

}
