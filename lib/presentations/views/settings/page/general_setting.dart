import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/presentations/controller/setting_controller.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/custom_text_field.dart';

class GeneralSetting extends GetView<SettingController> {
  const GeneralSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              "Company Information",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          CustomDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Comapany Name *"),
                              SizedBox(height: 4),
                              CustomTextField(
                                controller: controller.companyNameController,
                                hintText: "",
                                borderRadius: 8,
                                borderColor: Theme.of(
                                  context,
                                ).colorScheme.outline,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email "),
                              SizedBox(height: 4),
                              CustomTextField(
                                controller: controller.emailController,
                                hintText: "",
                                inputType: TextInputType.emailAddress,
                                borderRadius: 8,
                                borderColor: Theme.of(
                                  context,
                                ).colorScheme.outline,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone *"),
                              SizedBox(height: 4),
                              CustomTextField(
                                controller: controller.phoneController,
                                hintText: "",
                                inputType: TextInputType.phone,
                                borderRadius: 8,
                                borderColor: Theme.of(
                                  context,
                                ).colorScheme.outline,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Address"),
                              SizedBox(height: 4),
                              CustomTextField(
                                controller: controller.addressController,
                                hintText: "",
                                borderRadius: 8,
                                borderColor: Theme.of(
                                  context,
                                ).colorScheme.outline,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description"),
                        SizedBox(height: 4),
                        CustomTextField(
                          controller: controller.descriptionController,
                          hintText: "",
                          maxLines: 4,
                          borderRadius: 8,
                          borderColor: Theme.of(context).colorScheme.outline,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: getWidth(80),
                              width: getWidth(80),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: _SettingImage(path: controller.logo.value),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                TextButton.icon(
                                  onPressed: controller.pickLogo,
                                  label: Text("Change Logo"),
                                  icon: Icon(Icons.upload_outlined),
                                ),
                                SizedBox(width: 10),
                                TextButton.icon(
                                  onPressed: controller.removeLogo,
                                  label: Text(
                                    "Delete Logo",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: getWidth(80),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: _SettingImage(
                                  path: controller.banner.value,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: controller.pickBanner,
                                    label: Text("Change Banner"),
                                    icon: Icon(Icons.upload_outlined),
                                  ),
                                  SizedBox(width: 10),
                                  TextButton.icon(
                                    onPressed: controller.removeBanner,
                                    label: Text(
                                      "Delete Banner",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: getWidth(60),
                        child: CustomButton(
                          onTap: controller.saveGeneralSetting,
                          title: "Save Changes",
                          isLoading: controller.isGeneralSettingSaving.value,
                          borderRadius: 8,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingImage extends StatelessWidget {
  const _SettingImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final isFile = path.startsWith('/') && !path.startsWith('/v1/');
    final imagePath = path.isEmpty || isFile
        ? path
        : ApiUrl.getImageBaseUrl() + path;

    return CustomImage(
      path: imagePath,
      isFile: isFile,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
