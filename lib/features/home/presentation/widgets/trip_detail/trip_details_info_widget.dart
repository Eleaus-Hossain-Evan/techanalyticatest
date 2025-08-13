import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';

class TripDetailsInfoWidget extends StatelessWidget {
  const TripDetailsInfoWidget({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: AppColors.border.withOpacity(0.5),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip status
          _TripDetailRowWidget(
            label: 'Trip status',
            value: trip.status.displayName,
            valueWidget: _TripStatusChip(status: trip.status),
          ),

          SizedBox(height: 12.h),

          // Trip ID
          _TripDetailRowWidget(
            label: 'Trip Id',
            value: '#${trip.bookingNumber}',
            showCopyIcon: true,
          ),

          SizedBox(height: 12.h),

          // Contact
          _TripDetailRowWidget(label: 'Contact', value: 'For me'),

          SizedBox(height: 12.h),

          // Vehicle Type
          _TripDetailRowWidget(label: 'Vehicle Type', value: trip.vehicleType),

          SizedBox(height: 12.h),

          // Trip type
          _TripDetailRowWidget(
            label: 'Trip type',
            value: trip.tripType.displayName,
          ),

          SizedBox(height: 12.h),

          // Category
          _TripDetailRowWidget(label: 'Category', value: 'General'),
        ],
      ),
    );
  }
}

/// Trip detail row widget for consistent layout
class _TripDetailRowWidget extends StatelessWidget {
  const _TripDetailRowWidget({
    required this.label,
    required this.value,
    this.valueWidget,
    this.showCopyIcon = false,
  });

  final String label;
  final String value;
  final Widget? valueWidget;
  final bool showCopyIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        AppText(
          label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textGray,
        ),

        // Value
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (valueWidget != null)
              valueWidget!
            else
              AppText(
                value,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),

            if (showCopyIcon) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => _copyToClipboard(context, value),
                child: Icon(
                  Icons.content_copy,
                  size: 16.sp,
                  color: AppColors.textGray,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    // TODO: Implement clipboard functionality
    debugPrint('Copying to clipboard: $text');
  }
}

/// Trip status chip widget
class _TripStatusChip extends StatelessWidget {
  const _TripStatusChip({required this.status});

  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);
    final statusBackgroundColor = statusColor.withOpacity(0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusBackgroundColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.w),
      ),
      child: AppText(
        status.displayName,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: statusColor,
      ),
    );
  }

  Color _getStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.upcoming:
      case TripStatus.scheduled:
        return AppColors.tripUpcoming;
      case TripStatus.inProgress:
        return AppColors.warning;
      case TripStatus.completed:
        return AppColors.tripCompleted;
      case TripStatus.cancelled:
        return AppColors.tripCancelled;
    }
  }
}

/// Extension to get display names for trip types
extension TripTypeExtension on TripType {
  String get displayName {
    switch (this) {
      case TripType.regular:
        return 'Single trip';
      case TripType.express:
        return 'Express trip';
      case TripType.scheduled:
        return 'Scheduled trip';
      case TripType.longDistance:
        return 'Long distance';
    }
  }
}
