import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';
import 'distance_time_info_widget.dart';

class TripDetailHeaderWidget extends StatelessWidget {
  const TripDetailHeaderWidget({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.backgroundLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip time
          _TripTimeWidget(pickupTime: trip.pickupTime),

          SizedBox(height: 20.h),

          // Pickup location
          _LocationItemWidget(
            iconPath: Images.iconLocationPin,
            location: trip.pickupLocation,
          ),

          SizedBox(height: 12.h),

          // Destination location
          _LocationItemWidget(
            iconPath: Images.iconDestinationPin,
            location: trip.destinationLocation,
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: Color(0xffD4D5D9), thickness: .5),
          SizedBox(height: 16.h),

          // Distance and time info
          DistanceTimeInfoWidget(trip: trip),
        ],
      ),
    );
  }
}

/// Trip time display widget
class _TripTimeWidget extends StatelessWidget {
  const _TripTimeWidget({required this.pickupTime});

  final DateTime pickupTime;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('h:mm a');
    final today = DateTime.now();
    final isToday =
        pickupTime.year == today.year &&
        pickupTime.month == today.month &&
        pickupTime.day == today.day;

    return AppText(
      isToday
          ? 'Today, ${timeFormat.format(pickupTime)}'
          : DateFormat('MMM dd, h:mm a').format(pickupTime),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }
}

/// Location item widget with icon and text
class _LocationItemWidget extends StatelessWidget {
  const _LocationItemWidget({required this.iconPath, required this.location});

  final String iconPath;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Location icon
        Image.asset(iconPath, width: 16.w, height: 16.h, fit: BoxFit.contain),

        SizedBox(width: 4.w),

        // Location text
        Expanded(
          child: AppText(
            location,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
