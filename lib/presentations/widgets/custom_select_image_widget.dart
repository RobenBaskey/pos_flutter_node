import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/presentations/widgets/image_viewer.dart';

class CustomSelectImageWidget extends StatelessWidget {
  const CustomSelectImageWidget({
    super.key,
    required this.onTap,
    required this.onRemove,
    this.selectedImage,
    this.path,
  });
  final Function() onTap;
  final Function() onRemove;
  final PlatformFile? selectedImage;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).primaryTextTheme.labelMedium?.color,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.image, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
        ),
        if (selectedImage != null || path != null) ...[
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Utils.showCustomDialog(
                context: context,
                alignment: Alignment.center,
                child: ImageViewer(path: path, bytes: selectedImage?.bytes),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedImage != null
                            ? selectedImage!.name
                            : path ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(
                            context,
                          ).primaryTextTheme.labelMedium?.color,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: onRemove,
                      icon: Icon(Icons.delete, size: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
