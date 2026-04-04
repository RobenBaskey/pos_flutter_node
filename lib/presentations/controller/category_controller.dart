import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/domain/repos/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepo _categoryRepo;
  CategoryController(this._categoryRepo);

  var isCategoryLoading = false.obs;
  var categoryList = <CategoryEntity>[].obs;

  ///add category
  var isCategoryAdding = false.obs;
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController =
      TextEditingController();
  var selectedImagePath = Rxn<String>();

  ///delete category
  var isCategoryDeleting = false.obs;

  ///update category
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
      categoryList.value = result;
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
      );
      if (result) {
        categoryNameController.clear();
        categoryDescriptionController.clear();
        selectedImagePath.value = null;
        Get.back(); // Close the add category dialog
        Utils.showSnackBar("Category added successfully");
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
        Utils.showSnackBar("Category deleted successfully");
        getCategories(isLoading: false);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      isCategoryDeleting.value = false;
    }
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
      );
      if (result) {
        updateNameController.clear();
        updateDescriptionController.clear();
        selectedImagePath.value = null;
        Get.back(); // Close the add category dialog
        Utils.showSnackBar("Category updated successfully");
        getCategories(isLoading: false);
      }
    } catch (e) {
      debugPrint("Error adding category: $e");
    } finally {
      isCategoryAdding.value = false;
    }
  }
}
