import 'package:flutter/material.dart';
import 'package:honda_prelude/data/menu/menu_item.dart';
import 'package:honda_prelude/screens/brochures/brochures.dart';
import 'package:honda_prelude/screens/body_colors/body_colors.dart';
import 'package:honda_prelude/screens/mopowababeh/mo_powa_babeh.dart';
import 'package:honda_prelude/screens/rims_tires/rims_tires.dart';

final List<MenuItemData> menuItemsData = [
  MenuItemData(
    name: 'RIMS/TIRES',
    heroTag: 'rims_tires',
    route: RimsTires.routeName,
    tooltip: 'Rims and tires',
    supportedGens: [1, 2, 3, 4, 5],
    icon: Icons.tire_repair_rounded,
  ),
  MenuItemData(
    name: 'COLORS',
    heroTag: 'colors',
    route: BodyColors.routeName,
    tooltip: 'Colors',
    supportedGens: [1, 2, 3, 4, 5],
    icon: Icons.color_lens_rounded,
  ),
  MenuItemData(
    name: 'BROCHURES',
    heroTag: 'brochure',
    route: Brochures.routeName,
    tooltip: 'Brochures',
    supportedGens: [3, 4, 5],
    icon: Icons.picture_as_pdf_rounded,
  ),
  MenuItemData(
    name: 'MORE POWER',
    heroTag: 'more_power',
    route: MoPowaBabeh.routeName,
    tooltip: 'More power',
    supportedGens: [4, 5],
    icon: Icons.car_repair,
  ),
];
