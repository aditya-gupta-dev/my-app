import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:myapp/modals/stream_data.dart';
import 'package:path_provider/path_provider.dart';

class StreamCard extends StatefulWidget {
  final StreamData stream;
  final String title;

  const StreamCard({super.key, required this.stream, required this.title});

  @override
  State<StreamCard> createState() => _StreamCardState();
}

class _StreamCardState extends State<StreamCard> {
  double progress = 0.0;

  getFileTypeAndExtension(StreamData stream) {
    return stream.hasVideo == false ? ["music", ".mp3"] : ["video", ".mp4"];
  }

  Future startDownload() async {
    final document = await getApplicationDocumentsDirectory();
    final typeNext = getFileTypeAndExtension(widget.stream);
    final assetsDirectory =
        Directory(path.join(document.path, "assets", typeNext[0]));
    String filename = "${widget.title}||${widget.stream.itag}${typeNext[1]}";

    File file =
        File(sanitizeFilename(path.join(assetsDirectory.path, filename)));

    if (!assetsDirectory.existsSync()) {
      assetsDirectory.createSync(recursive: true);
    }

    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    Dio dio = Dio();

    try {
      await dio.download(
        widget.stream.url!,
        file.path,
        onReceiveProgress: (received, total) {
          if (kDebugMode) {
            print(received / total);
          }
          setState(() {
            progress = received / total;
          });
        },
      );
    } catch (e) {}
  }

  String sanitizeFilename(String filename) {
    const specialChars = r'<>"!|?*$ ';

    for (var char in specialChars.runes) {
      filename = filename.replaceAll(String.fromCharCode(char), '_');
    }
    filename = filename.trim();
    filename = filename.replaceAll(RegExp('_+'), '_');
    return filename;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.stream.mime}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${widget.stream.size!.toStringAsFixed(1)} MB")
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: progress * 100 > 1,
              child: Column(
                children: [
                  Text(
                    "${(progress * 100).toStringAsFixed(2)} %",
                    textAlign: TextAlign.start,
                  ),
                  LinearProgressIndicator(
                    value: progress,
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      color: Theme.of(context).colorScheme.primary,
                      widget.stream.hasAudio == true
                          ? Icons.mic
                          : Icons.mic_off,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Icon(
                      color: Theme.of(context).colorScheme.primary,
                      widget.stream.hasVideo == true
                          ? Icons.videocam
                          : Icons.videocam_off,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await startDownload();
                      },
                      child: const Icon(Icons.download),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
