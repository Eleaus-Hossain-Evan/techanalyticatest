import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';

/// Demo widget to showcase country picker features
///
/// This widget demonstrates all the features of the country picker
/// as requested in the Figma design:
/// - Country flag display
/// - Country code selection
/// - Search functionality
/// - Favorites support
class CountryPickerDemo extends HookWidget {
  const CountryPickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCountry = useState<CountryCode>(CountryCode.fromDialCode('+880'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Picker Demo'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Country Selection Features',
              style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),

            SizedBox(height: 24.h),

            // Current Selection Display
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.backgroundLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Country:',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      // Country Flag
                      CountryCodePicker(
                        initialSelection: selectedCountry.value.dialCode,
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        enabled: false,
                        flagWidth: 32.w,
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCountry.value.name ?? 'Unknown',
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            selectedCountry.value.dialCode ?? 'N/A',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Country Picker Button
            Text(
              'Select Country:',
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
            SizedBox(height: 8.h),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CountryCodePicker(
                onChanged: (countryCode) {
                  selectedCountry.value = countryCode;
                },
                initialSelection: selectedCountry.value.dialCode,
                favorite: const ['+880', '+1', '+44', '+91', '+86', '+33', '+49'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: true,
                showDropDownButton: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                textStyle: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
                dialogTextStyle: context.textTheme.bodyMedium?.copyWith(color: AppColors.textDark),
                searchStyle: context.textTheme.bodyMedium?.copyWith(color: AppColors.textDark),
                flagWidth: 24.w,
                dialogSize: Size(300.w, 500.h),
                searchDecoration: InputDecoration(
                  hintText: 'Search country...',
                  hintStyle: context.textTheme.bodyMedium?.copyWith(color: AppColors.textGray),
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

            SizedBox(height: 32.h),

            // Feature List
            Text(
              'Features Included:',
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
            SizedBox(height: 16.h),

            ...const [
              '🏳️ Real country flags',
              '📞 Country dial codes (+880, +1, etc.)',
              '🔍 Search functionality',
              '⭐ Favorite countries',
              '🌍 240+ countries supported',
              '🗣️ 70+ languages supported',
              '📱 Mobile-optimized design',
              '♿ Accessibility support',
            ].map(
              (feature) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [Text(feature, style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textDark))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
