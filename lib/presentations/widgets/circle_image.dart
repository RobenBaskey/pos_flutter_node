import 'package:flutter/material.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.path,
    this.height = 40,
    this.width = 40,
  });
  final String path;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: CustomImage(path: path, height: height, width: width),
    );
  }
}
