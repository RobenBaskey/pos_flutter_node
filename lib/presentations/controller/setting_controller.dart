import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/general_setting_entity.dart';
import 'package:pos/domain/repos/setting_repo.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class SettingController extends GetxController {
  final SettingRepo _repo;
  SettingController(this._repo);

  @override
  void onInit() {
    quillControllers.assignAll({
      for (final key in settingKeys.values) key: QuillController.basic(),
    });
    getGeneralSetting();
    getSettingContents();
    super.onInit();
  }

  @override
  void onClose() {
    for (final controller in quillControllers.values) {
      controller.dispose();
    }
    quillController.dispose();
    companyNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  var settingItemList = [
    "General Setting",
    "About Us",
    "Contact Us",
    "Terms & Condition",
    "Privacy Policy",
  ].obs;

  var selectedItem = "General Setting".obs;

  QuillController quillController = QuillController.basic();
  final quillControllers = <String, QuillController>{}.obs;
  final settingContents = <String, String>{}.obs;
  final isContentLoading = false.obs;

  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final logo = ''.obs;
  final banner = ''.obs;
  final isGeneralSettingLoading = false.obs;
  final isGeneralSettingSaving = false.obs;
  final isGeneralSettingActive = true.obs;

  final settingKeys = const {
    "About Us": "about_us",
    "Contact Us": "contact_us",
    "Terms & Condition": "terms_condition",
    "Privacy Policy": "privacy_policy",
  };

  String get selectedKey => settingKeys[selectedItem.value] ?? "about_us";

  QuillController get selectedQuillController =>
      quillControllers[selectedKey] ?? quillController;

  Future getGeneralSetting() async {
    try {
      isGeneralSettingLoading(true);
      final setting = await _repo.getGeneralSetting();
      _setGeneralSetting(setting);
    } catch (e) {
      debugPrint("Error fetching general setting: $e");
    } finally {
      isGeneralSettingLoading(false);
    }
  }

  Future saveGeneralSetting() async {
    if (companyNameController.text.trim().isEmpty) {
      Utils.showSnackBar("Company name is required");
      return;
    }

    try {
      isGeneralSettingSaving(true);
      await _repo.postGeneralSetting(_generalSettingFromForm());
      Utils.showSnackBar(
        "General setting saved successfully.",
        type: SnackBarType.success,
      );
    } catch (e) {
      debugPrint("Error saving general setting: $e");
      Utils.showSnackBar("Failed to save general setting");
    } finally {
      isGeneralSettingSaving(false);
    }
  }

  Future pickLogo() async {
    final image = await Utils.pickImage();
    if (image != null) logo.value = image.path;
  }

  Future pickBanner() async {
    final image = await Utils.pickImage();
    if (image != null) banner.value = image.path;
  }

  void removeLogo() {
    logo.value = '';
  }

  void removeBanner() {
    banner.value = '';
  }

  Future getSettingContents() async {
    try {
      isContentLoading(true);
      await Future.wait(
        settingKeys.values.map((key) async {
          final html = await _repo.getContent(key);
          settingContents[key] = html;
          _setQuillContent(key, html);
        }),
      );
    } catch (e) {
      debugPrint("Error fetching setting content: $e");
    } finally {
      isContentLoading(false);
    }
  }

  Future onSave() async {
    // Get delta json
    final deltaJson = selectedQuillController.document.toDelta().toJson();

    // Convert delta to html
    final converter = QuillDeltaToHtmlConverter(List.castFrom(deltaJson));

    final html = converter.convert();

    await _repo.insertContent(selectedKey, html);
    settingContents[selectedKey] = html;
  }

  Future<void> onPreview(BuildContext context) async {
    final previewController = QuillController(
      document: Document.fromDelta(selectedQuillController.document.toDelta()),
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(selectedItem.value),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.65,
            height: MediaQuery.sizeOf(context).height * 0.65,
            child: QuillEditor.basic(
              controller: previewController,
              config: const QuillEditorConfig(
                showCursor: false,
                padding: EdgeInsets.all(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("CLOSE"),
            ),
          ],
        );
      },
    );

    previewController.dispose();
  }

  void _setQuillContent(String key, String html) {
    final document = Document();
    final text = _htmlToPlainText(html);
    if (text.isNotEmpty) {
      document.insert(0, text);
    }

    quillControllers[key]?.dispose();
    quillControllers[key] = QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  String _htmlToPlainText(String html) {
    return html
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();
  }

  void _setGeneralSetting(GeneralSettingEntity setting) {
    companyNameController.text = setting.companyName;
    emailController.text = setting.email;
    phoneController.text = setting.phone;
    addressController.text = setting.address;
    descriptionController.text = setting.description;
    logo.value = setting.logo;
    banner.value = setting.banner;
    isGeneralSettingActive.value = setting.isActive;
  }

  GeneralSettingEntity _generalSettingFromForm() {
    return GeneralSettingEntity(
      companyName: companyNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      description: descriptionController.text.trim(),
      logo: logo.value,
      banner: banner.value,
      isActive: isGeneralSettingActive.value,
    );
  }
}
