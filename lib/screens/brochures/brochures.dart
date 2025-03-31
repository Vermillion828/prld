import 'package:flutter/material.dart';
import 'package:honda_prelude/screens/pdf/pdf_viewer.dart';
import 'package:honda_prelude/services/download_manager.dart';

class Brochures extends StatefulWidget {
  const Brochures({
    Key? key,
  }) : super(key: key);

  static const routeName = '/brochures';

  @override
  State<Brochures> createState() {
    return BrochuresState();
  }
}

class BrochuresState extends State<Brochures> {
  String? currentPath;

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
              tooltip: 'Brochures',
              heroTag: 'brochure',
              child: const Icon(Icons.picture_as_pdf_rounded),
            ),
            const Text(
              '#BROCHURES!',
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
            children: [
              OutlinedButton(
                onPressed: () async {
                  final path = await DownloadManager().downloadFile(
                    url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
                        // 'https://autocatalogarchive.com/wp-content/uploads/2016/10/Honda-Prelude-1999-NL.pdf',
                    filename: '5_gen_1999_NL.pdf',
                  );
                  if (path != null) {
                    setState(() {
                      currentPath = path;
                    });
                  }
                },
                child: const Text('Click Me'),
              ),
              if (currentPath != null) ...[
                PdfViewer(currentPath!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
