import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../core.dart';

class CustomTextFormField extends HookConsumerWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.textAlign = TextAlign.start,
    this.suffixIcon,
    this.suffix,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.initialBorderColor,
    this.hintTextStyle,
    this.autofocus = false,
    this.focusBorderWidth = 2,
    this.inputFormatters,
    this.suffixText,
  });

  final TextEditingController? controller;
  final String? hintText, labelText;
  final TextAlign textAlign;
  final Widget? suffixIcon, suffix;
  final bool readOnly, enabled;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool isObscure;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged, onFieldSubmitted;
  final int? maxLines;
  final EdgeInsets? contentPadding;
  final Color? fillColor, borderColor, initialBorderColor;
  final TextStyle? hintTextStyle;
  final bool autofocus;
  final double focusBorderWidth;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var inputTheme = context.theme.inputDecorationTheme;
    final hideText = useState(true);
    final haveText = useState<bool>(false);

    final border = OutlineInputBorder(borderSide: BorderSide(color: initialBorderColor ?? AppColors.border, width: 1));

    final focusBorder = border.copyWith(
      borderSide: BorderSide(color: borderColor ?? inputTheme.focusedBorder!.borderSide.color, width: focusBorderWidth),
    );

    final levelStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.black);

    return TextFormField(
      obscureText: isObscure ? hideText.value : false,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: levelStyle.copyWith(color: AppColors.black),
      textAlign: textAlign,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      // expands: true,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textGray,
          fontWeight: FontWeight.normal,
          letterSpacing: .1,
        ),
        labelText: labelText,
        labelStyle: levelStyle.colorSet(AppColors.textGray),
        floatingLabelStyle: levelStyle.colorPrimary().letterSpace(1).bold,
        alignLabelWithHint: true,
        // contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 12.h),
        border: border,
        enabledBorder: haveText.value ? focusBorder : border,
        focusedBorder: focusBorder,
        disabledBorder: border.copyWith(borderSide: const BorderSide(color: Colors.transparent)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: context.color.error)),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: context.color.error, width: focusBorderWidth),
        ),
        fillColor: fillColor,
        filled: false,
        isDense: false,
        focusColor: AppColors.primary,
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixIcon:
            suffixIcon ??
            (isObscure
                ? IconButton(
                    // borderRadius: BorderRadius.circular(24.r),
                    onPressed: () {
                      hideText.value = !hideText.value;
                    },
                    icon: hideText.value ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined),
                  )
                : null),
        suffix: suffix,
        suffixIconColor: AppColors.primary,
      ),
      onTap: onTap,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (value) {
        onChanged?.call(value);
        haveText.value = value.isNotEmpty;
      },
      onTapOutside: (details) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  factory CustomTextFormField.date({
    Key? key,
    String datePattern = 'MMMM dd, yyyy',
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    TextAlign textAlign = TextAlign.start,
    Widget? suffixIcon,
    bool readOnly = false,
    bool enabled = true,
    void Function()? onTap,
    Widget? prefixIcon,
    String? Function(String?)? validator,
    FocusNode? focusNode,
    bool isObscure = false,
    TextInputType keyboardType = TextInputType.text,
    dynamic Function(String)? onChanged,
    dynamic Function(String)? onFieldSubmitted,
    TextInputAction textInputAction = TextInputAction.next,
    int? maxLines = 1,
    EdgeInsets? contentPadding = const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
    Color fillColor = Colors.transparent,
    Color borderColor = AppColors.primary,
    Color? initialBorderColor,
    TextStyle? hintTextStyle,
    bool autofocus = false,
    double borderWidth = 1,
  }) => CustomTextFormField(
    key: key,
    controller: controller,
    keyboardType: TextInputType.datetime,
    hintText: hintText,
    labelText: labelText,
    validator: validator,
    readOnly: true,
    enabled: enabled,
    onTap: () {
      showDatePicker(
        context: AppGlobalKeys.mainNavigatorKey.currentContext!,
        firstDate: DateTime(1950, 1, 1),
        lastDate: DateTime.now(),
      ).then((date) {
        controller?.text = date == null ? '' : DateFormat(datePattern).format(date);
        onChanged?.call(controller?.text ?? '');
      });
    },
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon ?? Icon(Icons.calendar_month, color: Colors.blueGrey.withOpacity(.6)),
    focusNode: focusNode,
    isObscure: isObscure,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    textInputAction: textInputAction,
    maxLines: maxLines,
    contentPadding: contentPadding,
    fillColor: fillColor,
    borderColor: borderColor,
    autofocus: autofocus,
    focusBorderWidth: borderWidth,
    hintTextStyle: hintTextStyle,
    initialBorderColor: initialBorderColor,
    textAlign: textAlign,
  );
}
