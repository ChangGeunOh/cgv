import 'package:go_router/go_router.dart';

import '../../presentation/screen/main/main_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/main',
      name: MainScreen.routeName,
      builder: (_, __) => const MainScreen(),
    ),
  ],
);
