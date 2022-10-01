import 'package:flutter/material.dart';
import 'package:honda_prelude/data/colors/body_colors.dart';
import 'package:honda_prelude/screens/body_colors/body_color_item.dart';
import 'package:honda_prelude/screens/body_colors/body_colors_data.dart';

class BodyColors extends StatefulWidget {
  final int gen;

  const BodyColors({
    required this.gen,
    Key? key,
  }) : super(key: key);

  static const routeName = '/colors';

  @override
  BodyColorsState createState() => BodyColorsState();
}

class BodyColorsState extends State<BodyColors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        titleSpacing: 0.0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton.small(
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: 'Back',
            child: const Icon(Icons.arrow_back),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.small(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Info'),
                    content: const Text('Some text about this screen'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Colors',
              heroTag: 'colors',
              child: const Icon(Icons.color_lens_rounded),
            ),
            const Text(
              '#COLORS!',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 1.0),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final data = _getBodyColorData(context, index);
            if (data != null) {
              return BodyColorItem(data);
            } else {
              return const SizedBox();
            }
          },
          itemCount: _getBodyColorsLength(context),
        ),
      ),
    );
  }

  int _getBodyColorsLength(
    BuildContext context,
  ) {
    switch (widget.gen) {
      case 1:
        return firstGenPaintColors.length;
      case 2:
        return secondGenPaintColors.length;
      case 3:
        return thirdGenPaintColors.length;
      case 4:
        return fourthGenPaintColors.length;
      case 5:
        return fifthGenPaintColors.length;
      default:
        return 0;
    }
  }

  BodyColor? _getBodyColorData(
    BuildContext context,
    int index,
  ) {
    switch (widget.gen) {
      case 1:
        return firstGenPaintColors[index];
      case 2:
        return secondGenPaintColors[index];
      case 3:
        return thirdGenPaintColors[index];
      case 4:
        return fourthGenPaintColors[index];
      case 5:
        return fifthGenPaintColors[index];
      default:
        return null;
    }
  }
}
