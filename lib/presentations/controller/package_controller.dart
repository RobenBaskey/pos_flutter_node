import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/domain/entities/package_entity.dart';
import 'package:pos/domain/repos/package_repo.dart';

import '../../core/utils/utils.dart';

class PackageController extends GetxController {
  final PackageRepo _repo;
  PackageController(this._repo);

  var isPackageGetLoading = false.obs;
  var packageList = <PackageEntity>[];
  var searchedPackageList = <PackageEntity>[].obs;

  ///add package
  var isPackageAdding = false.obs;
  final packageNameController = TextEditingController();
  final packagePriceController = TextEditingController();
  var localSelectedPackage = Rxn<PlatformFile>();
  var isMonthly = false.obs;

  ///update package
  var selectedPackage = Rxn<PackageEntity>();

  ///insert content
  var isContentLoading = false.obs;
  var singlePackage = Rxn<PackageEntity>();
  var contentList = <ContentEntity>[].obs;
  final TextEditingController contentController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  var isContentActive = false.obs;
  var selectedContentId = Rxn<String>();

  @override
  void onInit() {
    getPackages();
    super.onInit();
  }

  Future getPackages() async {
    try {
      isPackageGetLoading(true);
      packageList = await _repo.getPackages();
      searchedPackageList.assignAll(packageList);
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      isPackageGetLoading(false);
    }
  }

  Future addPackage() async {
    if (packageNameController.text.trim().isEmpty ||
        packagePriceController.text.trim().isEmpty) {
      Utils.showSnackBar("Please fill all the fields", title: "Error");
      return;
    }

    if (packageList
        .where((e) => e.name == packageNameController.text)
        .isNotEmpty) {
      Utils.showSnackBar("This name is already exits", title: "Warning");
      return;
    }

    if (localSelectedPackage.value == null) {
      Utils.showSnackBar("Please select an image", title: "Error");
      return;
    }
    isPackageAdding(true);
    try {
      await _repo.insertPackage(
        model: PackageEntity(
          name: packageNameController.text.trim(),
          price: int.tryParse(packagePriceController.text.trim()) ?? 0,
          image: "",
          isMonthly: isMonthly.value,
        ),
        file: localSelectedPackage.value!,
      );
      Get.back();
      getPackages();
      Utils.showSnackBar(
        "Package added successfully",
        title: "Success",
        type: SnackBarType.success,
      );
      packageNameController.clear();
      packagePriceController.clear();
      localSelectedPackage.value = null;
    } on Exception catch (e) {
      debugPrint(e.toString());
      Utils.showSnackBar("Failed to add package", title: "Error");
    } finally {
      isPackageAdding(false);
    }
  }

  void initPackage(PackageEntity? package) {
    selectedPackage.value = package;
    if (package != null) {
      packageNameController.text = package.name ?? "";
      packagePriceController.text = package.price.toString();
      //packageImage.value = package.image;
    } else {
      packageNameController.clear();
      packagePriceController.clear();
      localSelectedPackage.value = null;
    }
  }

  Future pickImage() async {
    final image = await Utils.pickImage();
    if (image != null) {
      localSelectedPackage.value = image;
    }
  }

  Future updatePackage() async {
    if (selectedPackage.value == null) return;
    try {
      isPackageAdding(true);
      await _repo.updatePackage(
        id: selectedPackage.value!.id!,
        model: PackageEntity(
          name: packageNameController.text.trim(),
          price: int.tryParse(packagePriceController.text.trim()) ?? 0,
          image: "",
          isMonthly: isMonthly.value,
        ),
        file: localSelectedPackage.value,
      );
      Utils.showSnackBar("Package updated successfully", title: "Success");
      getPackages();
      Navigator.pop(Get.context!);
      packageNameController.clear();
      packagePriceController.clear();
      localSelectedPackage.value = null;
    } on Exception catch (e) {
      debugPrint(e.toString());
      Utils.showSnackBar("Failed to update package", title: "Error");
    } finally {
      isPackageAdding(false);
    }
  }

  Future deletePackage(String id) async {
    try {
      await _repo.deletePackage(id: id);
      Get.back();
      Utils.showSnackBar("Package deleted successfully", title: "Success");
      getPackages();
    } on Exception catch (e) {
      debugPrint(e.toString());
      Utils.showSnackBar("Failed to delete package", title: "Error");
    }
  }

  void searchPackage(String query) {
    if (query.isNotEmpty) {
      searchedPackageList.value = packageList
          .where(
            (e) => e.name?.toLowerCase().contains(query.toLowerCase()) ?? false,
          )
          .toList();
    } else {
      searchedPackageList.value = packageList;
    }
  }

  Future getSinglePackage(String id) async {
    try {
      var result = await _repo.getSinglePackage(id);
      if (result != null) {
        singlePackage.value = result;
        contentList.value = result.contents ?? [];
      }
    } on Exception catch (e) {
      debugPrint("Error to get single package. Exception ${e.toString()}");
    }
  }

  Future deleteContent({
    required String packageId,
    required String contentId,
  }) async {
    var result = await _repo.deleteContent(
      packageId: packageId,
      contentId: contentId,
    );
    if (result) {
      contentList.removeWhere((e) => e.id == contentId);
      Utils.showSnackBar("Content removed", title: "Success");
    }
  }

  Future addContent({required String packageId}) async {
    try {
      isContentLoading(true);
      var result = await _repo.insertContent(
        packageId: packageId,
        name: contentController.text,
        isActive: isContentActive.value,
        limit: limitController.text.isNotEmpty
            ? int.tryParse(limitController.text)
            : null,
      );
      if (result) {
        contentController.clear();
        limitController.clear();
        isContentActive(true);
        getSinglePackage(packageId);
      }
    } on Exception catch (e) {
      debugPrint("Error to insert content. Exception ${e.toString()}");
    } finally {
      isContentLoading(false);
    }
  }

  Future updateContent({
    required String packageId,
    required String contentId,
  }) async {
    try {
      isContentLoading(true);
      var result = await _repo.updateContent(
        packageId: packageId,
        contentId: contentId,
        name: contentController.text,
        isActive: isContentActive.value,
        limit: limitController.text.isNotEmpty
            ? int.tryParse(limitController.text)
            : null,
      );
      if (result) {
        contentController.clear();
        limitController.clear();
        isContentActive(true);
        selectedContentId.value = null;
        getSinglePackage(packageId);
      }
    } on Exception catch (e) {
      debugPrint("Error to update content. Exception ${e.toString()}");
    } finally {
      isContentLoading(false);
    }
  }

  @override
  void onClose() {
    contentController.dispose();
    limitController.dispose();
    super.onClose();
  }
}
