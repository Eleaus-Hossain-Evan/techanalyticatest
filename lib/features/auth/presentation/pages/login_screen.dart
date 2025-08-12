import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../providers/auth_state_provider.dart';
import '../widgets/auth_toggle_tabs.dart';
import '../widgets/country_phone_input_field.dart';

/// Login screen implementing the Figma design
///
/// Features:
/// - Logo display
/// - Welcome text
/// - Toggle between phone/email input
/// - Password field with visibility toggle
/// - Login button with loading state
/// - Create account link
/// - Beta version info
/// - Error handling and validation
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Form controllers and state
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // UI state
    final selectedInputType = useState(AuthInputType.phone);

    final authState = ref.watch(authNotifierProvider);

    // Focus nodes for proper tab navigation
    final inputFocusNode = useFocusNode();

    ref.listen(authNotifierProvider, (previous, next) {
      if (previous != next) {
        ref.invalidate(isAuthenticatedProvider);
      }
      ref.handleAsyncValue(context, next);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(AppRoutes.onboarding);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(Images.loginBg, fit: BoxFit.fill)),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 90.h),

                    // Logo
                    Center(
                      child: Text(
                        'Logo',
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 64.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Welcome text
                    Center(
                      child: Column(
                        children: [
                          AppText(
                            'Welcome to Company',

                            color: AppColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                          8.verticalSpace,
                          AppText(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                            color: AppColors.textGray,
                            fontSize: 12.sp,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Input type toggle tabs
                    AuthToggleTabs(
                      onTabChanged: (type) => selectedInputType.value = type,
                      initialTab: selectedInputType.value,
                    ),

                    SizedBox(height: 24.h),

                    // Input field (Phone or Email)
                    if (selectedInputType.value == AuthInputType.phone)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText('Phone', color: AppColors.primary, fontWeight: FontWeight.normal, fontSize: 16.sp),
                          12.verticalSpace,
                          CountryPhoneInputField(
                            controller: phoneController,
                            focusNode: inputFocusNode,
                            hintText: 'Enter phone number',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              if (value.length < 8) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            onCountryChanged: (countryCode) {
                              debugPrint('Selected country: ${countryCode.name} (${countryCode.dialCode})');
                            },
                          ),
                        ],
                      )
                    else
                      TitleTextFormField(
                        controller: emailController,
                        title: 'Email',
                        hintText: 'Enter email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),

                    SizedBox(height: 16.h),

                    // Password field
                    TitleTextFormField(
                      controller: passwordController,
                      title: 'Password',
                      hintText: 'Enter password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                    ),

                    SizedBox(height: 24.h),

                    // Login button
                    CustomButton(
                      text: 'Login',
                      trailingIcon: Icon(Icons.arrow_forward),
                      isLoading: authState.isLoading,
                      backgroundColor: Color(0xff180908),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        ref
                            .read(authNotifierProvider.notifier)
                            .login(
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            );
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Create account link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          "Don't have an account? ",
                          color: AppColors.textGray,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to create account screen
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text('Create account feature coming soon')));
                          },
                          child: Text(
                            'Create',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: VersionText(textColor: AppColors.textGray),
    );
  }
}
