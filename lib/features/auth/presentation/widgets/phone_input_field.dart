import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';

/// Phone input field with country code dropdown
///
/// This widget provides a specialized input field for phone number entry
/// with an integrated country code dropdown (defaulting to BD +880).
class PhoneInputField extends ConsumerWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hintText;
  final bool autofocus;
  final FocusNode? focusNode;

  const PhoneInputField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.hintText,
    this.autofocus = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      hintText: hintText ?? 'Enter phone number',
      keyboardType: TextInputType.phone,
      autofocus: autofocus,
      focusNode: focusNode,
      prefixIcon: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bangladesh flag icon (simplified as colored container)
            Container(
              width: 24.w,
              height: 16.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
                gradient: const LinearGradient(colors: [Color(0xFF006A4E), Color(0xFF006A4E)]),
              ),
              child: Center(
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: const BoxDecoration(color: Color(0xFFD91023), shape: BoxShape.circle),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '+880',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Container(width: 1.w, height: 20.h, color: AppColors.border),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
