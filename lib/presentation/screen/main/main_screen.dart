import 'package:cgv/common/const/color.dart';
import 'package:cgv/common/const/constants.dart';
import 'package:cgv/domain/bloc/bloc_event.dart';
import 'package:cgv/presentation/screen/home/home_screen.dart';
import 'package:cgv/presentation/screen/main/bloc/main_bloc.dart';
import 'package:cgv/presentation/screen/main/bloc/main_event.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../../domain/bloc/bloc_layout.dart';
import 'bloc/main_state.dart';

class MainScreen extends StatelessWidget {
  static String get routeName => 'main';

  TabBar get _tabBar => TabBar(
        isScrollable: true,
        indicatorColor: Colors.white,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        tabs: tabTitles
            .map((title) => Tab(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ))
            .toList(),
      );

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocLayout<MainBloc, MainState>(
      create: (context) => MainBloc(context, MainState()),
      builder: (context, bloc, state) {
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScalled) {
                return [
                  SliverAppBar(
                    titleSpacing: 0.0,
                    title: SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Image.asset(
                              'assets/images/img_cgv.png',
                              width: 61,
                              height: 26,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => bloc.add(BlocEvent(MainEvent.badge)),
                            child: badges.Badge(
                              position:
                                  badges.BadgePosition.topEnd(end: 0, top: 0),
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Color(0xFFBEC1C7)),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  state.badge.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/ic_ticket.png',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => bloc.add(BlocEvent(MainEvent.popcon)),
                            child: Image.asset(
                              'assets/icons/ic_popcon.png',
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              bloc.event(BlocEvent(MainEvent.menu));
                            },
                            child: Image.asset(
                              'assets/icons/ic_drawer.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    bottom: PreferredSize(
                      preferredSize: _tabBar.preferredSize,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        color: tabBackgroundColor,
                        child: _tabBar,
                      ),
                    ),
                  ),
                ];
              },
              body: const TabBarView(
                children: [
                  HomeScreen(),
                  Icon(Icons.directions_transit, size: 350),
                  Icon(Icons.directions_car, size: 350),
                  Icon(Icons.directions_bike, size: 350),
                  Icon(Icons.directions_boat, size: 350),
                  Icon(Icons.directions_boat, size: 350),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
