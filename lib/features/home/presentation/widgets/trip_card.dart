import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/entities/lat_lng_model.dart';
import '../../domain/entities/trip.dart';
import 'reusable_map_widget.dart';

/// Trip card widget to display trip information
class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final isNotUpcoming =
        trip.status == TripStatus.completed ||
        trip.status == TripStatus.cancelled;
    return SizedBox(
      height: isNotUpcoming ? 180.h : 130.h,
      child: KInkWell(
        onTap: () {
          context.push('${AppRoutes.tripDetail}/${trip.id}');
        },
        backgroundColor: Color(0xffF7F8F8),
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          children: [
            // Image.asset(
            //   Images.dummyMap,
            //   width: 130,
            //   height: isNotUpcoming ? 180.h : 130.h,
            // ),
            ReusableMapWidget(
              pickupLocation: LatLngModel(
                latitude: trip.pickupLatitude!,
                longitude: trip.pickupLongitude!,
              ),
              destinationLocation: LatLngModel(
                latitude: trip.destinationLatitude!,
                longitude: trip.destinationLongitude!,
              ),
              height: isNotUpcoming ? 180.h : 130.h,
              width: 130.w,
            ),
            6.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Date
                  AppText(
                    DateFormat('MMM dd, HH:mm').format(trip.pickupTime),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),

                  SizedBox(height: 12.h),

                  // Pickup and destination
                  _buildLocationSection(),

                  SizedBox(height: 12.h),

                  // Fare and actions
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12.w,
                    children: [
                      AppText(
                        '${trip.displayFare.toStringAsFixed(2)} BDT',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),

                      Expanded(child: StatusChip(trip: trip)),
                    ],
                  ),

                  // Action Button
                  if (isNotUpcoming) ...[
                    12.verticalSpace,
                    _buildActionButtons(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build location section with pickup and destination
  Widget _buildLocationSection() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(Images.iconLocationPin, width: 16, height: 16),
            4.horizontalSpace,
            Expanded(
              child: AppText(
                trip.pickupLocation,
                fontSize: 12.sp,
                color: AppColors.textDark,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Row(
          children: [
            Image.asset(Images.iconDestinationPin, width: 16, height: 16),
            4.horizontalSpace,
            Expanded(
              child: AppText(
                trip.destinationLocation,
                fontSize: 12.sp,
                color: AppColors.textDark,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build action buttons for upcoming trips
  Widget _buildActionButtons() {
    return CustomButton(
      text: "Rebook",
      textStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      foregroundColor: AppColors.black,
      trailingIcon: Image.asset(Images.iconRebook, width: 12, height: 12),
      height: 28,
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: trip.status.backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: AppText(
        trip.status.displayName,
        textAlign: TextAlign.center,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: trip.status.statusColor,
      ),
    );
  }
}
