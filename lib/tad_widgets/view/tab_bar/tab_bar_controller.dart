// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/app_shapes.dart';
import 'package:geopic_polimi/pages/browse/view/browse_page.dart';
import 'package:geopic_polimi/pages/home/home.dart';
import 'package:geopic_polimi/pages/settings/view/settings_page.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/view/custom_app_bar.dart';
import 'package:geopic_polimi/tad_widgets/view/drawer/app_drawer.dart';
import 'package:geopic_polimi/tad_widgets/view/tab_bar/tab_icon.dart';

/// Stateful Widget witch manage the App Tabs
class TabBarController extends StatefulWidget {
  TabBarController({Key key}) : super(key: key);

  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Widget> myTabs;

  @override
  void initState() {
    super.initState();
    //Defining the app tabs icons
    myTabs = [
      const TabIcon(icon: Icons.home),
      const TabIcon(icon: Icons.explore),
      const TabIcon(icon: Icons.more_horiz)
    ];
    //Initializing the TabController
    _tabController = TabController(vsync: this, length: myTabs.length);
    //Starting the LocationApp Cubit
    BlocProvider.of<LocationAppCubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      initialIndex: 0,
      child: Scaffold(
        //Defining the custom App Bar
        appBar: CustomAppBar(),
        //Defining the custom App Drawer
        drawer: AppDrawer(),
        //Defining the shape of the Bottom Navigation Bar
        bottomNavigationBar: Container(
          decoration: containerElevationShadow(
              bgColor: Theme.of(context).backgroundColor),
          child: SafeArea(
              child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              tabs: myTabs,
              controller: _tabController,
            ),
          )),
        ),
        body: Container(
          //Defining the Tab Bar associated view, base on the index
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [HomePage(), BrowsePage(), SettingsPage()],
          ),
        ),
        extendBody: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
