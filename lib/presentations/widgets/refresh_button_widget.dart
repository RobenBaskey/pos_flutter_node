import 'package:flutter/material.dart';

class RefreshButtonWidget extends StatelessWidget {
  const RefreshButtonWidget({super.key, required this.onRefresh});
  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onRefresh, icon: Icon(Icons.refresh));
  }
}
