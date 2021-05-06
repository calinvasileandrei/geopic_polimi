import 'package:bloc/bloc.dart';
import 'package:geopic_polimi/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

/// Manage the State of the App, allowing to change the app theme from light to dark
class ThemeCubit extends Cubit<ThemeState> {
  /// Initial constructor defining the default theme as light
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
    updateAppTheme();
  }

  /// Function to update the App Theme base on the current phone Theme (Light/Dark mode)
  void updateAppTheme() {
    final Brightness currentBrightness = AppTheme.currentSystemBrightness;
    currentBrightness == Brightness.light
        ? _setTheme(ThemeMode.light)
        : _setTheme(ThemeMode.dark);
  }

  /// Emits the new App Theme State
  void _setTheme(ThemeMode themeMode) {
    AppTheme.setStatusBarAndNavigationBarColors(themeMode);
    emit(ThemeState(themeMode: themeMode));
  }
}
