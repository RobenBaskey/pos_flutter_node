import 'package:flutter/material.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../core/theme/app_colors.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.path, this.isFile = false});
  final String? path;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 800,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Center(child: CustomImage(path: path, isFile: isFile, fit: BoxFit.contain)),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
