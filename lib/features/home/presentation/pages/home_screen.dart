import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';

/// Home screen displayed after successful authentication
///
/// This is a placeholder home screen that demonstrates successful login.
/// In a real app, this would contain the main app functionality.
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider).value;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context, ref),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // Welcome Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  children: [
                    // Success Icon
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.check_circle, size: 40.w, color: AppColors.success),
                    ),

                    SizedBox(height: 24.h),

                    // Welcome Message
                    Text(
                      'Welcome Back!',
                      style: const TextStyle(fontSize: 24, color: AppColors.textDark, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 8.h),

                    // User Info
                    if (currentUser != null) ...[
                      Text(
                        currentUser.name,
                        style: const TextStyle(fontSize: 20, color: AppColors.primary, fontWeight: FontWeight.w600),
                      ),

                      SizedBox(height: 4.h),

                      Text(currentUser.email, style: const TextStyle(fontSize: 16, color: AppColors.textGray)),

                      if (currentUser.phone != null) ...[
                        SizedBox(height: 4.h),
                        Text(currentUser.phone!, style: const TextStyle(fontSize: 14, color: AppColors.textGray)),
                      ],
                    ],
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Login Success Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.success.withOpacity(0.3), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.success, size: 20.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Login successful! This is your home screen.',
                        style: const TextStyle(fontSize: 16, color: AppColors.success),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Profile',
                      onPressed: () => _showComingSoonDialog(context, 'Profile'),
                      type: AppButtonType.outlined,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Settings',
                      onPressed: () => _showComingSoonDialog(context, 'Settings'),
                      type: AppButtonType.outlined,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // App Info
              Text('TechAnalytica Test App', style: const TextStyle(fontSize: 14, color: AppColors.textGray)),

              SizedBox(height: 4.h),

              Text('Authentication Demo', style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
            ],
          ),
        ),
      ),
    );
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog first

              try {
                // Read the notifier fresh to avoid disposed ref issues
                final authNotifier = ref.read(authNotifierProvider.notifier);
                await authNotifier.logout();
                ref.invalidate(isAuthenticatedProvider);

                // Navigation will be handled by router redirect
              } catch (e) {
                // Handle logout error if needed
                debugPrint('Logout error: $e');
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  /// Show coming soon dialog for placeholder features
  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: Text('$feature functionality is coming soon!'),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
      ),
    );
  }
}
