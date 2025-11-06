// lib/core/utils/app_text.dart
import 'package:flutter/material.dart';
import 'package:gitview/core/utils/responsive.dart';

class AppText {
  final BuildContext context;

  AppText._(this.context);

  factory AppText.of(BuildContext context) => AppText._(context);

  TextTheme get textTheme => Theme.of(context).textTheme;

  // BODY
  TextStyle bodySmall({Color? color, FontWeight? weight}) =>
      textTheme.bodySmall!.copyWith(
        fontSize: context.responsive.fontSize(12),
        color: color ?? textTheme.bodySmall?.color,
        fontWeight: weight,
      );

  TextStyle bodyMedium({Color? color, FontWeight? weight}) =>
      textTheme.bodyMedium!.copyWith(
        fontSize: context.responsive.fontSize(14),
        color: color ?? textTheme.bodyMedium?.color,
        fontWeight: weight,
      );

  TextStyle bodyLarge({Color? color, FontWeight? weight}) =>
      textTheme.bodyLarge!.copyWith(
        fontSize: context.responsive.fontSize(16),
        color: color ?? textTheme.bodyLarge?.color,
        fontWeight: weight,
      );

  // TITLES
  TextStyle titleSmall({Color? color, FontWeight? weight}) =>
      textTheme.titleSmall!.copyWith(
        fontSize: context.responsive.fontSize(18),
        color: color ?? textTheme.titleSmall?.color,
        fontWeight: weight ?? FontWeight.w600,
      );

  TextStyle titleMedium({Color? color, FontWeight? weight}) =>
      textTheme.titleMedium!.copyWith(
        fontSize: context.responsive.fontSize(20),
        color: color ?? textTheme.titleMedium?.color,
        fontWeight: weight ?? FontWeight.w700,
      );

  TextStyle titleLarge({Color? color, FontWeight? weight}) =>
      textTheme.titleLarge!.copyWith(
        fontSize: context.responsive.fontSize(24),
        color: color ?? textTheme.titleLarge?.color,
        fontWeight: weight ?? FontWeight.bold,
      );

  // BUTTON
  TextStyle button({
    Color? color,
    double? size,
    FontWeight? weight,
    double? spacing,
  }) => textTheme.labelLarge!.copyWith(
    fontSize: context.responsive.fontSize(size ?? 16),
    color: color ?? textTheme.labelLarge?.color,
    fontWeight: weight ?? FontWeight.w600,
    letterSpacing: spacing ?? 0.3,
  );

  // HEADINGS
  TextStyle heading1({Color? color}) => textTheme.headlineMedium!.copyWith(
    fontSize: context.responsive.fontSize(28),
    color: color ?? textTheme.headlineMedium?.color,
    fontWeight: FontWeight.bold,
  );

  TextStyle heading2({Color? color}) => textTheme.headlineSmall!.copyWith(
    fontSize: context.responsive.fontSize(22),
    color: color ?? textTheme.headlineSmall?.color,
    fontWeight: FontWeight.w600,
  );

  // CAPTION
  TextStyle caption({Color? color}) => textTheme.bodySmall!.copyWith(
    fontSize: context.responsive.fontSize(11),
    color: color ?? textTheme.bodySmall?.color?.withOpacity(0.7),
  );
}

extension AppTextExtension on BuildContext {
  AppText get appText => AppText.of(this);
}