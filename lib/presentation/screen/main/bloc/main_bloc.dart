import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:cgv/domain/bloc/bloc_bloc.dart';
import 'package:cgv/domain/bloc/bloc_event.dart';
import 'package:cgv/presentation/screen/main/bloc/main_event.dart';
import 'package:cgv/presentation/screen/main/bloc/main_state.dart';

class MainBloc extends BlocBloc<BlocEvent<MainEvent>, MainState> {
  MainBloc(super.context, super.initialState);

  @override
  FutureOr<void> onBlocEvent(
    BlocEvent<MainEvent> event,
    Emitter<MainState> emit,
  ) {
    switch(event.type) {

      case MainEvent.badge:
        print('MainEvent.badge');
        break;
      case MainEvent.popcon:
        print('MainEvent.popcon');
        break;
      case MainEvent.menu:
        print('MainEvent.menu');
        break;
    }
  }
}
