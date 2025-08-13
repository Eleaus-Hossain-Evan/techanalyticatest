import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';

/// Distance and Time Information Widget
///
/// Displays trip distance and estimated time with:
/// - Distance in KM format
/// - Duration in minutes format
/// - Clean, horizontal layout
class DistanceTimeInfoWidget extends StatelessWidget {
  const DistanceTimeInfoWidget({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Distance label
        AppText(
          'Distance & Est. Time:',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textGray,
        ),

        Spacer(),

        // Distance value
        if (trip.distance != null) ...[
          AppText(
            '${trip.distance!.toStringAsFixed(2)}KM',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),

          SizedBox(width: 8.w),
        ],

        // Duration value
        if (trip.duration != null) ...[
          Container(color: Color(0xffD4D5D9), height: 12.h, width: 1.w),
          SizedBox(width: 8.w),
          AppText(
            '${trip.duration!.inMinutes} Mins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ],
      ],
    );
  }
}
