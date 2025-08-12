import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

/// Button type variants
enum AppButtonType { filled, outlined, elevated, text }

/// Button color variants for semantic styling
enum AppButtonVariant {
  primary, // Default emerald colors
  secondary, // Gray colors
  destructive, // Red colors
  success, // Green colors
}

/// A universal button widget that replaces all button types in the app
///
/// This widget can handle filled, outlined, elevated, and text buttons
/// with comprehensive customization options and built-in loading states.
///
/// Example usage:
/// ```dart
/// // Basic filled button (default)
/// CustomButton(
///   text: 'Sign In',
///   onPressed: () => print('Pressed'),
/// )
///
/// // Outlined button with icon
/// CustomButton(
///   text: 'Cancel',
///   type: AppButtonType.outlined,
///   leadingIcon: Icon(Icons.close),
///   onPressed: () => print('Cancel'),
/// )
///
/// // Destructive action
/// CustomButton(
///   text: 'Delete Account',
///   variant: AppButtonVariant.destructive,
///   isLoading: isDeleting,
///   onPressed: () => deleteAccount(),
/// )
///
/// // Text button with loading
/// CustomButton(
///   text: 'Skip',
///   type: AppButtonType.text,
///   isLoading: isSkipping,
///   loadingText: 'Skipping...',
///   onPressed: () => skip(),
/// )
/// ```
class CustomButton extends StatelessWidget {
  // Core functionality
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  // Button type and variant
  final AppButtonType type;
  final AppButtonVariant variant;

  // Icons
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  // Layout
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  // Styling overrides
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final BorderSide? borderSide;

  // Loading customization
  final Color? loadingColor;
  final double? loadingSize;
  final String? loadingText; // Different text during loading

