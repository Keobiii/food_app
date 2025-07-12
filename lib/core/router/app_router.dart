import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/food/food_app_home_screen.dart';
import 'package:food_app/features/home/app_main_screen.dart';
import 'package:food_app/features/onboading/onboarding_screen.dart';
import 'package:food_app/features/profile/profile_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

GoRouter createRouter() {

  return GoRouter(
    initialLocation: '/home',

    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      ShellRoute(
        builder: (context, state, child) => AppMainScreen(child: child),
        routes: [
          GoRoute(
            path: '/onboarding',
            name: 'onboarding',
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: OnboardingScreen()),
          ),

          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: FoodAppHomeScreen()),
          ),

          GoRoute(
            path: '/wishlist',
            name: 'wishlist',
            pageBuilder:
                (context, state) => const NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('Favorite'))),
                ),
          ),

          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
          ),

          GoRoute(
            path: '/cart',
            name: 'cart',
            pageBuilder:
                (context, state) => const NoTransitionPage(
                  child: Scaffold(body: Center(child: Text('Cart'))),
                ),
          ),
        ],
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      debugPrint('🔁 AuthBloc state changed. Triggering redirect.');
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
