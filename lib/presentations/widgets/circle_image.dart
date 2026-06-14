import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.path,
    this.height = 40,
    this.width = 40,
    this.bytes,
  });
  final String path;
  final double height, width;
  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: CustomImage(
        path: ApiUrl.getImageBaseUrl() + path,
        height: height,
        width: width,
        bytes: bytes,
      ),
    );
  }
}
