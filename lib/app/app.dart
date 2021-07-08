// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geopic_polimi/core/app_constants.dart';
import 'package:geopic_polimi/core/app_theme/app_theme.dart';
import 'package:geopic_polimi/core/app_theme/cubit/theme_cubit.dart';
import 'package:geopic_polimi/core/controller/browse_controller.dart';
import 'package:geopic_polimi/core/controller/location_controller.dart';
import 'package:geopic_polimi/core/repositories/auth_repository.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/core/repositories/news_repository.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_bloc.dart';
import 'package:geopic_polimi/pages/category/bloc/category_bloc.dart';
import 'package:geopic_polimi/pages/home/bloc/HomeBloc.dart';
import 'package:geopic_polimi/pages/login/cubit/login_cubit.dart';
import 'package:geopic_polimi/pages/login/view/login_page.dart';
import 'package:geopic_polimi/pages/macro_category/bloc/macro_category_bloc.dart';
import 'package:geopic_polimi/pages/news_view/bloc/news_view_bloc.dart';
import 'package:geopic_polimi/pages/splash_screen/view/splash_screen_page.dart';
import 'package:geopic_polimi/routing/router.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:geopic_polimi/tad_widgets/view/tab_bar/tab_bar_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Global navigator to retrieve the context for the controllers
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

/// Initialize the App with the multi bloc provider which defines the scope of them
class AppInitializer extends StatelessWidget {
  //Defining the Repositories
  AuthRepository authRepository;
  MainRepository mainRepository;
  NewsRepository newsRepository;
  //Defining the Blocs/Cubits
  LocationAppCubit locationAppCubit;
  HomeBloc homeBloc;
  CategoryBloc categoryBloc;
  MacroCategoryBloc macroCategoryBloc;
  BrowseBloc browseBloc;
  NewsViewBloc newsViewBloc;

  AppInitializer(){
    //Repositories init
    mainRepository = MainRepository();
    authRepository = AuthRepository();
    newsRepository = NewsRepository();
    //Bloc or Cubit init
    locationAppCubit = new LocationAppCubit(mainRepository: mainRepository,locationController: new LocationController(defaultAppPositionLocation));
    homeBloc = HomeBloc(mainRepository: mainRepository  ,locationAppCubit: locationAppCubit);
    categoryBloc = CategoryBloc(mainRepository: mainRepository,locationAppCubit: locationAppCubit);
    macroCategoryBloc = MacroCategoryBloc(mainRepository: mainRepository,locationAppCubit: locationAppCubit);
    browseBloc = BrowseBloc(mainRepository: mainRepository,browseController: new BrowseController(),locationAppCubit: locationAppCubit);
    newsViewBloc = NewsViewBloc(newsRepository: newsRepository);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(authRepository),
        ),
        BlocProvider<LocationAppCubit>(
          create: (context) => locationAppCubit,
        ),
        BlocProvider<HomeBloc>(
          create: (context) => homeBloc,
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => categoryBloc,
        ),
        BlocProvider<MacroCategoryBloc>(
          create: (context) => macroCategoryBloc,
        ),
        BlocProvider<BrowseBloc>(
          create: (context) => browseBloc,
        ),
        BlocProvider<NewsViewBloc>(
          create: (context) => newsViewBloc,
        ),
      ],
      child: ScreenUtilInit(
          designSize: Size(1125, 2436),
          builder: () => const App()),
    );
  }
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool activeSplashScreen= true;

  ///Start 2 seconds await for the splashscreen
  initSplashScreen() async{
    await Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        activeSplashScreen = false;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initSplashScreen();

  }

  ///Listen for theme changes
  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  ///Dispose the listener for the theme changes
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Base on the current state of authentication display the proper page
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return MaterialApp(
          title: appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: context.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
          onGenerateRoute: router.generateRoute,
          navigatorKey: navigatorKey,
          home: _selectWidgetState(state),
        );
      },
    );
  }

  Widget _selectWidgetState(LoginState state){
    if (state.status == LoginStatus.Uninitialized || activeSplashScreen) {
      return SplashScreenPage();
      //If the user successfully authenticated
    } else if (state.status == LoginStatus.Authenticated) {
      return TabBarController();
    } else {
      //If the user has to login
      return LoginPage();
    }
  }
}
