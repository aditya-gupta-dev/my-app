import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final FileSystemEntity entity;

  const PlayerWidget({super.key, required this.entity});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  void handlePlay() {
    if (isPlaying) {
      player.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      player.resume();
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void initState() {
    player.setSource(DeviceFileSource(widget.entity.path));
    player.setReleaseMode(ReleaseMode.loop);

    player.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });
    player.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 12,
          right: 12,
        ),
        child: Column(
          children: [
            Text(
              path.basename(widget.entity.path),
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: isPlaying,
              child: Column(
                children: [
                  const Text("Under Development"),
                  Slider(
                    value: currentPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: totalDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      print("okad");
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (widget.entity.existsSync()) {
                      widget.entity.deleteSync();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          content: const Text(
                            "Deleted file",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                ActionChip.elevated(
                  onPressed: () {
                    handlePlay();
                  },
                  elevation: 3,
                  label: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
