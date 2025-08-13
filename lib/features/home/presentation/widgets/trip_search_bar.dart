import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';

/// Search bar widget for trip booking search
class TripSearchBar extends StatelessWidget {
  const TripSearchBar({
    super.key,
    required this.onChanged,
    required this.onClear,
    this.hintText = 'Search booking',
    this.controller,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Color(0xffE6E6E9),
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 16, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textGray,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.black, size: 28.w),
          suffixIcon: controller?.text.isNotEmpty == true
              ? IconButton(
                  onPressed: onClear,
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.textGray,
                    size: 20.w,
                  ),
                )
              : Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.black,
                  size: 20.w,
                ),

          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
