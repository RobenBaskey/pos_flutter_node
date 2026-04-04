import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';
import 'custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  });

  final String? path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    final imagePath = path == null || path == ""
        ? AppImages.squrePlaceholder
        : path;
    // if (imagePath!.endsWith('.svg')) {
    //   return SizedBox(
    //     height: height,
    //     width: width,
    //     child: SvgPicture.asset(
    //       imagePath,
    //       fit: fit,
    //       height: height,
    //       width: width,
    //     ),
    //   );
    // }

    if (isFile) {
      return Image.file(
        File(imagePath!),
        fit: fit,
        color: color,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return CustomImage(
            path: AppImages.squrePlaceholder,
            fit: BoxFit.cover,
          );
        },
      );
    }
    if (imagePath!.startsWith('http') ||
        imagePath.startsWith('https') ||
        imagePath.startsWith('www.')) {
      try {
        return CachedNetworkImage(
          imageUrl: imagePath,
          fit: fit,
          color: color,
          height: height,
          width: width,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: const Center(child: CustomShimmer(height: 24, width: 24)),
            );
          },
          errorWidget: (context, url, error) => const Image(
            image: AssetImage(AppImages.squrePlaceholder),
            fit: BoxFit.cover,
          ),
        );
      } on Exception {
        return Image(
          image: AssetImage(AppImages.squrePlaceholder),
          fit: BoxFit.cover,
        );
      }
    }

    return Image.asset(
      imagePath,
      fit: fit,
      color: color,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return CustomImage(path: AppImages.squrePlaceholder, fit: BoxFit.cover);
      },
    );
  }
}
