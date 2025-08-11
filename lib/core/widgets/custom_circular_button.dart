import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A circular button widget for icon-only actions
///
/// Example usage:
/// ```dart
/// CustomCircularButton(
///   icon: Icon(Icons.add),
///   onPressed: () => print('Add pressed'),
/// )
///
/// CustomCircularButton(
///   icon: Icon(Icons.close),
///   radius: 30,
///   backgroundColor: Colors.red,
///   onPressed: () => print('Close pressed'),
/// )
/// ```
class CustomCircularButton extends StatelessWidget {
  /// The icon to display in the button
  final Widget icon;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// The radius of the circular button
  final double radius;

  /// Background color of the button
  final Color? backgroundColor;

  /// Foreground color (icon color)
  final Color? foregroundColor;

  /// Elevation of the button
  final double elevation;

  /// Whether the button should have a splash effect
  final bool enableSplash;

  const CustomCircularButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.radius = 24,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 2,
    this.enableSplash = true,
  });

  @override
  Widget build(BuildContext context) {
    if (enableSplash) {
      return Material(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(_getRadius()),
        elevation: elevation,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(_getRadius()),
          child: Container(
            width: _getRadius() * 2,
            height: _getRadius() * 2,
            alignment: Alignment.center,
            child: IconTheme(
              data: IconThemeData(color: foregroundColor ?? Colors.white),
              child: icon,
            ),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: _getRadius(),
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      foregroundColor: foregroundColor ?? Colors.white,
      child: IconButton(onPressed: onPressed, icon: icon, color: foregroundColor ?? Colors.white),
    );
  }

  double _getRadius() {
    try {
      return radius.r;
    } catch (e) {
      return radius;
    }
  }
}
