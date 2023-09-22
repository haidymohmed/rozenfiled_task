import 'package:rozenfiled_task/core/app/injection_controller.dart' as di;
import 'package:rozenfiled_task/core/data_source/remote_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app/app_providers.dart';
import 'core/app/observer.dart';
import 'package:bloc/bloc.dart';
import 'core/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///DISABLE LANDSCAPE
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await di.init();
  ApiClientHelper.init();
  Bloc.observer = AppBlocObserver();
  runApp(MultiProvider(
    providers: AppProviders.get(),
    child: const Rozenfiled(),
  ));
}
