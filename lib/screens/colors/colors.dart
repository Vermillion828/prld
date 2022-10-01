import 'package:flutter/material.dart';

class BodyColors extends StatefulWidget {
  const BodyColors({
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
        child: Center(
          child: Column(
            children: const [
              Text('Colors is coming'),
            ],
          ),
        ),
      ),
    );
  }
}
