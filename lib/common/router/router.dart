import 'package:cgv/presentation/screen/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screen/main/main_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/main',
      name: MainScreen.routeName,
      builder: (_, __) => const MainScreen(),
    ),
  ],
);
