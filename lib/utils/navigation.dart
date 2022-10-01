import 'package:flutter/material.dart';
import 'package:honda_prelude/screens/brochures/brochures.dart';
import 'package:honda_prelude/screens/colors/colors.dart';
import 'package:honda_prelude/screens/mopowababeh/mo_powa_babeh.dart';
import 'package:honda_prelude/screens/rims_tires/rims_tires.dart';

Route<dynamic>? handleNavigation(RouteSettings settings) {
  if (settings.name == MoPowaBabeh.routeName) {
    return MaterialPageRoute(
      builder: (context) => const MoPowaBabeh(),
    );
  }

  if (settings.name == Brochures.routeName) {
    return MaterialPageRoute(
      builder: (context) => const Brochures(),
    );
  }

  if (settings.name == BodyColors.routeName) {
    return MaterialPageRoute(
      builder: (context) => const BodyColors(),
    );
  }

  if (settings.name == RimsTires.routeName) {
    return MaterialPageRoute(
      builder: (context) => const RimsTires(),
    );
  }

  assert(false, 'Need to implement ${settings.name}');
  return null;
}
