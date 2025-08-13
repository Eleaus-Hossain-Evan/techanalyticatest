import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';

/// Driver Information Widget
///
/// Displays driver details with:
/// - Driver avatar (circular)
/// - Driver name
/// - Rating with stars
/// - Vehicle information
/// - Call button for communication
class DriverInfoWidget extends StatelessWidget {
  const DriverInfoWidget({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Driver avatar
          Icon(Icons.person, size: 40.sp, color: AppColors.primary),

          SizedBox(width: 12.w),

          // Driver info
          Expanded(child: _DriverDetailsWidget(trip: trip)),

          SizedBox(width: 12.w),

          // Call button
          _CallButtonWidget(driverPhone: trip.driverPhone),
        ],
      ),
    );
  }
}

/// Driver details widget with name and rating
class _DriverDetailsWidget extends StatelessWidget {
  const _DriverDetailsWidget({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Driver name
        AppText(
          trip.driverName,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: 4.h),

        // Rating
        _RatingWidget(rating: trip.driverRating),

        SizedBox(height: 4.h),
        // Vehicle type
        Flexible(
          child: AppText(
            trip.vehicleType,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Rating and vehicle info
      ],
    );
  }
}

/// Rating widget with stars
class _RatingWidget extends StatelessWidget {
  const _RatingWidget({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: 12.sp, color: AppColors.warning),

        SizedBox(width: 2.w),

        AppText(
          rating.toStringAsFixed(1),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),

        SizedBox(width: 2.w),

        AppText(
          '(1.2 ratings)',
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textGray,
        ),
      ],
    );
  }
}

/// Call button widget
class _CallButtonWidget extends StatelessWidget {
  const _CallButtonWidget({required this.driverPhone});

  final String? driverPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.success,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _makePhoneCall(driverPhone!),
          borderRadius: BorderRadius.circular(20.r),
          child: Center(
            child: Icon(
              Icons.phone_in_talk,
              size: 20.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // TODO: Implement phone call functionality with url_launcher package
    // For now, show a placeholder toast/snackbar
    debugPrint('Calling driver: $phoneNumber');
  }
}
