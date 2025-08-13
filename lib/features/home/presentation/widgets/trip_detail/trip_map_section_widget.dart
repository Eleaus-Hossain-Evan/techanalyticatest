import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';

class TripMapSectionWidget extends StatelessWidget {
  const TripMapSectionWidget({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.backgroundLight,
        border: Border.all(color: AppColors.border, width: 1.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(Images.dummyMap, fit: BoxFit.cover),
        // child: ReusableMapWidget(
        //   pickupLocation: LatLngModel(
        //     latitude: trip.pickupLatitude!,
        //     longitude: trip.pickupLongitude!,
        //   ),
        //   destinationLocation: LatLngModel(
        //     latitude: trip.destinationLatitude!,
        //     longitude: trip.destinationLongitude!,
        //   ),
        //   height: 200.h,
        //   width: double.infinity,
        //   borderRadius: BorderRadius.circular(12.r),
        // ),
      ),
    );
  }
}
