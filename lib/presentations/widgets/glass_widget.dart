import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/theme/theme_controller.dart';

class GlassWidget extends StatelessWidget {
  final Widget child;
  final double padding;
  final EdgeInsetsGeometry? pd;
  final double borderRadius;
  final BorderRadius? br;
  final Color? color;
  final Color? borderColor;

  ThemeController get theme => Get.find();

  const GlassWidget({
    super.key,
    required this.child,
    this.padding = 14.0,
    this.pd,
    this.borderRadius = 14.0,
    this.br,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: br ?? BorderRadius.circular(borderRadius), // 2.5rem
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          padding: pd ?? EdgeInsets.all(padding),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Theme.of(context).colorScheme.outline,
            ),
            color: color ?? Theme.of(context).colorScheme.surface,
            borderRadius: br ?? BorderRadius.circular(borderRadius),
            boxShadow: [BoxShadow()],
          ),
          child: child,
        ),
      ),
    );
  }
}
