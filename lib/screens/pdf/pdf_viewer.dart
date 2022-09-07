import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfViewer extends StatefulWidget {
  final String filePath;

  const PdfViewer(
    this.filePath, {
    Key? key,
  }) : super(key: key);

  @override
  PdfViewerState createState() => PdfViewerState();
}

class PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PdfView(path: widget.filePath),
    );
  }
}
