import 'package:design_system/foundation/colors.dart';
import 'package:design_system/foundation/typography.dart';
import 'package:flutter/material.dart';

class DistroElevatedButton extends StatelessWidget {
  final DistroButtonSize size;
  final Widget label;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPressed;
  final DistroButtonColors colors;
  final bool enabled;
  final bool fullWidth;
  final bool loading;
  final double? width;

  const DistroElevatedButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.size = DistroButtonSize.medium,
      this.leftIcon,
      this.rightIcon,
      this.colors = DistroButtonDefaults.elevatedColors,
      this.enabled = true,
      this.fullWidth = false,
      this.loading = false,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent, width: 0),
              foregroundColor: colors.foregroundColor,
              backgroundColor: colors.backgroundColor,
              disabledForegroundColor: colors.disabledForegroundColor,
              disabledBackgroundColor: colors.disabledBackgroundColor,
              textStyle: size.textStyle,
              minimumSize: Size(fullWidth ? double.infinity : 0, size.height),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          onPressed: enabled && !loading ? onPressed : null,
          child: Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null && !loading) leftIcon!,
              Visibility(
                  visible: loading,
                  child: const CircularProgressIndicator(color: DistroColors.primary_500,)),
              if (leftIcon != null || loading) const SizedBox(width: 8),
              Visibility(
                visible: !loading,
                replacement: Text(
                  'Memuat...',
                  style: size.textStyle,
                ),
                child: label,
              ),
              if (rightIcon != null) const SizedBox(width: 8),
              if (rightIcon != null && !loading) rightIcon!,
            ],
          )),
    );
  }
}

class DistroOutlineButton extends StatelessWidget {
  final DistroButtonSize size;
  final Widget label;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPressed;
  final DistroButtonColors colors;
  final bool enabled;
  final bool fullWidth;
  final bool loading;
  final double? width;

  const DistroOutlineButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.size = DistroButtonSize.medium,
      this.leftIcon,
      this.rightIcon,
      this.colors = DistroButtonDefaults.outlineColors,
      this.enabled = true,
      this.fullWidth = false,
      this.loading = false,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: DistroColors.tertiary_300, width: 1),
              foregroundColor: colors.foregroundColor,
              backgroundColor: colors.backgroundColor,
              disabledForegroundColor: colors.disabledForegroundColor,
              disabledBackgroundColor: colors.disabledBackgroundColor,
              textStyle: size.textStyle,
              minimumSize: Size(fullWidth ? double.infinity : 0, size.height),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: const BorderSide(color: DistroColors.tertiary_200))),
          onPressed: enabled && !loading ? onPressed : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null && !loading) leftIcon!,
              if (leftIcon != null && !loading) leftIcon!,
              Visibility(
                  visible: loading,
                  child: const CircularProgressIndicator(color: DistroColors.primary_500,)),
              if (leftIcon != null || loading) const SizedBox(width: 8),
              Visibility(
                visible: !loading,
                replacement: Text(
                  'Memuat...',
                  style: size.textStyle,
                ),
                child: label,
              ),
              if (rightIcon != null) const SizedBox(width: 8),
              if (rightIcon != null && !loading) rightIcon!,
            ],
          )),
    );
  }
}

class DistroButtonDefaults {
  static const height = 40.0;

  static const outlineColors = DistroButtonColors(
    foregroundColor: DistroColors.primary_500,
    backgroundColor: DistroColors.white,
    disabledForegroundColor: DistroColors.tertiary_400,
    disabledBackgroundColor: DistroColors.white,
  );

  // static final outlineColorsTheme = DistroButtonTheme(
  //   primary: DistroButtonColors.outlineColors(color: DistroColors.primary_500),
  //   secondary: DistroButtonColors.outlineColors(color: DistroColors.secondary_500),
  //   success: DistroButtonColors.outlineColors(color: DistroColors.success_500),
  //   warning: DistroButtonColors.outlineColors(color: DistroColors.warning_500),
  //   error: DistroButtonColors.outlineColors(color: DistroColors.error_500),
  //   info: DistroButtonColors.outlineColors(color: DistroColors.information_500),
  // );

  static const elevatedColors = DistroButtonColors(
    foregroundColor: DistroColors.white,
    backgroundColor: DistroColors.primary_500,
    disabledForegroundColor: DistroColors.tertiary_400,
    disabledBackgroundColor: DistroColors.tertiary_200,
  );

