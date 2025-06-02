import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../main.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DeepLinkService {
  void handleDeepLink(Uri uri) async {
    final accessToken = uri.queryParameters['access_token'];
    final refreshToken = uri.queryParameters['refresh_token'];

    if (accessToken != null && refreshToken != null) {
      try {
        // Set the session in Supabase with the refresh token
        await Supabase.instance.client.auth.setSession(refreshToken);

        // After successfully setting the session, navigate to HomePage
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } catch (e) {
        debugPrint('Failed to set session: $e');
      }
    }
  }
}
