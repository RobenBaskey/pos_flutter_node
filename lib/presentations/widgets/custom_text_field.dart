import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/theme_controller.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final double? borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final double? width;
  final double? contentPadding;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? isEnabled;
  final bool isReadOnly;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? hintColor;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obsecure;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final bool isSuffixIconConstrained;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final double? scrollPadding;
  final bool readOnly;
  final Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.scrollPadding,
    this.borderRadius = 20.0,
    this.paddingVertical = 16,
    this.paddingHorizontal = 16.0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.filled = true,
    this.fillColor,
    this.borderColor,
    this.width,
    this.contentPadding,
    this.onChanged,
    this.onTap,
    this.controller,
    this.isEnabled,
    this.isReadOnly = false,
    this.inputType,
    this.inputAction,
    this.hintColor,
    this.textColor = Colors.white,
    this.inputFormatter,
    this.prefixIcon,
    this.suffixIcon,
    this.obsecure,
    this.shadowColor,
    this.shadowOffset,
    this.textAlign,
    this.isSuffixIconConstrained = false,
    this.maxLines,
    this.focusNode,
    this.maxLength,
    this.readOnly = false,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: inputType,
      focusNode: focusNode,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      scrollPadding: scrollPadding != null
          ? EdgeInsets.only(bottom: scrollPadding ?? 40)
          : EdgeInsets.zero,
      textAlign: textAlign ?? TextAlign.start,
      obscureText: obsecure ?? false,
      inputFormatters: inputFormatter,
      maxLength: maxLength,
      onSubmitted: onSubmitted,
      style: TextStyle(color: textColor),
      textInputAction: inputAction ?? TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: "",
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: fillColor != null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        fillColor:
            fillColor ??
            (Get.find<ThemeController>().isDarkMode.value
                ? AppColors.darkBackground
                : Colors.white.withValues(alpha: 0.9)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: TextStyle(
          color:
              hintColor ??
              Theme.of(context).inputDecorationTheme.hintStyle?.color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
