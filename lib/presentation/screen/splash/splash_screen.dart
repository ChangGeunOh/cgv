import 'dart:async';

import 'package:cgv/domain/bloc/bloc_layout.dart';
import 'package:cgv/presentation/screen/splash/bloc/splash_bloc.dart';
import 'package:cgv/presentation/screen/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocLayout<SplashBloc, SplashState>(
      create: (context) => SplashBloc(context, SplashState()),
      builder: (context, bloc, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                controller: bloc.controller,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(
                    'assets/images/img_splash.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const CircularProgressIndicator(
                color: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}
