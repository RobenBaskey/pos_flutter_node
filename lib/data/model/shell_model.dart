import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShellModel {
  final FaIconData icon;
  final String name;
  final Widget page;
  final bool isDivider;
  final double size;
  final Color? color;
  final List<ShellModel> childShell;

  ShellModel({
    required this.icon,
    required this.name,
    required this.page,
    this.isDivider = false,
    this.size = 20,
    this.color,
    this.childShell = const [],
  });
}
