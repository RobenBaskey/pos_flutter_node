import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.isVertical = false, this.color});
  final bool isVertical;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? VerticalDivider(
            width: 1,
            color: color ?? Theme.of(context).colorScheme.outline,
          )
        : Divider(
            height: 1,
            color: color ?? Theme.of(context).colorScheme.outline,
          );
  }
}
