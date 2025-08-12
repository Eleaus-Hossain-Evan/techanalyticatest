import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/route/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(duration: const Duration(milliseconds: 2000));
    final scaleAnimation = useAnimation(
      Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animationController, curve: Curves.elasticOut)),
    );
    final fadeAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeIn)),
    );

    useEffect(() {
      // Start the logo animation
      animationController.forward();

      // Navigate to onboarding screen after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          context.go(AppRoutes.onboarding);
        }
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation,
              child: Opacity(
                opacity: fadeAnimation,
                child: AppText.white('Logo', fontSize: 64.sp, fontWeight: FontWeight.w600),
              ),
            );
          },
        ),
      ),
    );
  }
}
