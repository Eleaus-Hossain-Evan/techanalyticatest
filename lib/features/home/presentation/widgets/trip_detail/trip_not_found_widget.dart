import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/core.dart';

/// Trip not found widget
class TripNotFoundWidget extends StatelessWidget {
  const TripNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: AppColors.textDark, size: 24.sp),
        ),
        title: AppText(
          'Trip details',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64.sp, color: AppColors.textGray),
              SizedBox(height: 16.h),
              AppText(
                'Trip not found',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              AppText(
                'The requested trip could not be found.',
                fontSize: 14.sp,
                color: AppColors.textGray,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
