import 'package:flutter/material.dart';

class CustomContainerShape extends StatelessWidget {
  const CustomContainerShape({
    super.key,
    required this.child,
    this.padding = 20,
  });
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}
