import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/presentations/controller/setting_controller.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_divider.dart';

class AboutUs extends GetView<SettingController> {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final quillController = controller.selectedQuillController;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuillSimpleToolbar(
            controller: quillController,
            config: const QuillSimpleToolbarConfig(),
          ),
          CustomDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              child: QuillEditor.basic(
                controller: quillController,
                config: const QuillEditorConfig(
                  showCursor: true,
                  placeholder: "Add your content",
                ),
              ),
            ),
          ),
          CustomDivider(),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onTap: () {
                    controller.onPreview(context);
                  },
                  title: "",
                  color: Colors.transparent,
                  horizontalPadding: 30,
                  borderColor: AppColors.primary,
                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye, color: AppColors.primary),
                      SizedBox(width: 12),
                      Text(
                        "PREVIEW",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                CustomButton(
                  onTap: () {
                    controller.onSave();
                  },
                  title: "",
                  horizontalPadding: 40,
                  child: Row(
                    children: [
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 12),
                      Text("SAVE", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
