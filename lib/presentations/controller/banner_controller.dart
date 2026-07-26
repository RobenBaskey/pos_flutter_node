import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/data/model/banner_model.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/domain/repos/banner_repo.dart';

import '../../core/constants/enum.dart';

class BannerController extends GetxController {
  final BannerRepo _bannerRepo;
  BannerController({required BannerRepo bannerRepo}) : _bannerRepo = bannerRepo;
  var isLoading = false.obs;
  var bannerList = <BannerModel>[].obs;

  var isCategoryLoading = false.obs;
  var categoryList = <CategoryEntity>[];

  ///insert banner
  var isBannerAdding = false.obs;
  final TextEditingController bannerNameController = TextEditingController();
  var selectedCategory = Rxn<CategoryEntity>();
  final TextEditingController offerAmountController = TextEditingController();
  var isPercentage = true.obs;
  var isActive = true.obs;
  var selectedLocalImage = Rxn<PlatformFile>();

  @override
  void onInit() {
    getBanners();
    getCategories();
    super.onInit();
  }

  Future getCategories({bool isLoading = true}) async {
    try {
      if (isLoading) isCategoryLoading.value = true;
      var result = await _bannerRepo.getCategories();
      categoryList = result;
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      if (isLoading) isCategoryLoading.value = false;
    }
  }

  Future getBanners() async {
    isLoading.value = true;
    try {
      var banners = await _bannerRepo.getBanners();
      bannerList.value = banners;
    } catch (e) {
      Utils.showSnackBar("Failed to load banners: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future pickImage() async {
    final image = await Utils.pickImage();
    if (image != null) {
      selectedLocalImage.value = image;
    }
  }

  Future addBanner({CategoryEntity? category}) async {
    if (bannerNameController.text.trim().isEmpty) {
      Utils.showSnackBar("Banner name is required");
      return;
    }

    if (selectedCategory.value == null) {
      Utils.showSnackBar("Banner category is required");
      return;
    }

    if (selectedLocalImage.value == null) {
      Utils.showSnackBar("Banner image is required");
      return;
    }

    try {
      isBannerAdding.value = true;
      var result = await _bannerRepo.addBanner(
        BannerModel(
          name: bannerNameController.text.trim(),
          categoryId: selectedCategory.value!.id,
          offerAmmount: offerAmountController.text.trim().isEmpty
              ? 0
              : int.tryParse(offerAmountController.text.trim()),
          isPercentage: isPercentage.value,
          isActive: isActive.value,
        ),
        selectedLocalImage.value!,
      );

      bannerNameController.clear();
      offerAmountController.clear();
      selectedLocalImage.value = null;
      Get.back(); // Close the add category dialog
      Utils.showSnackBar(
        "Banner added successfully",
        title: "Success",
        type: SnackBarType.success,
      );
      getBanners();
    } catch (e) {
      debugPrint("Error adding banner: $e");
    } finally {
      isBannerAdding.value = false;
    }
  }
}
