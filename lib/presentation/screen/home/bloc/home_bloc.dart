import 'dart:async';

import 'package:cgv/domain/bloc/bloc_bloc.dart';
import 'package:cgv/domain/bloc/bloc_event.dart';
import 'package:cgv/domain/model/movie_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BlocBloc<BlocEvent<HomeEvent>, HomeState> {
  final ScrollController controller = ScrollController();

  HomeBloc(super.context, super.initialState) {
    controller.addListener(() {
      final isShowTop = controller.offset > 0;
      if (isShowTop != state.isShowTop) {
        add(BlocEvent(HomeEvent.onShowTop, extra: isShowTop));
      }
    });
    _init();
  }

  void _init() async {
    // await repository.initMovieChart();
    final banners = await repository.loadBannerList();
    add(BlocEvent(HomeEvent.onLoadedBanners, extra: banners));
    add(BlocEvent(HomeEvent.onSubMovieChart, extra: 0));
    final functionList = await repository.loadFunctionMenuList();
    add(BlocEvent(HomeEvent.onFunctionMenu, extra: functionList));
    final eventList = await repository.loadEventList();
    add(BlocEvent(HomeEvent.onEventList, extra: eventList));
    final bandBannerData = await repository.loadBandBannerData();
    add(BlocEvent(HomeEvent.onLoadBandBannerData, extra: bandBannerData));
    final iceIconList = await repository.loadIceIconList();
    if (iceIconList != null) {
      add(BlocEvent(HomeEvent.onLoadIceIconList, extra: iceIconList));
    }
    final recommendMovies = await repository.loadRecommendMovies();
    if (recommendMovies != null) {
      add(BlocEvent(HomeEvent.onLoadRecommendMovies, extra: recommendMovies));
    }
    final popEventData = await repository.loadPopEventData();
    final popEventList = await repository.loadPopEventList();
    add(BlocEvent(HomeEvent.onLoadPopData, extra: popEventData));
    add(BlocEvent(HomeEvent.onLoadPopList, extra: popEventList));
  }

  @override
  Future<FutureOr<void>> onBlocEvent(
    BlocEvent<HomeEvent> event,
    Emitter<HomeState> emit,
  ) async {
    switch (event.type) {
      case HomeEvent.badge:
        print('MainEvent.badge');
        break;
      case HomeEvent.popcon:
        print('MainEvent.popcon');
        break;
      case HomeEvent.menu:
        print('MainEvent.menu');
        break;
      case HomeEvent.onClickBanner:
        final imageUrl = event.extra as String;
        print('onClick>$imageUrl');
        break;
      case HomeEvent.onPageChanged:
        emit(state.copyWith(currentPage: event.extra as int));
        break;
      case HomeEvent.onLoadedBanners:
        emit(state.copyWith(banners: event.extra));
        break;
      case HomeEvent.onRotatePage:
        break;
      case HomeEvent.onMovieChart:
        final movieList = await repository.loadMovieChart(MovieType.movieChart);
        emit(state.copyWith(isMovieChart: event.extra, movieList: movieList));
        break;
      case HomeEvent.onFullView:
        // TODO: Handle this case.
        break;
      case HomeEvent.onSubMovieChart:
        final list = await repository.loadMovieChart(getMovieType(event.extra));
        emit(state.copyWith(movieList: list, indexSubMovieChart: event.extra));
        break;
      case HomeEvent.onMovieData:
        // TODO: Handle this case.
        break;
      case HomeEvent.onReservation:
        // TODO: Handle this case.
        break;
      case HomeEvent.onFunctionMenu:
        emit(state.copyWith(functionMenuList: event.extra));
        break;
      case HomeEvent.onEventList:
        emit(state.copyWith(eventList: event.extra));
        break;
      case HomeEvent.onLoadBandBannerData:
        emit(state.copyWith(bandBannerData: event.extra));
        break;
      case HomeEvent.onLoadIceIconList:
        emit(state.copyWith(iceIconList: event.extra));
        break;
      case HomeEvent.onLoadRecommendMovies:
        emit(state.copyWith(recommendMoviesList: event.extra));
        break;
      case HomeEvent.onShowTop:
        emit(state.copyWith(isShowTop: event.extra));
        break;
      case HomeEvent.onTapTop:
        controller.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
        break;
      case HomeEvent.onLoadPopData:
        emit(state.copyWith(popEventData: event.extra));
        break;
      case HomeEvent.onLoadPopList:
        emit(state.copyWith(popEventList: event.extra));
        break;
      case HomeEvent.onTapToday:
        emit(state.copyWith(isNotToday: event.extra));
        break;
      case HomeEvent.onTapClose:
        emit(state.copyWith(isPopShow: false));
        break;
    }
  }

  MovieType getMovieType(int index) {
    return MovieType.values[index < MovieType.values.length ? index : 0];
  }
}
