// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:geopic_polimi/app/app.dart';
import 'package:geopic_polimi/app/app_bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(AppInitializer()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
