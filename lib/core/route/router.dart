import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/providers/auth_state_provider.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/trip_detail_screen.dart';
import '../../features/onboarding/onboarding.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';
import 'custom_transitions.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: _AuthStateNotifier(ref),
    redirect: (context, state) {
      final isSignedIn = ref.read(isAuthenticatedProvider).value ?? false;

      final isAuthRoute =
          state.fullPath == AppRoutes.login ||
          state.fullPath == AppRoutes.onboarding ||
          state.fullPath == AppRoutes.splash;
      // If user is signed in and trying to access auth routes, redirect to home
      if (isSignedIn && isAuthRoute) {
        return AppRoutes.home;
      }

      // If user is not signed in and trying to access protected routes, redirect to login
      if (!isSignedIn && !isAuthRoute) {
        return AppRoutes.login;
      }

      // No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        name: AppRoutes.splash,
        path: AppRoutes.splash,
        pageBuilder: (context, state) => FadeTransitionPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 0),
          reverseTransitionDuration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        name: AppRoutes.onboarding,
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) => SlideFromRightTransitionPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        name: AppRoutes.login,
        path: AppRoutes.login,
        pageBuilder: (context, state) => SlideFromBottomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        name: AppRoutes.home,
        path: AppRoutes.home,
        pageBuilder: (context, state) => SlideFromRightTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        name: AppRoutes.tripDetail,
        path: '${AppRoutes.tripDetail}/:tripId',
        pageBuilder: (context, state) {
          final tripId = state.pathParameters['tripId']!;
          return SlideFromRightTransitionPage<void>(
            key: state.pageKey,
            child: TripDetailScreen(tripId: tripId),
            transitionDuration: const Duration(milliseconds: 400),
          );
        },
      ),
    ],
  );
}

class _AuthStateNotifier extends ChangeNotifier {
  _AuthStateNotifier(this.ref) {
    // Listen to auth state changes and notify GoRouter
    ref.listen(isAuthenticatedProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }

  final Ref ref;
}
