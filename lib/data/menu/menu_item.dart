import 'package:flutter/material.dart';

class MenuItemData {
  final String name;
  final String heroTag;
  final String route;
  final String tooltip;
  final List<int> supportedGens;
  final IconData icon;

  MenuItemData({
    required this.name,
    required this.heroTag,
    required this.route,
    required this.tooltip,
    required this.supportedGens,
    required this.icon,
  });
}
