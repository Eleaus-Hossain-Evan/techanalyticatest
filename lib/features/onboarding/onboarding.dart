import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Images.onboardingBg, fit: BoxFit.fill),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                60.verticalSpace,
                AppText.white('Logo', fontSize: 64.sp, fontWeight: FontWeight.w600),
                Spacer(),
                AppText.white(
                  'Welcome to company',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                10.verticalSpace,
                AppText.white(
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
                48.verticalSpace,
                CustomButton(
                  onPressed: () {
                    context.push(AppRoutes.login);
                  },
                  text: 'Login',
                  backgroundColor: AppColors.white50,
                  foregroundColor: AppColors.textDark,
                ),
                16.verticalSpace,
                CustomButton(
                  onPressed: () {
                    // TODO: Navigate to Create Account screen
                    debugPrint('Navigate to Create Account');
                  },
                  text: 'Create Account',
                  backgroundColor: AppColors.success,
                  foregroundColor: AppColors.white50,
                ),
                30.verticalSpace,
                VersionText(textColor: AppColors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
