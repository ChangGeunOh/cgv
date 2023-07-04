import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgv/common/const/color.dart';
import 'package:cgv/common/const/constants.dart';
import 'package:cgv/domain/bloc/bloc_event.dart';
import 'package:cgv/domain/bloc/bloc_layout.dart';
import 'package:cgv/presentation/screen/home/bloc/home_bloc.dart';
import 'package:cgv/presentation/screen/home/bloc/home_event.dart';
import 'package:cgv/presentation/screen/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/model/card_data.dart';
import '../../component/banner_page_view.dart';
import '../../component/sliver_sized_box.dart';
import 'component/band_banner_layout.dart';
import 'component/event_layout.dart';
import 'component/ice_con_layout.dart';
import 'component/movie_chart_button_layout.dart';
import 'component/movie_chart_layout.dart';
import 'component/recommend_movie_layout.dart';
import 'component/under_line_button_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocLayout<HomeBloc, HomeState>(
      create: (context) => HomeBloc(context, HomeState()),
      builder: (context, bloc, state) {
        final size = MediaQuery.of(context).size;
        print('recommendMoviesList');
        print(state.recommendMoviesList?.toList());
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
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
                    bloc.add(BlocEvent(HomeEvent.onMovieChart, extra: true));
                  },
                  onTapComingSoon: () {
                    bloc.add(BlocEvent(HomeEvent.onMovieChart, extra: false));
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
                  onTap: (movieData) => bloc
                      .add(BlocEvent(HomeEvent.onMovieData, extra: movieData)),
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
              SliverToBoxAdapter(
                child: BottomLayout(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomLayout extends StatefulWidget {
  const BottomLayout({
    super.key,
  });

  @override
  State<BottomLayout> createState() => _BottomLayoutState();
}

class _BottomLayoutState extends State<BottomLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          children: [
            ExpansionTile(
              title: Text('title'),
              expandedAlignment: Alignment.center,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              controlAffinity: ListTileControlAffinity.values.last,
              children: [
                Container(
                  height: 100,
                  color: Colors.blue,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'CJ CGV (주)',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset('assets/icons/ic_arrow_down.png'),
              ],
            ),
            const SizedBox(height: 8),
            const IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    '이용약관',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                  VerticalDivider(
                    thickness: 0.5,
                    color: Color(0xffC8C8C8),
                    indent: 5,
                    endIndent: 3,
                  ),
                  Text(
                    '개인정보처리방침',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  VerticalDivider(
                    thickness: 0.5,
                    color: Color(0xffC8C8C8),
                    indent: 5,
                    endIndent: 3,
                  ),
                  Text(
                    '위치기반서비스 이용약관',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                  VerticalDivider(
                    thickness: 0.5,
                    color: Color(0xffC8C8C8),
                    indent: 5,
                    endIndent: 3,
                  ),
                  Text(
                    '법적고지',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
