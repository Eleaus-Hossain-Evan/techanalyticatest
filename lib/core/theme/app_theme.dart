import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/extensions/extensions.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // primaryColor: AppColors.primary,
    colorScheme: SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      // Primary key color is required, like seed color in ColorScheme.fromSeed.
      primaryKey: AppColors.primary,
      // You can add optional key colors as seeds for secondary and tertiary colors.
      secondaryKey: AppColors.secondary,
      // Tone chroma config and tone mapping is optional, if you do not add it
      // you get the config matching Flutter's Material 3 ColorScheme.fromSeed.
      tones: FlexTones.vivid(Brightness.light),
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: GoogleFonts.poppinsTextTheme(),
    filledButtonTheme: _filledButtonTheme,
    textButtonTheme: _textButtonThemeData,
    outlinedButtonTheme: _outlinedButtonThemeData,
    buttonTheme: _buttonThemeData,
    appBarTheme: _appBarThemeData,
    cardTheme: _cardThemeData,
    tabBarTheme: _tabBarThemeData,
    bottomSheetTheme: _bottomSheetThemeData,
    inputDecorationTheme: _inputDecorationTheme,
    navigationBarTheme: _navigationBarTheme,
    badgeTheme: _badgeTheme,
  );

  static BadgeThemeData get _badgeTheme => BadgeThemeData(
    backgroundColor: AppColors.primary.darken(20),
    textStyle: TextStyle(color: AppColors.white, fontSize: 10.sp, fontWeight: FontWeight.w600),
  );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    // filled: true,
    // fillColor: AppColors.white,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    labelStyle: TextStyle(color: AppColors.black.withOpacity(.38), fontSize: 14.sp, fontWeight: FontWeight.w500),
    hintStyle: TextStyle(color: AppColors.black.withOpacity(.38), fontSize: 14.sp, fontWeight: FontWeight.w500),
    floatingLabelStyle: TextStyle(fontWeight: FontWeight.w700),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColors.border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColors.primary, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: AppColors.primary.withOpacity(.1), width: 1),
    ),
  );

  static AppBarTheme get _appBarThemeData =>
      const AppBarTheme(backgroundColor: AppColors.white, elevation: 4, surfaceTintColor: AppColors.white);

  static FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primary,
      maximumSize: Size.fromHeight(48.h),
      fixedSize: Size.fromHeight(48.h),
      minimumSize: Size.fromHeight(48.h),
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
      textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, fontFamily: GoogleFonts.poppins().fontFamily),
    ),
  );
  static ButtonThemeData get _buttonThemeData => ButtonThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    buttonColor: AppColors.primary,
    shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
    minWidth: double.infinity,
    height: 48.h,
    textTheme: ButtonTextTheme.primary,
  );

  static TextButtonThemeData get _textButtonThemeData => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
    ),
  );
  static OutlinedButtonThemeData get _outlinedButtonThemeData => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      maximumSize: Size.fromHeight(48.h),
      fixedSize: Size.fromHeight(48.h),
      minimumSize: Size.fromHeight(48.h),
      shape: RoundedRectangleBorder(borderRadius: kButtonBorderRadius),
      side: BorderSide(color: AppColors.primary.withOpacity(.1), width: 1.2),
      textStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.normal),
    ),
  );

  static CardThemeData get _cardThemeData => CardThemeData(
    elevation: 2,
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  );

  static TabBarThemeData get _tabBarThemeData => TabBarThemeData(
    labelColor: AppColors.primary,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
    unselectedLabelColor: AppColors.textGray.lighten(15),
  );

  static BottomSheetThemeData get _bottomSheetThemeData => BottomSheetThemeData(
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    showDragHandle: true,
  );

  static NavigationBarThemeData get _navigationBarTheme => NavigationBarThemeData(
    elevation: 4,
    iconTheme: WidgetStateProperty.fromMap({
      WidgetState.selected: IconThemeData(color: AppColors.primary),
      WidgetState.any: IconThemeData(color: AppColors.textGray),
    }),
    labelTextStyle: WidgetStateProperty.fromMap({
      WidgetState.selected: TextStyle(color: AppColors.primary, fontSize: 12.sp, fontWeight: FontWeight.w700),
      WidgetState.any: TextStyle(color: AppColors.textGray, fontSize: 12.sp, fontWeight: FontWeight.w500),
    }),
  );

  static final kButtonBorderRadius = BorderRadius.circular(12);
}
