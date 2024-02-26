// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    if (kDebugMode) {
      print('onCreate: This is a ${bloc.runtimeType}');
    }
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    if (kDebugMode) {
      print('onClose: ${bloc.runtimeType} closed');
    }
    super.onClose(bloc);
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    if (kDebugMode) {
      print('onError: ${bloc.runtimeType} closed');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    if (kDebugMode) {
      print('''
      onTransition: There was a transition from
      ${transition.currentState} to ${transition.nextState}
          ''');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(
    BlocBase<dynamic> bloc,
    Change<dynamic> change,
  ) {
    if (kDebugMode) {
      print('''
      onChange: ${bloc.runtimeType} changed from
      ${change.currentState} to ${change.nextState}
          ''');
    }
    super.onChange(bloc, change);
  }

  @override
  void onEvent(
    Bloc<dynamic, dynamic> bloc,
    Object? event,
  ) {
    if (kDebugMode) {
      print('onEvent: A $event event happened in ${bloc.runtimeType}');
    }
    super.onEvent(bloc, event);
  }
}
