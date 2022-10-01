import 'package:flutter/material.dart';
import 'package:honda_prelude/data/menu/menu_item.dart';
import 'package:honda_prelude/screen_data.dart';
import 'package:honda_prelude/screens/home/menu_items_data.dart';
import 'package:honda_prelude/utils/utils.dart';
import 'package:provider/provider.dart';

class MenuGrid extends StatefulWidget {
  const MenuGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuGrid> createState() => _MenuGridState();
}

class _MenuGridState extends State<MenuGrid> {
  int currentMenuGen = 0;
  List<MenuItemData> currentMenu = [];

  @override
  Widget build(BuildContext context) {
    if (currentMenuGen == 0 ||
        currentMenuGen != context.watch<ScreenData>().getGeneration()) {
      currentMenuGen = context.watch<ScreenData>().getGeneration();
      currentMenu = _getMunuItemsForGen(currentMenuGen);
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Material(
            color: _getItemBgColor(index),
            child: index < currentMenu.length
                ? Center(
                    child: _getMenuItem(
                      currentMenu[index],
                      context,
                    ),
                  )
                : const SizedBox(),
          );
        },
        childCount: 18,
      ),
    );
  }
}

Color? _getItemBgColor(int index) {
  return index % 2 == 0 ? Colors.white : Colors.grey[100];
}

Widget _getMenuItem(
  MenuItemData data,
  BuildContext context,
) {
  return getIsSmallScreen(context)
      ? _getSmallFABbyInddex(
          data,
          context,
        )
      : _getBigFABbyInddex(
          data,
          context,
        );
}

Widget _getSmallFABbyInddex(
  MenuItemData data,
  BuildContext context,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FloatingActionButton(
        heroTag: data.heroTag,
        onPressed: () {
          Navigator.of(context).pushNamed(
            data.route,
          );
        },
        tooltip: data.tooltip,
        child: Icon(data.icon),
      ),
      const SizedBox(height: 8.0),
      Text(
        data.name,
        style: const TextStyle(fontSize: 11.0),
      ),
    ],
  );
}

Widget _getBigFABbyInddex(
  MenuItemData data,
  BuildContext context,
) {
  return FloatingActionButton.large(
    heroTag: data.heroTag,
    onPressed: () {
      Navigator.of(context).pushNamed(
        data.route,
      );
    },
    tooltip: data.tooltip,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(data.icon),
        const SizedBox(height: 4.0),
        Text(
          data.name,
          style: const TextStyle(fontSize: 11.0),
        ),
      ],
    ),
  );
}

List<MenuItemData> _getMunuItemsForGen(int gen) {
  List<MenuItemData> items = [];
  for (var element in menuItemsData) {
    if (element.supportedGens.contains(gen)) {
      items.add(element);
    }
  }
  return items;
}
