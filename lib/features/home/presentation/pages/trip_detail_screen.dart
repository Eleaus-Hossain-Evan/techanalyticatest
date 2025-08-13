import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/entities/trip.dart';
import '../providers/trip_providers.dart';
import '../widgets/trip_detail/driver_info_widget.dart';
import '../widgets/trip_detail/payment_breakdown_widget.dart';
import '../widgets/trip_detail/receipt_download_widget.dart';
import '../widgets/trip_detail/trip_detail_header_widget.dart';
import '../widgets/trip_detail/trip_details_info_widget.dart';
import '../widgets/trip_detail/trip_map_section_widget.dart';
import '../widgets/trip_detail/trip_not_found_widget.dart';

class TripDetailScreen extends ConsumerWidget {
  const TripDetailScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripByIdProvider(tripId));

    return Scaffold(
      backgroundColor: AppColors.white,
      body: tripAsync.when(
        data: (trip) => trip != null
            ? _TripDetailContent(trip: trip)
            : TripNotFoundWidget(),
        loading: () => Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2.w,
          ),
        ),
        error: (error, stack) => TripDetailErrorWidget(error: error),
      ),
    );
  }
}

/// Main content widget for trip details
class _TripDetailContent extends StatelessWidget {
  const _TripDetailContent({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header with back button and title
        SliverAppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          pinned: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textDark,
              size: 24.sp,
            ),
          ),
          title: AppText(
            'Trip details',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          centerTitle: true,
        ),
        // Main content
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip header with time and locations
                TripDetailHeaderWidget(trip: trip),

                SizedBox(height: 16.h),

                // Map section
                TripMapSectionWidget(trip: trip),

                SizedBox(height: 16.h),

                // Driver info
                DriverInfoWidget(trip: trip),

                SizedBox(height: 16.h),

                // Trip details info
                TripDetailsInfoWidget(trip: trip),

                SizedBox(height: 16.h),

                // Payment breakdown
                PaymentBreakdownWidget(trip: trip),

                SizedBox(height: 16.h),

                // Receipt download
                ReceiptDownloadWidget(trip: trip),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Error state widget
class TripDetailErrorWidget extends StatelessWidget {
  const TripDetailErrorWidget({super.key, required this.error});

  final Object error;

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
              Icon(Icons.error_outline, size: 64.sp, color: AppColors.error),
              SizedBox(height: 16.h),
              AppText(
                'Something went wrong',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              AppText(
                'Unable to load trip details. Please try again.',
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
