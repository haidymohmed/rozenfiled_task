import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';


/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) log(change.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log("${transition.currentState.runtimeType.toString()} ==> ${transition.nextState.runtimeType.toString()}" , name: transition.event.runtimeType.toString());
  }
}