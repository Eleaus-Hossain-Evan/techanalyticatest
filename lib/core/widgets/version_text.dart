import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core.dart';

class VersionText extends ConsumerWidget {
  const VersionText({super.key, required this.textColor});
  final Color textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        height: 44.h,
        child: Center(
          child: AppText('Beta Version 1.0', fontSize: 10.sp, fontWeight: FontWeight.normal, color: textColor),
        ),
      ),
    );
  }
}
