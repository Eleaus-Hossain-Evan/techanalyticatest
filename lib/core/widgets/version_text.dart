import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../core.dart';

class VersionText extends ConsumerWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 44.h,
      child: Center(
        child: AppText.white('Beta Version 1.0', fontSize: 10.sp, fontWeight: FontWeight.normal),
      ),
    );
  }
}
