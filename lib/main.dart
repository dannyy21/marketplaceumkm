import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace_umkm/config/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/deep_link_service.dart';
import 'core/utils/app_providers.dart';
import 'core/utils/injection.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qfhpabjvlpptgmfoweut.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFmaHBhYmp2bHBwdGdtZm93ZXV0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY4NzA5NDYsImV4cCI6MjA2MjQ0Njk0Nn0.xpIwv9v4HpqcURiZaSJQoCdNPnRryN4HCMoCu0jEDYY',
  );
  runApp(const AppProviders(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;

  @override
  void initState() {
    setupInjection();
    super.initState();
    _appLinks = AppLinks();

    _appLinks.getInitialLink().then((link) {
      if (link != null) {
        print("Initial Link: $link");
        DeepLinkService().handleDeepLink(link);
      }
    });

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final accessToken = uri.queryParameters['access_token'];
        final refreshToken = uri.queryParameters['refresh_token'];

        if (accessToken != null && refreshToken != null) {
          Supabase.instance.client.auth
              .setSession(refreshToken)
              .then((_) {
                navigatorKey.currentState?.pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              })
              .catchError((e) {
                debugPrint('Gagal set session: $e');
              });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      // navigatorKey: navigatorKey,
      title: 'UMKM Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.white),
        cardTheme: const CardTheme(color: Colors.transparent),
        popupMenuTheme: const PopupMenuThemeData(
          surfaceTintColor: Colors.white,
        ),
        dividerTheme: const DividerThemeData(color: Color(0xffE2E8F0)),
        tabBarTheme: const TabBarTheme(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
      ),
      // home: LoginPage(),
    );
  }
}
