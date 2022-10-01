import 'package:flutter/material.dart';
import 'package:honda_prelude/data/colors/body_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BodyColorItem extends StatelessWidget {
  final BodyColor data;

  const BodyColorItem(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(data.link);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: _getGradientColors(data.color),
            stops: _getGradientStops(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
              Text(
                '(${data.code})',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
              Text(
                data.years.first.toString() +
                    ((data.years.length > 1
                        ? ' - ${data.years.last.toString()} '
                        : ' ')),
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(Color color) {
    return [
      color.withOpacity(0.45),
      color.withOpacity(0.55),
      color.withOpacity(0.7),
      color.withOpacity(0.8),
      color.withOpacity(0.9),
      color,
    ];
  }

  List<double> _getGradientStops() {
    return [
      0.0,
      0.2,
      0.4,
      0.6,
      0.8,
      1.0,
    ];
  }
}
