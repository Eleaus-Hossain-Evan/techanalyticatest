import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/trip.dart';

/// Receipt Download Widget
///
/// Displays download receipt functionality with:
/// - Download receipt button
/// - Appropriate styling matching design
/// - Loading states for download process
/// - Error handling for download failures
class ReceiptDownloadWidget extends StatefulWidget {
  const ReceiptDownloadWidget({super.key, required this.trip});

  final Trip trip;

  @override
  State<ReceiptDownloadWidget> createState() => _ReceiptDownloadWidgetState();
}

class _ReceiptDownloadWidgetState extends State<ReceiptDownloadWidget> {
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border, width: 1.w),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isDownloading ? null : _downloadReceipt,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isDownloading) ...[
                  SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  AppText(
                    'Downloading...',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGray,
                  ),
                ] else ...[
                  AppText(
                    'Download receipt',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadReceipt() async {
    if (widget.trip.receiptUrl == null) {
      _showErrorMessage('Receipt not available for this trip');
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      // TODO: Implement actual receipt download functionality
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        _showSuccessMessage('Receipt downloaded successfully');
      }
    } catch (error) {
      if (mounted) {
        _showErrorMessage('Failed to download receipt. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(message, fontSize: 14.sp, color: AppColors.white),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(message, fontSize: 14.sp, color: AppColors.white),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
