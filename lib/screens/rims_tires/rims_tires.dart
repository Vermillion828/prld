import 'package:flutter/material.dart';

class RimsTires extends StatefulWidget {
  const RimsTires({
    Key? key,
  }) : super(key: key);

  static const routeName = '/rims_tires';

  @override
  RimsTiresState createState() => RimsTiresState();
}

class RimsTiresState extends State<RimsTires> {
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
              tooltip: 'Rims and tires',
              heroTag: 'rims_tires',
              child: const Icon(Icons.tire_repair_rounded),
            ),
            const Text(
              '#RIMS&TIRES!',
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
              Text('Rims and tires is coming'),
            ],
          ),
        ),
      ),
    );
  }
}
