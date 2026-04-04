import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.height,
    this.width,
    this.child,
    this.color,
  });

  final double height;
  final double? width;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? Colors.grey.withValues(alpha: 0.07),
      highlightColor: color ?? Colors.grey.withValues(alpha: 0.02),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
