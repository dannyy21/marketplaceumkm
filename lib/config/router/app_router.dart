import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace_umkm/features/auth/presentation/pages/login_page.dart';
import 'package:marketplace_umkm/features/auth/presentation/pages/register_page.dart';
import 'package:marketplace_umkm/features/home/presentation/pages/home_page.dart';
import 'package:marketplace_umkm/features/home/presentation/pages/main_page.dart';
import 'package:marketplace_umkm/features/home/presentation/widgets/map_full_screen_page.dart';
import 'package:marketplace_umkm/features/home/presentation/widgets/nearby_section.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'login', builder: (context, state) => LoginPage()),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      path: "/map_full_screen_page",
      name: 'map_full_screen_page',
      builder: (context, state) {
        final sellerLocations = state.extra as List<SellerLocation>;
        return MapFullScreenPage(sellerLocations: sellerLocations);
      },
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final session = Supabase.instance.client.auth.currentSession;
    final loggedIn = session != null;
    final loggingIn = state.location == '/login';

    if (!loggedIn && !loggingIn) {
      return '/login';
    }
    if (loggedIn && (loggingIn || state.location == '/')) {
      return '/home';
    }

    return null;
  },
);
