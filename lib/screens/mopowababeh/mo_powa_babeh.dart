import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MoPowaBabeh extends StatefulWidget {
  const MoPowaBabeh({
    Key? key,
  }) : super(key: key);

  static const routeName = '/mopowababeh';

  @override
  State<MoPowaBabeh> createState() {
    return MoPowaBabehState();
  }
}

class MoPowaBabehState extends State<MoPowaBabeh> {
  var content = '';

  Future<void> loadTextFromFile() async {
    final fileContent =
        await DefaultAssetBundle.of(context).loadString('texts/more_power.txt');
    if (fileContent.isNotEmpty) {
      setState(() {
        content = fileContent;
      });
    }
  }

  @override
  void initState() {
    loadTextFromFile();
    super.initState();
  }

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
              tooltip: 'Info',
              heroTag: 'more_power',
              child: const Icon(Icons.car_repair),
            ),
            const Text(
              '#MOPOWABABEH!',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 1.0),
          ],
        ),
      ),
      body: content.isEmpty
          ? const Center(
              child: Text('Loading...'),
            )
          : SafeArea(
              child: Markdown(
                data: content,
                selectable: true,
                styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
              ),
            ),
    );
  }
}