  // Advanced customization
  final Widget? child; // Override everything
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.type = AppButtonType.filled,
    this.variant = AppButtonVariant.primary,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.borderSide,
    this.loadingColor,
    this.loadingSize,
    this.loadingText,
    this.child,
    this.textStyle,
    this.focusNode,
  });

  /// Creates a primary filled button (default)
  static CustomButton primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? leadingIcon,
    Widget? trailingIcon,
    double? width,
    double? height,
    String? loadingText,
  }) => CustomButton(
    key: key,
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    width: width,
    height: height,
    loadingText: loadingText,
  );

  /// Creates an outlined button
  static CustomButton outlined({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    AppButtonVariant variant = AppButtonVariant.primary,
    Widget? leadingIcon,
    Widget? trailingIcon,
    double? width,
    double? height,
    String? loadingText,
  }) => CustomButton(
    key: key,
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    type: AppButtonType.outlined,
    variant: variant,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    width: width,
    height: height,
    loadingText: loadingText,
  );

  /// Creates a text button
  static CustomButton textButton({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    AppButtonVariant variant = AppButtonVariant.primary,
    Widget? leadingIcon,
    Widget? trailingIcon,
    String? loadingText,
  }) => CustomButton(
    key: key,
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    type: AppButtonType.text,
    variant: variant,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    loadingText: loadingText,
  );

  /// Creates an elevated button
  static CustomButton elevated({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    AppButtonVariant variant = AppButtonVariant.primary,
    Widget? leadingIcon,
    Widget? trailingIcon,
    double? width,
    double? height,
    String? loadingText,
  }) => CustomButton(
    key: key,
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    type: AppButtonType.elevated,
    variant: variant,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    width: width,
    height: height,
    loadingText: loadingText,
  );

  /// Creates a destructive action button
  static CustomButton destructive({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    AppButtonType type = AppButtonType.filled,
    Widget? leadingIcon,
    String? loadingText,
  }) => CustomButton(
    key: key,
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    type: type,
    variant: AppButtonVariant.destructive,
    leadingIcon: leadingIcon,
    loadingText: loadingText,
  );

  @override
  Widget build(BuildContext context) {
    // Text buttons should size to content by default, not take full width
    final defaultWidth = type == AppButtonType.text ? null : double.infinity;
    return SizedBox(width: width ?? defaultWidth, height: height, child: _buildButton(context));
  }

  Widget _buildButton(BuildContext context) {
    final buttonChild = _buildChild(context);
    final buttonStyle = _buildButtonStyle(context);

    switch (type) {
      case AppButtonType.filled:
        return FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          focusNode: focusNode,
          child: buttonChild,
        );

      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          focusNode: focusNode,
          child: buttonChild,
        );

      case AppButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          focusNode: focusNode,
          child: buttonChild,
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          focusNode: focusNode,
          child: buttonChild,
        );
    }
  }

  ButtonStyle? _buildButtonStyle(BuildContext context) {
    final colors = _getVariantColors(context);
    final defaultBorderRadius = _getDefaultBorderRadius();

    switch (type) {
      case AppButtonType.filled:
        return FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? colors.background,
          foregroundColor: foregroundColor ?? colors.foreground,
          padding: padding,
          elevation: elevation,
          shape: borderRadius != null
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
          textStyle: textStyle,
        );

      case AppButtonType.outlined:
        return OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor ?? colors.foreground,
          padding: padding,
          elevation: elevation ?? 0,
          side: borderSide ?? BorderSide(color: colors.foreground),
          shape: borderRadius != null
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
          textStyle: textStyle,
        );

      case AppButtonType.elevated:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colors.background,
          foregroundColor: foregroundColor ?? colors.foreground,
          padding: padding,
          elevation: elevation ?? 2,
          shape: borderRadius != null
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!))
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
          textStyle: textStyle,
        );

      case AppButtonType.text:
        return TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor ?? colors.foreground,
          padding: padding,
          elevation: elevation ?? 0,
          shape: borderRadius != null
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!))
              : null,
          textStyle: textStyle,
        );
    }
  }

  Widget _buildChild(BuildContext context) {
    if (child != null) return child!;

    if (isLoading) {
      return _buildLoadingChild();
    }

    return _buildNormalChild();
  }

  Widget _buildLoadingChild() {
    final loadingIndicator = SizedBox(
      height: loadingSize ?? _getDefaultLoadingSize(),
      width: loadingSize ?? _getDefaultLoadingSize(),
      child: CircularProgressIndicator(color: loadingColor ?? _getLoadingColor(), strokeWidth: 2),
    );

    if (loadingText != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loadingIndicator,
          SizedBox(width: _getIconSpacing()),
          Text(loadingText!),
        ],
      );
    }

    return loadingIndicator;
  }

  Widget _buildNormalChild() {
    final textWidget = Text(text);

    if (leadingIcon == null && trailingIcon == null) {
      return textWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[leadingIcon!, SizedBox(width: _getIconSpacing())],
        Flexible(child: textWidget),
        if (trailingIcon != null) ...[SizedBox(width: _getIconSpacing()), trailingIcon!],
      ],
    );
  }

  ({Color background, Color foreground}) _getVariantColors(BuildContext context) {
    switch (variant) {
      case AppButtonVariant.primary:
        return (
          background: AppColors.primary,
          foreground: type == AppButtonType.outlined || type == AppButtonType.text
              ? AppColors.primary
              : AppColors.white,
        );

      case AppButtonVariant.secondary:
        return (
          background: AppColors.textGray,
          foreground: type == AppButtonType.outlined || type == AppButtonType.text
              ? AppColors.textGray
              : AppColors.white,
        );

      case AppButtonVariant.destructive:
        return (
          background: AppColors.error,
          foreground: type == AppButtonType.outlined || type == AppButtonType.text ? AppColors.error : AppColors.white,
        );

      case AppButtonVariant.success:
        return (
          background: AppColors.primary,
          foreground: type == AppButtonType.outlined || type == AppButtonType.text
              ? AppColors.primary
              : AppColors.white,
        );
    }
  }

  Color _getLoadingColor() {
    switch (variant) {
      case AppButtonVariant.primary:
        return type == AppButtonType.outlined || type == AppButtonType.text ? AppColors.primary : AppColors.white;
      case AppButtonVariant.secondary:
        return type == AppButtonType.outlined || type == AppButtonType.text ? AppColors.textGray : AppColors.white;
      case AppButtonVariant.destructive:
        return type == AppButtonType.outlined || type == AppButtonType.text ? AppColors.error : AppColors.white;
      case AppButtonVariant.success:
        return type == AppButtonType.outlined || type == AppButtonType.text ? AppColors.primary : AppColors.white;
    }
  }

  double _getDefaultBorderRadius() {
    try {
      return 12.r; // From theme
    } catch (e) {
      return 12.0;
    }
  }

  double _getDefaultLoadingSize() {
    try {
      return 20.h;
    } catch (e) {
      return 20.0;
    }
  }

  double _getIconSpacing() {
    try {
      return 8.w;
    } catch (e) {
      return 8.0;
    }
  }
}
