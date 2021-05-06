import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// This class defines all the UI attributes of the app
class AppTheme {
      static Color lightBackgroundColor = const Color(0xfff2f2f2);
      static Color lightPrimaryColor = const Color(0xfff2f2f2);
      static Color lightAccentColor = Color(0xffFA7B58);
      static Color lightParticlesColor = const Color(0x44948282);
      static const Color lightHeadlineColor = Colors.black54;
      static const Color lightParagraphColor = Colors.black;

      static Color darkBackgroundColor = const Color(0xFF1A2127);
      static Color darkPrimaryColor = Colors.white;
      static Color darkAccentColor = Color(0xffFA7B58);
      static Color darkParticlesColor = const Color(0x441C2A3D);
      static const Color darkHeadlineColor = Colors.white;
      static const Color darkParagraphColor = Colors.white;

      static TextTheme darkTextTheme = TextTheme(
            headline1: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w900,
                fontSize: 56.sp,
                fontStyle: FontStyle.normal),
            headline2: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w900,
                fontSize: 52.sp,
                fontStyle: FontStyle.italic),
            headline3: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 48.sp,
                fontStyle: FontStyle.normal),
            headline4: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 48.sp,
                fontStyle: FontStyle.italic),
            headline5: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 46.sp,
                fontStyle: FontStyle.normal),
            headline6: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 44.sp,
                fontStyle: FontStyle.italic),
            subtitle1: TextStyle(
                color: darkParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 44.sp,
                fontStyle: FontStyle.normal),
            subtitle2: TextStyle(
                color: darkParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 40.sp,
                fontStyle: FontStyle.normal),
            bodyText1: TextStyle(
                color: darkParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 36.sp,
                fontStyle: FontStyle.normal),
            bodyText2: TextStyle(
                color: darkParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                fontSize: 32.sp,
                fontStyle: FontStyle.normal),
            button: TextStyle(
                color: darkHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 40.sp,
                fontStyle: FontStyle.normal),
            caption: TextStyle(
                color: darkParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                fontSize: 28.sp,
                fontStyle: FontStyle.normal),
            overline: TextStyle(
                color: darkParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w100,
                fontSize: 28.sp,
                fontStyle: FontStyle.italic),
      );
      static TextTheme lightTextTheme = TextTheme(
            headline1: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w900,
                fontSize: 56.sp,
                fontStyle: FontStyle.normal),
            headline2: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w900,
                fontSize: 52.sp,
                fontStyle: FontStyle.italic),
            headline3: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 48.sp,
                fontStyle: FontStyle.normal),
            headline4: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 48.sp,
                fontStyle: FontStyle.italic),
            headline5: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 46.sp,
                fontStyle: FontStyle.normal),
            headline6: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 44,
                fontStyle: FontStyle.italic),
            subtitle1: TextStyle(
                color: lightParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 44.sp,
                fontStyle: FontStyle.normal),
            subtitle2: TextStyle(
                color: lightParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 40.sp,
                fontStyle: FontStyle.normal),
            bodyText1: TextStyle(
                color: lightParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 36.sp,
                fontStyle: FontStyle.normal),
            bodyText2: TextStyle(
                color: lightParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                fontSize: 32.sp,
                fontStyle: FontStyle.normal),
            button: TextStyle(
                color: lightHeadlineColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 40.sp,
                fontStyle: FontStyle.normal),
            caption: TextStyle(
                color: lightParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                fontSize: 28.sp,
                fontStyle: FontStyle.normal),
            overline: TextStyle(
                color: lightParagraphColor,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w100,
                fontSize: 28.sp,
                fontStyle: FontStyle.italic),
      );

      const AppTheme._();

      static final lightTheme = ThemeData(
            brightness: Brightness.light,
            primaryColor: lightPrimaryColor,
            accentColor: lightAccentColor,
            backgroundColor: lightBackgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: lightTextTheme
      );

      static final darkTheme = ThemeData(
            brightness: Brightness.dark,
            primaryColor: darkPrimaryColor,
            accentColor: darkAccentColor,
            backgroundColor: darkBackgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: darkTextTheme
      );

      static Brightness get currentSystemBrightness =>
          SchedulerBinding.instance.window.platformBrightness;

      static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness:
                  themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
                  systemNavigationBarIconBrightness:
                  themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
                  systemNavigationBarColor: themeMode == ThemeMode.light
                      ? lightBackgroundColor
                      : darkBackgroundColor,
                  systemNavigationBarDividerColor: Colors.transparent,
            ));
      }
}

extension ThemeExtras on ThemeData {
      Color get particlesColor => this.brightness == Brightness.light
          ? AppTheme.lightParticlesColor
          : AppTheme.darkParticlesColor;
}
