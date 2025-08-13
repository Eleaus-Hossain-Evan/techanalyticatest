import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';

class PaymentBreakdownWidget extends StatelessWidget {
  const PaymentBreakdownWidget({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment summary section
        _PaymentSummarySection(trip: trip),

        SizedBox(height: 20.h),

        // Fare breakdown section
        _FareBreakdownSection(trip: trip),
      ],
    );
  }
}

/// Payment summary section with status and method
class _PaymentSummarySection extends StatelessWidget {
  const _PaymentSummarySection({required this.trip});

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
        children: [
          // Final Payment status
          _PaymentDetailRowWidget(
            label: 'Final Payment status',
            value: 'Unpaid',
            valueWidget: _PaymentStatusChip(isPaid: false),
          ),

          SizedBox(height: 12.h),

          // Transition id
          _PaymentDetailRowWidget(
            label: 'Transition id',
            value: 'No',
            showIcon: true,
            icon: Icons.info_outline,
          ),

          SizedBox(height: 12.h),

          // Amount
          _PaymentDetailRowWidget(
            label: 'Amount',
            value: '৳ ${trip.displayFare.toStringAsFixed(0)}',
          ),

          SizedBox(height: 12.h),

          // Payment method
          _PaymentDetailRowWidget(
            label: 'Payment method',
            value: trip.paymentMethod ?? 'No',
          ),

          SizedBox(height: 12.h),

          // Advance Paid On
          _PaymentDetailRowWidget(label: 'Advance Paid On', value: 'No'),
        ],
      ),
    );
  }
}

/// Fare breakdown section with detailed charges
class _FareBreakdownSection extends StatelessWidget {
  const _FareBreakdownSection({required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    // Calculate fare components based on trip data
    final baseFare = 400.0;
    final perKmRate = trip.distance != null ? trip.distance! * 50.0 : 50.0;
    final waitingCharges = 0.0;
    final arrivalCost = 0.0;
    final bookingFee = 10.0;
    final vatTax = 0.0;

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
        children: [
          SizedBox(height: 12.h),

          // Base fare
          _FareBreakdownRowWidget(label: 'Base fare', amount: baseFare),

          SizedBox(height: 8.h),

          // Per KM rate
          _FareBreakdownRowWidget(label: '+ Per KM rate', amount: perKmRate),

          SizedBox(height: 8.h),

          // Waiting Charges
          _FareBreakdownRowWidget(
            label: '+ Waiting Charges',
            amount: waitingCharges,
          ),

          SizedBox(height: 8.h),

          // Arrival cost
          _FareBreakdownRowWidget(label: 'Arrival cost', amount: arrivalCost),

          SizedBox(height: 8.h),

          // Booking fee
          _FareBreakdownRowWidget(label: 'Booking fee', amount: bookingFee),

          SizedBox(height: 8.h),

          // VAT & TAX
          _FareBreakdownRowWidget(label: 'VAT & TAX', amount: vatTax),
        ],
      ),
    );
  }
}

/// Payment detail row widget for payment information
class _PaymentDetailRowWidget extends StatelessWidget {
  const _PaymentDetailRowWidget({
    required this.label,
    required this.value,
    this.valueWidget,
    this.showIcon = false,
    this.icon,
  });

  final String label;
  final String value;
  final Widget? valueWidget;
  final bool showIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        AppText(
          label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
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

            if (showIcon && icon != null) ...[
              SizedBox(width: 8.w),
              Icon(icon!, size: 16.sp, color: AppColors.textGray),
            ],
          ],
        ),
      ],
    );
  }
}

/// Payment status chip widget
class _PaymentStatusChip extends StatelessWidget {
  const _PaymentStatusChip({required this.isPaid});

  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    final statusColor = isPaid ? AppColors.success : AppColors.warning;
    final statusText = isPaid ? 'Paid' : 'Unpaid';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.w),
      ),
      child: AppText(
        statusText,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: statusColor,
      ),
    );
  }
}

/// Fare breakdown divider
class _FareBreakdownDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        50,
        (index) => Expanded(
          child: Container(
            height: 1.h,
            color: index.isEven ? AppColors.border : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

/// Fare breakdown row widget
class _FareBreakdownRowWidget extends StatelessWidget {
  const _FareBreakdownRowWidget({required this.label, required this.amount});

  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        AppText(
          label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark,
        ),

        // Amount
        AppText(
          'BDT ${amount.toStringAsFixed(2)}',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
      ],
    );
  }
}
