import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';

/// Enhanced phone input field with country code picker
///
/// This widget provides a comprehensive phone number input solution with:
/// - Country flag display
/// - Country code selection (+880, +1, etc.)
/// - Proper validation
/// - Custom styling to match the design system
class CountryPhoneInputField extends HookWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hintText;
  final bool autofocus;
  final FocusNode? focusNode;
  final Function(CountryCode)? onCountryChanged;

  const CountryPhoneInputField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.hintText,
    this.autofocus = false,
    this.focusNode,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    // State for selected country
    final selectedCountry = useState<CountryCode?>(
      CountryCode.fromDialCode('+880'), // Default to Bangladesh
    );

    return Row(
      children: [
        // Country Code Picker
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(6),
              color: AppColors.backgroundLight,
            ),
            child: CountryCodePicker(
              onChanged: (countryCode) {
                selectedCountry.value = countryCode;
                onCountryChanged?.call(countryCode);
              },
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(right: 8.w),
              textStyle: TextStyle(color: AppColors.textGray, fontSize: 14.sp, fontWeight: FontWeight.normal),
              initialSelection: '+880',
              favorite: const ['+880', '+1', '+44', '+91', '+86'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              showDropDownButton: false,
              showFlagMain: true,
              pickerStyle: PickerStyle.dialog,
              dialogTextStyle: TextStyle(color: AppColors.textDark, fontSize: 14.sp, fontWeight: FontWeight.normal),
              searchStyle: TextStyle(color: AppColors.textDark, fontSize: 14.sp, fontWeight: FontWeight.normal),
              flagWidth: 26,
              boxDecoration: const BoxDecoration(color: Colors.transparent),
              // Customize the picker dialog
              dialogSize: Size(300.w, 500.h),
              searchDecoration: InputDecoration(
                hintText: 'Search country',
                hintStyle: TextStyle(color: AppColors.textGray, fontSize: 14.sp, fontWeight: FontWeight.normal),
                prefixIcon: const Icon(Icons.search, color: AppColors.textGray),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ),
        ),

        8.horizontalSpace,

        // Phone Number Input Field
        Expanded(
          flex: 2,
          child: CustomTextFormField(
            controller: controller,
            validator: (value) {
              if (validator != null) {
                return validator!(value);
              }
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              if (value.length < 8) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            onChanged: onChanged,
            hintText: hintText ?? 'Enter phone number',
            keyboardType: TextInputType.phone,
            autofocus: autofocus,
            focusNode: focusNode,
          ),
        ),
      ],
    );
  }
}
