import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../providers/trip_providers.dart';
import 'trip_card.dart';

/// Widget to display a list of trips with loading and error states
class TripsList extends HookConsumerWidget {
  const TripsList({super.key, this.onRefresh});

  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(combinedTripsProvider);

    return tripsAsync.when(
      data: (trips) {
        if (trips.isEmpty) {
          return TripListEmptyWidget();
        }

        return RefreshIndicator(
          onRefresh: () => Future.wait([
            ref.refresh(tripsByStatusProvider.future),
            ref.refresh(searchTripsProvider.future),
          ]),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];

              return TripCard(trip: trip);
            },
            separatorBuilder: (context, index) => 16.verticalSpace,
          ),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, stackTrace) => _buildErrorState(error),
    );
  }

  /// Build loading state with skeleton
  Widget _buildLoadingState() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 3,
      separatorBuilder: (context, index) => 16.verticalSpace,
      itemBuilder: (context, index) => RideTileSkeleton(),
    );
  }

  /// Build skeleton card for loading state
  Widget _buildSkeletonCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDim,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                Container(
                  width: 80.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDim,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              height: 14.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundDim,
                borderRadius: BorderRadius.circular(7.r),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 200.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundDim,
                borderRadius: BorderRadius.circular(7.r),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDim,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDim,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build error state
  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.w, color: AppColors.error),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 14, color: AppColors.textGray),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            CustomButton(
              text: 'Try Again',
              onPressed: onRefresh ?? () {},
              type: AppButtonType.outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class TripListEmptyWidget extends ConsumerWidget {
  const TripListEmptyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(selectedTripTabProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final emptyMessage = _getEmptyMessage(status, searchQuery);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64.w, color: AppColors.textGray),
            SizedBox(height: 16.h),
            Text(
              emptyMessage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textGray,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Your trips will appear here when available',
              style: const TextStyle(fontSize: 14, color: AppColors.textGray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Get empty message based on current state
  String _getEmptyMessage(TripStatus status, String searchQuery) {
    if (searchQuery.isNotEmpty) {
      return 'No trips found for "$searchQuery"';
    }

    return switch (status) {
      TripStatus.upcoming => 'No upcoming trips',
      TripStatus.completed => 'No completed trips',
      TripStatus.cancelled => 'No cancelled trips',
      _ => 'No trips found',
    };
  }
}

class RideTileSkeleton extends StatelessWidget {
  const RideTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map placeholder
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time placeholder
                  const Bone.text(words: 3, fontSize: 16),
                  const SizedBox(height: 8),

                  // Location row
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      const Expanded(child: Bone.text(words: 4, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Clinic info row
                  Row(
                    children: [
                      const Icon(
                        Icons.local_hospital,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      const Expanded(child: Bone.text(words: 5, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price and status row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Bone.text(words: 1, fontSize: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Bone.text(words: 1, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
