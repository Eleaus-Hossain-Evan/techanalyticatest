import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Reusable custom transition pages for go_router
///
/// Example usage:
/// ```dart
/// GoRoute(
///   path: '/fade-screen',
///   pageBuilder: (context, state) => FadeTransitionPage<void>(
///     key: state.pageKey,
///     child: const MyScreen(),
///   ),
/// ),
///
/// GoRoute(
///   path: '/slide-screen',
///   pageBuilder: (context, state) => SlideFromBottomTransitionPage<void>(
///     key: state.pageKey,
///     child: const MyScreen(),
///     transitionDuration: const Duration(milliseconds: 800),
///   ),
/// ),
/// ```

/// Abstract base class for custom transition pages
abstract class CustomTransitionPageBase<T> extends CustomTransitionPage<T> {
  const CustomTransitionPageBase({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 500),
    super.reverseTransitionDuration,
  }) : super(transitionsBuilder: _buildTransition);

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // This will be overridden by concrete implementations
    return child;
  }

  /// Override this method to define custom transition animations
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  );
}

/// Fade transition page
class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  const FadeTransitionPage({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 500),
    super.reverseTransitionDuration = const Duration(milliseconds: 800),
  }) : super(transitionsBuilder: _buildTransition);

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// Slide transition page (slides from bottom with fade)
class SlideFromBottomTransitionPage<T> extends CustomTransitionPage<T> {
  const SlideFromBottomTransitionPage({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 600),
    super.reverseTransitionDuration,
  }) : super(transitionsBuilder: _buildTransition);

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

/// Slide transition page (slides from right)
class SlideFromRightTransitionPage<T> extends CustomTransitionPage<T> {
  const SlideFromRightTransitionPage({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 400),
    super.reverseTransitionDuration,
  }) : super(transitionsBuilder: _buildTransition);

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}

/// Scale transition page
class ScaleTransitionPage<T> extends CustomTransitionPage<T> {
  const ScaleTransitionPage({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 500),
    super.reverseTransitionDuration,
  }) : super(transitionsBuilder: _buildTransition);

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.elasticOut),
      child: child,
    );
  }
}

/// No transition page (instant)
class NoTransitionPage<T> extends CustomTransitionPage<T> {
  const NoTransitionPage({required super.child, super.key})
    : super(
        transitionsBuilder: _buildTransition,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

/// Custom animation page builder
class CustomAnimationPage<T> extends CustomTransitionPage<T> {
  const CustomAnimationPage({
    required super.child,
    required super.transitionsBuilder,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 500),
    super.reverseTransitionDuration,
  });
}
