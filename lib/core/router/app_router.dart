import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:food_app/features/auth/presentation/screens/login_screen.dart';
import 'package:food_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:food_app/features/food/data/models/FoodModel.dart';
import 'package:food_app/features/food/domain/entities/FoodEntity.dart';
import 'package:food_app/features/food/presentation/screens/food_app_home_screen.dart';
import 'package:food_app/features/food/presentation/screens/food_details_screen.dart';
import 'package:food_app/features/food/presentation/screens/view_all_products_screen.dart';
import 'package:food_app/features/home/app_main_screen.dart';
import 'package:food_app/features/onboading/onboarding_screen.dart';
import 'package:food_app/features/profile/profile_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) async {
    // return asyncRedirect(context, state);
  },

  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

    ShellRoute(
      builder: (context, state, child) {
        final authState = context.watch<AuthBloc>().state;
        final userUid = authState is AuthSuccess ? authState.user.id : 0;
        print("UID From Router: $userUid");
        return AppMainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/signup',
          name: 'signup',
          pageBuilder:
              (context, state) => const NoTransitionPage(child: SignupScreen()),
        ),

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
          path: '/viewAllProduct',
          name: 'viewAllProduct',
          pageBuilder:
              (context, state) =>
                  const NoTransitionPage(child: ViewAllProductsScreen()),
        ),

        GoRoute(
          path: '/foodDetails',
          name: 'foodDetails',
          pageBuilder: (context, state) {
            final food = state.extra;
            if (food is! FoodEntity) {
              return const MaterialPage(child: Scaffold(body: Center(child: Text("Null Parameter"),),));
            }

            return MaterialPage(
              key: state.pageKey,
              child: FoodDetailsScreen(food: food),
              // child: Scaffold(body: Center(child: Text('Key: ${state.pageKey}'),),),
            );
          }
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
