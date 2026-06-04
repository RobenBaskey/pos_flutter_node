import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class CustomStringDropdown extends StatelessWidget {
  const CustomStringDropdown({
    super.key,
    required this.onChange,
    required this.items,
    required this.selectedValue,
    this.hint = 'Select an option',
  });
  final Function(String?)? onChange;
  final String? selectedValue;
  final List<String> items;
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
      child: DropdownButton<String?>(
        value: selectedValue,
        hint: Text(hint),
        isExpanded: true,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChange,
        underline: const SizedBox(),
        dropdownColor: AppColors.darkBackground,
      ),
    );
  }
}
