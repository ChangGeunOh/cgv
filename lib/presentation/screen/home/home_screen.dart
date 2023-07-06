import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgv/common/const/color.dart';
import 'package:cgv/common/const/constants.dart';
import 'package:cgv/domain/bloc/bloc_event.dart';
import 'package:cgv/domain/bloc/bloc_layout.dart';
import 'package:cgv/presentation/screen/home/bloc/home_bloc.dart';
import 'package:cgv/presentation/screen/home/bloc/home_event.dart';
import 'package:cgv/presentation/screen/home/bloc/home_state.dart';
import 'package:flutter/material.dart';

import '../../component/banner_page_view.dart';
import '../../component/sliver_sized_box.dart';
import 'component/band_banner_layout.dart';
import 'component/bottom_layout.dart';
import 'component/event_layout.dart';
import 'component/ice_con_layout.dart';
import 'component/movie_chart_button_layout.dart';
import 'component/movie_chart_layout.dart';
import 'component/pop_event_bottom_sheet.dart';
import 'component/recommend_movie_layout.dart';
import 'component/under_line_button_layout.dart';

class HomeScreen extends StatelessWidget {
  static String get routeName => 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocLayout<HomeBloc, HomeState>(
      create: (context) => HomeBloc(context, HomeState()),
      builder: (context, bloc, state) {
        final size = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              CustomScrollView(
                controller: bloc.controller,
                slivers: [
                  SliverToBoxAdapter(
                    child: BannerPagerView(
                      banners: state.banners,
                      onTap: (bannerData) {
                        print('ImageUrl>${bannerData.toJson()}');
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: MovieChartButtonLayout(
                      isMovieChart: true,
                      onTapMovieChart: () {
                        bloc.add(
                            BlocEvent(HomeEvent.onMovieChart, extra: true));
                      },
                      onTapComingSoon: () {
                        bloc.add(
                            BlocEvent(HomeEvent.onMovieChart, extra: false));
                      },
                      onTapFullView: () {
                        bloc.add(BlocEvent(HomeEvent.onFullView));
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: UnderLineButtonLayout(
                      underLineMenuList: chartMenuList,
                      onTap: (index) => bloc.add(
                        BlocEvent(HomeEvent.onSubMovieChart, extra: index),
                      ),
                      index: state.indexSubMovieChart,
                    ),
                  ),
                  const SliverSizedBox(height: 24),
                  SliverToBoxAdapter(
                    child: MovieChartLayout(
                      onTap: (movieData) => bloc.add(
                          BlocEvent(HomeEvent.onMovieData, extra: movieData)),
                      onReservation: (movieData) => bloc.add(
                          BlocEvent(HomeEvent.onReservation, extra: movieData)),
                      movieList: state.movieList,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 16,
                      width: double.infinity,
                      color: const Color(0xFFF1F1F1),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: state.functionMenuList
                          .map(
                            (e) => SizedBox(
                              width: size.width / 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(imageUrl: e.imgUrl),
                                    const SizedBox(height: 8),
                                    Text(
                                      e.title,
                                      style: const TextStyle(
                                        fontFamily: 'NotoSansKr',
                                        fontSize: 13,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 10,
                      width: double.infinity,
                      color: const Color(0xFFF1F1F1),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: EventLayout(eventList: state.eventList),
                  ),
                  if (state.bandBannerData != null)
                    SliverToBoxAdapter(
                      child: BandBannerLayout(
                        onTap: () {},
                        bandBannerData: state.bandBannerData!,
                      ),
                    ),
                  const SliverSizedBox(
                    height: 8,
                    color: Color(0xFFF1F1F1),
                  ),
                  if (state.iceIconList != null)
                    SliverToBoxAdapter(
                      child: IceConLayout(
                        iceIconList: state.iceIconList!,
                        onTap: (cardData) {},
                        onReservation: (cardData) {},
                        onTotal: () {},
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 10,
                      width: double.infinity,
                      color: const Color(0xFFF1F1F1),
                    ),
                  ),
                  if (state.recommendMoviesList != null)
                    SliverToBoxAdapter(
                      child: RecommendMovieLayout(
                        recommendMovies: state.recommendMoviesList!,
                      ),
                    ),
                  const SliverToBoxAdapter(
                    child: BottomLayout(),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: state.isShowTop ? 100 : 32,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://img.cgv.co.kr/WebApp/images/main/common/btn_linkFixed.png',
                  width: 129,
                  height: 55,
                ),
              ),
              if (state.isShowTop)
                Positioned(
                  right: 16,
                  bottom: 32,
                  child: InkWell(
                    onTap: () => bloc.add(BlocEvent(HomeEvent.onTapTop)),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://img.cgv.co.kr/WebApp/images/main/btn_top.png',
                      width: 58,
                      height: 58,
                    ),
                  ),
                ),
              if (state.isPopShow)
                PopEventBottomSheet(
                  popEventData: state.popEventData,
                  popEventList: state.popEventList,
                  onTapEvent: (value) {},
                  onTapClose: () => bloc.add(BlocEvent(HomeEvent.onTapClose)),
                  onTapToday: (value) => bloc.add(
                    BlocEvent(HomeEvent.onTapToday, extra: value),
                  ),
                  isNoToday: state.isNotToday,
                )
            ],
          ),
        );
      },
    );
  }
}
