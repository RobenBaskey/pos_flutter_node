import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/domain/repos/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepo _categoryRepo;
  CategoryController(this._categoryRepo);

  var isCategoryLoading = false.obs;
  var categoryList = <CategoryEntity>[];
  var searchCategoryList = <CategoryEntity>[].obs;

  ///add category
  var isCategoryAdding = false.obs;
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();
  var selectedImagePath = Rxn<String>();
  var isStatusActive = true.obs;

  ///delete category
  var isCategoryDeleting = false.obs;

  ///update category
  var selectedCategoryEntity = Rxn<CategoryEntity>();
  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController updateDescriptionController =
      TextEditingController();

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future getCategories({bool isLoading = true}) async {
    try {
      if (isLoading) isCategoryLoading.value = true;
      var result = await _categoryRepo.getCategories();
      categoryList = result;
      searchCategoryList.value = result;
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      if (isLoading) isCategoryLoading.value = false;
    }
  }

  Future pickImage() async {
    final image = await Utils.pickImage();
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  Future addCategory({CategoryEntity? category}) async {
    if (categoryNameController.text.trim().isEmpty) {
      Utils.showSnackBar("Category name is required");
      return;
    }

    if (selectedImagePath.value == null) {
      Utils.showSnackBar("Category image is required");
      return;
    }

    try {
      isCategoryAdding.value = true;
      var result = await _categoryRepo.addCategory(
        name: categoryNameController.text.trim(),
        image: selectedImagePath.value!,
        parentId: category?.id,
        status: isStatusActive.value,
      );
      if (result) {
        categoryNameController.clear();
        categoryDescriptionController.clear();
        selectedImagePath.value = null;
        Get.back(); // Close the add category dialog
        Utils.showSnackBar(
          "Category added successfully",
          title: "Success",
          type: SnackBarType.success,
        );
        getCategories(isLoading: false);
      }
    } catch (e) {
      debugPrint("Error adding category: $e");
    } finally {
      isCategoryAdding.value = false;
    }
  }

  Future deleteCategory(String id) async {
    try {
      isCategoryDeleting.value = true;
      var result = await _categoryRepo.deleteCategory(id);
      if (result) {
        Get.back(); // Close the add category dialog
        Utils.showSnackBar("Category deleted successfully", isSuccess: true);
        getCategories(isLoading: false);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      Utils.showSnackBar(
        "Error to delete category!",
        isSuccess: false,
        type: SnackBarType.error,
      );
    } finally {
      isCategoryDeleting.value = false;
    }
  }

  void initUpdate(CategoryEntity item) {
    selectedCategoryEntity.value = item;
    updateNameController.text = item.name ?? "";
    isStatusActive.value = item.status ?? false;
  }

  Future updateCategory({CategoryEntity? category}) async {
    if (updateNameController.text.trim().isEmpty) {
      Utils.showSnackBar("Category name is required");
      return;
    }

    try {
      isCategoryAdding.value = true;
      var result = await _categoryRepo.updateCategory(
        id: category?.id ?? "",
        name: updateNameController.text.trim(),
        image: selectedImagePath.value,
        status: isStatusActive.value,
      );
      if (result) {
        updateNameController.clear();
        updateDescriptionController.clear();
        selectedImagePath.value = null;
        Get.back(); // Close the add category dialog
        Utils.showSnackBar("Category updated successfully", isSuccess: true);
        getCategories(isLoading: false);
      }
    } catch (e) {
      debugPrint("Error adding category: $e");
    } finally {
      isCategoryAdding.value = false;
    }
  }

  void onSearch(String value) {
    if (value.isEmpty) {
      searchCategoryList.value = categoryList;
    } else {
      searchCategoryList.value = categoryList
          .where(
            (e) => e.name?.toLowerCase().contains(value.toLowerCase()) ?? false,
          )
          .toList();
    }
  }
}
