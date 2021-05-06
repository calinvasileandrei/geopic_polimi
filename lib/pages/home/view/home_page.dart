// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/circular_rounded_container.dart';
import 'package:geopic_polimi/app_widgets/list_section_builder.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeBloc.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeState.dart';
import 'package:geopic_polimi/routing/router_constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Text Controller for the searchbar input field
  TextEditingController _searchbarTextController;

  ///Defines the method to navigate to the categoryPage
  void navigateToCategoryPage(Category category, location) {
    Navigator.pushNamed(context, categoryPageRoute,
        arguments: {"category": category, "location": location});
  }


  ///Defines the UI base on the State of the Bloc
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (_, HomeState state) {
      if (state is HomeLoaded) {
        String _location = state.location;
        List<Category> _categories = state.categories;
        List<Section> _sections = state.sections;
        return _buildHomeLoaded(_location, _categories, _sections);
      } else if (state is HomeError) {
        return Center(
          child: Text('Ops qualcosa è andato storto...',
              style: Theme.of(context).textTheme.headline5),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  ///Define the UI when the state is Loaded
  Widget _buildHomeLoaded(
      String _location, List<Category> _categories, List<Section> _sections) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
            child: CircularRoundedContainer(
              child: TextField(
                onSubmitted: (textString) => textString.length < 2
                    ? BlocProvider.of<HomeBloc>(context)
                        .add(new HomeEvent(status: HomeStatus.Fetch))
                    : BlocProvider.of<HomeBloc>(context).add(new HomeEvent(
                        status: HomeStatus.FetchFromInput,
                        structureName: textString)),
                controller: _searchbarTextController,
                style: Theme.of(context).textTheme.bodyText1,
                textAlignVertical: TextAlignVertical.center,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    hintText: 'Scrivi un luogo...'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 40.w, right: 40.w, bottom: 20.h, top: 10.h),
            height: 150.h,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToCategoryPage(_categories[index], _location),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 15.h),
                      child: CircularRoundedContainer(
                        height: 100.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: _categories[index].name == 'GEOPIC'
                              ? Text(_categories[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Theme.of(context).accentColor))
                              : Text(
                                  _categories[index].name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Divider(),
          Expanded(
              child: ListSectionBuilder(
            location: _location,
            sections: _sections,
          ))
        ],
      ),
    );
  }
}
