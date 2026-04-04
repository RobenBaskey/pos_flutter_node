import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading,
    this.color,
    this.borderColor,
    this.fontWeight,
    this.fontSize = 14,
    this.titleColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.borderRadius = 8,
    this.child,
    this.letterSpacing,
    this.elevation,
  });
  final String title;
  final Function() onTap;
  final bool? isLoading;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? verticalPadding;
  final Color? titleColor;
  final Color? borderColor;
  final Widget? child;
  final double borderRadius;
  final double? horizontalPadding;
  final double? letterSpacing;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Colors.green,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 20,
          horizontal: horizontalPadding ?? 12,
        ),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        backgroundColor: color ?? AppColors.primary.withValues(alpha: 0.8),
      ),
      child: Center(
        child: isLoading == true
            ? CircularProgressIndicator(color: Colors.white)
            : child ??
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      fontSize: fontSize,
                      letterSpacing: letterSpacing,
                    ),
                  ),
      ),
    );
  }
}