  // static final elevatedColorsTheme = DistroButtonTheme(
  //   primary: DistroButtonColors.elevatedColors(color: DistroColors.primary_500),
  //   secondary: DistroButtonColors.elevatedColors(color: DistroColors.secondary_500),
  //   success: DistroButtonColors.elevatedColors(color: DistroColors.success_600),
  //   warning: DistroButtonColors.elevatedColors(color: DistroColors.warning_500),
  //   error: DistroButtonColors.elevatedColors(color: DistroColors.error_500),
  //   info: DistroButtonColors.elevatedColors(color: DistroColors.information_500),
  // );

  // static const softColors = DistroButtonColors(
  //   foregroundColor: DistroColors.primary_600,
  //   backgroundColor: DistroColors.primary_25,
  //   disabledForegroundColor: DistroColors.tertiary_400,
  //   disabledBackgroundColor: DistroColors.tertiary_200,
  // );

  // static final softColorsTheme = DistroButtonTheme(
  //   primary: DistroButtonColors.softColors(
  //       foregroundColor: DistroColors.primary_600,
  //       backgroundColor: DistroColors.primary_25),
  //   secondary: DistroButtonColors.softColors(
  //       foregroundColor: DistroColors.secondary_600,
  //       backgroundColor: DistroColors.secondary_25),
  //   success: DistroButtonColors.softColors(
  //       foregroundColor: DistroColors.success_600,
  //       backgroundColor: DistroColors.success_25),
  //   warning: DistroButtonColors.softColors(
  //       foregroundColor: DistroColors.warning_600,
  //       backgroundColor: DistroColors.warning_25),
  //   error: DistroButtonColors.softColors(
  //       foregroundColor: DistroColors.error_600,
  //       backgroundColor: DistroColors.error_25),
  //   info: DistroButtonColors.softColors(
  //       foregroundColor: DistroColors.information_600,
  //       backgroundColor: DistroColors.information_25),
  // );

  static const textColors = DistroButtonColors(
    foregroundColor: DistroColors.primary_500,
    backgroundColor: Colors.transparent,
    disabledForegroundColor: DistroColors.tertiary_400,
    disabledBackgroundColor: Colors.transparent,
  );

  // static final textColorsTheme = DistroButtonTheme(
  //   primary: DistroButtonColors.textColors(color: DistroColors.primary_500),
  //   secondary: DistroButtonColors.textColors(color: DistroColors.secondary_500),
  //   success: DistroButtonColors.textColors(color: DistroColors.success_500),
  //   warning: DistroButtonColors.textColors(color: DistroColors.warning_500),
  //   error: DistroButtonColors.textColors(color: DistroColors.error_500),
  //   info: DistroButtonColors.textColors(color: DistroColors.information_500),
  // );
}

class DistroButtonColors {
  final Color foregroundColor;
  final Color backgroundColor;
  final Color disabledForegroundColor;
  final Color disabledBackgroundColor;

  const DistroButtonColors({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.disabledForegroundColor,
    required this.disabledBackgroundColor,
  });

  Color getForegroundColor(bool enabled) {
    return enabled ? foregroundColor : disabledForegroundColor;
  }

  static DistroButtonColors elevatedColors(
      {Color color = DistroColors.primary_500}) {
    return DistroButtonColors(
      foregroundColor: DistroColors.white,
      backgroundColor: color,
      disabledForegroundColor: DistroColors.tertiary_400,
      disabledBackgroundColor: DistroColors.tertiary_200,
    );
  }

  static DistroButtonColors outlineColors(
      {Color color = DistroColors.primary_500}) {
    return DistroButtonColors(
      foregroundColor: color,
      backgroundColor: DistroColors.white,
      disabledForegroundColor: DistroColors.tertiary_400,
      disabledBackgroundColor: DistroColors.white,
    );
  }

  static DistroButtonColors textColors({Color color = DistroColors.primary_500}) {
    return DistroButtonColors(
      foregroundColor: color,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: DistroColors.tertiary_400,
      disabledBackgroundColor: Colors.transparent,
    );
  }
}

enum DistroButtonSize {
  small,
  medium,
  large,
}

extension DistroButtonSizeExt on DistroButtonSize {
  double get height {
    switch (this) {
      case DistroButtonSize.small:
        return 32.0;
      case DistroButtonSize.medium:
        return 40.0;
      case DistroButtonSize.large:
        return 52.0;
      default:
        return 40.0;
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case DistroButtonSize.small:
        return DistroTypography.captionLargeBold;
      case DistroButtonSize.medium:
        return DistroTypography.bodySmallBold;
      case DistroButtonSize.large:
        return DistroTypography.bodyLargeBold;
      default:
        return DistroTypography.bodySmallBold;
    }
  }
}