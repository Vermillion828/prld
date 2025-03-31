import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DownloadManager {
  static final DownloadManager _instance = DownloadManager._internal();

  factory DownloadManager() {
    return _instance;
  }

  DownloadManager._internal();

  Future<String> downloadFile({
    required String url,
    required String filename,
  }) async {
    var directory = await getApplicationDocumentsDirectory();

    final bytes = await compute<String, Uint8List>(createIsolate, url);

    String dir = directory.path;
    String path = '$dir/$filename';
    final file = File(path);
    await file.writeAsBytes(bytes);
    return path;
  }

  Future<Uint8List> createIsolate(
    String url,
  ) async {
    ReceivePort myReceivePort = ReceivePort();

    Isolate.spawn<SendPort>(launchDownload, myReceivePort.sendPort);

    SendPort fileSendPort = await myReceivePort.first;

    ReceivePort fileResponseReceivePort = ReceivePort();

    fileSendPort.send([
      url,
      fileResponseReceivePort.sendPort,
    ]);

    final response = await fileResponseReceivePort.first;
    return response;
  }

  void launchDownload(SendPort mySendPort) async {
    ReceivePort fileReceivePort = ReceivePort();

    mySendPort.send(fileReceivePort.sendPort);

    await for (var message in fileReceivePort) {
      if (message is List) {
        final url = message[0];
        final SendPort fileResponseSendPort = message[1];

        final httpClient = HttpClient();

        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);

        fileResponseSendPort.send(bytes);
      }
    }
  }
}
