import 'dart:async';

import 'package:cgv/domain/bloc/bloc_bloc.dart';
import 'package:cgv/presentation/screen/splash/bloc/splash_event.dart';
import 'package:cgv/presentation/screen/splash/bloc/splash_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/bloc/bloc_event.dart';
import '../../main/main_screen.dart';

class SplashBloc extends BlocBloc<BlocEvent<SplashEvent>, SplashState> {
  final ScrollController controller = ScrollController();

  SplashBloc(super.context, super.initialState) {
    init();
  }

  void init() async {
    repository.initMovieChart();
    Timer(const Duration(milliseconds: 1000), () {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
    Timer(const Duration(milliseconds: 1200), (){
        add(BlocEvent(SplashEvent.onFinish));
    });
  }

  @override
  FutureOr<void> onBlocEvent(
    BlocEvent<SplashEvent> event,
    Emitter<SplashState> emit,
  ) {
    switch (event.type) {
      case SplashEvent.onFinish:
        context.goNamed(MainScreen.routeName);
        break;
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
