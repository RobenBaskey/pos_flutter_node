import 'package:flutter/material.dart';
import 'package:pos/core/network/api_url.dart';
import 'package:pos/domain/entities/category_entity.dart';
import 'package:pos/presentations/widgets/custom_image.dart';

import '../../core/theme/app_colors.dart';

class CustomCategoryDropdown extends StatelessWidget {
  const CustomCategoryDropdown({
    super.key,
    required this.onChange,
    required this.items,
    required this.selectedValue,
    this.hint = 'Select an option',
  });
  final Function(CategoryEntity?)? onChange;
  final CategoryEntity? selectedValue;
  final List<CategoryEntity> items;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: DropdownButton<CategoryEntity?>(
        value: selectedValue,
        hint: Text(hint),
        isExpanded: true,
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Row(
                  children: [
                    CustomImage(
                      path: "${ApiUrl.getImageBaseUrl()}${e.image}",
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 8),
                    Text(e.name ?? "Select Category"),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: onChange,
        underline: const SizedBox(),
        dropdownColor: AppColors.darkBackground,
      ),
    );
  }
}
