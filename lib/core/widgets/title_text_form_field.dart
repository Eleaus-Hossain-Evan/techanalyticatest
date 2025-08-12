import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final String? hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(title, color: AppColors.primary, fontWeight: FontWeight.normal, fontSize: 16.sp),
        12.verticalSpace,
        CustomTextFormField(
          controller: controller,
          hintText: hintText ?? title,
          validator: validator,
          keyboardType: keyboardType,
          isObscure: keyboardType == TextInputType.visiblePassword,
        ),
      ],
    );
  }
}

class TitleDateFormField extends StatelessWidget {
  const TitleDateFormField({super.key, required this.controller, this.validator, required this.title, this.onChanged});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(title, color: AppColors.primary),
        4.verticalSpace,
        CustomTextFormField.date(
          datePattern: 'MM/dd/yyyy',
          controller: controller,
          hintText: title,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
