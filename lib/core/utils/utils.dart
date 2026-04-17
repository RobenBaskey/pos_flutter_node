import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/data/datasource/local_db/shared_preference_service.dart';

import '../../presentations/widgets/custom_button.dart';
import '../constants/enum.dart';
import '../theme/app_colors.dart';

class Utils {
  static String getToken() {
    return Get.find<SharedPreferenceService>().getToken();
  }

  static void customPrint(dynamic value, {String tag = ""}) {
    try {
      var decodeJson = json.decode(value.toString()) as Map<String, dynamic>;
      log(
        "JSON OUTPUT: $tag ${const JsonEncoder.withIndent('  ').convert(decodeJson)}\n",
      );
    } catch (e) {
      if (value is Map) {
        log(
          "JSON OUTPUT: $tag ${const JsonEncoder.withIndent('  ').convert(value)}\n",
        );
      } else {
        if (kDebugMode) {
          print("PRINT OUTPUT: $tag $value\n\n");
        }
      }
    }
  }

  static void showSnackBar(
    String message, {
    String title = "Warning",
    SnackBarType type = SnackBarType.warning,
    bool isDismissible = true,
    bool isSuccess = false,
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;

    if (isSuccess) {
      backgroundColor = Colors.green.shade600;
    } else {
      switch (type) {
        case SnackBarType.error:
          backgroundColor = Colors.red.shade600;
          break;
        case SnackBarType.warning:
          backgroundColor = Colors.orange.shade600;
          break;
        case SnackBarType.success:
          backgroundColor = Colors.green.shade600;
          break;
      }
    }

    Get.snackbar(
      isSuccess ? "Success" : title,
      message,
      maxWidth: 400,
      margin: const EdgeInsets.all(16),
      backgroundColor: backgroundColor,
      colorText: textColor,
      isDismissible: isDismissible,
      duration: Duration(seconds: isDismissible ? 3 : 300),

      // Dismiss button
      mainButton: !isDismissible
          ? TextButton(
              onPressed: () => Get.closeCurrentSnackbar(),
              child: const Text(
                "Dismiss",
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    required Widget child,
    Alignment? alignment,
    bool? isDissmissable,
    bool? isFromCenter,
    bool? isFromRight,
    Color? bearerColor,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: isDissmissable ?? true,
      barrierColor: bearerColor ?? Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: alignment ?? Alignment.bottomCenter,
          child: child,
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(
            begin: alignment == Alignment.topCenter
                ? Offset(0, -1)
                : isFromRight == true
                ? Offset(1, 0)
                : Offset(0, isFromCenter == true ? 0 : 1),
            end: Offset.zero,
          );
        } else {
          tween = Tween(
            begin: alignment == Alignment.topCenter
                ? Offset(0, -1)
                : isFromRight == true
                ? Offset(1, 0)
                : Offset(0, isFromCenter == true ? 0 : 1),
            end: Offset.zero,
          );
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }

  static Future<File?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } on Exception catch (e) {
      debugPrint("Error picking image: $e");
      return null;
    }
  }

  static void showDeleteDialog(
    BuildContext context, {
    required Function() onYesTap,
    required RxBool isLoading,
    required String title,
    required String description,
  }) {
    Utils.showCustomDialog(
      context: context,
      alignment: Alignment.center,
      bearerColor: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
      child: SizedBox(
        width: 280,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: "Cancel",
                      verticalPadding: 12,
                      horizontalPadding: 20,
                      borderRadius: 8,
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.2),
                    ),
                    SizedBox(width: 10),
                    Obx(
                      () => CustomButton(
                        onTap: onYesTap,
                        isLoading: isLoading.value,
                        title: "Delete",
                        verticalPadding: 12,
                        horizontalPadding: 20,
                        borderRadius: 8,
                        color: AppColors.warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
