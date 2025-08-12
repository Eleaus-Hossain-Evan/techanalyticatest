import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';

/// Enum for authentication input types
enum AuthInputType { phone, email }

/// Custom toggle tabs for authentication (Phone Number / Email Address)
///
/// This widget provides a segmented control for switching between
/// phone number and email address input modes in the login form.
class AuthToggleTabs extends HookWidget {
  final ValueChanged<AuthInputType>? onTabChanged;
  final AuthInputType? initialTab;

  const AuthToggleTabs({super.key, this.onTabChanged, this.initialTab});

  @override
  Widget build(BuildContext context) {
    final selectedType = useState(initialTab ?? AuthInputType.phone);

    return Container(
      height: 44.h,
      decoration: BoxDecoration(color: AppColors.backgroundDim, borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              text: 'Phone Number',
              isSelected: selectedType.value == AuthInputType.phone,
              onTap: () {
                selectedType.value = AuthInputType.phone;
                onTabChanged?.call(AuthInputType.phone);
              },
            ),
          ),
          Expanded(
            child: _TabButton(
              text: 'Email Address',
              isSelected: selectedType.value == AuthInputType.email,
              onTap: () {
                selectedType.value = AuthInputType.email;
                onTabChanged?.call(AuthInputType.email);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual tab button component
class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: AppText(text, color: isSelected ? AppColors.white50 : AppColors.textDark, fontSize: 14.sp),
        ),
      ),
    );
  }
}
