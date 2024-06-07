import 'dart:io';
import 'package:myapp/components/audio_player_card.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsRoute extends StatefulWidget {
  const DownloadsRoute({super.key});

  @override
  State<DownloadsRoute> createState() => _DownloadsRouteState();
}

class _DownloadsRouteState extends State<DownloadsRoute> {
  List<FileSystemEntity> audios = [];
  List<FileSystemEntity> videos = [];
  int selectedIndex = 0;

  getFiles(String? filter) async {
    final document = await getApplicationDocumentsDirectory();

    if (filter == ".mp3") {
      final assets = Directory(path.join(document.path, 'assets', 'music'));
      if (assets.existsSync()) {
        assets.createSync(recursive: true);
      }
      setState(() {
        audios = assets.listSync();
      });
    } else if (filter == ".mp4") {
      final assets = Directory(path.join(document.path, 'assets', 'video'));
      if (assets.existsSync()) {
        assets.createSync(recursive: true);
      }
      setState(() {
        audios = assets.listSync();
      });
    } else {
      setState(() {
        audios = [];
      });
      setState(() {
        videos = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getFiles(".mp3");
    getFiles(".mp4");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      ListView.builder(
          itemCount: audios.length,
          itemBuilder: (context, index) {
            return PlayerWidget(
              entity: audios[index],
            );
          }),
      ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return ActionChip.elevated(
              label: Text(
                path.basename(videos[index].path),
              ),
            );
          })
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloads"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: widgets.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mic_outlined),
            activeIcon: Icon(Icons.mic),
            label: "Audios",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam_outlined),
            activeIcon: Icon(Icons.videocam),
            label: "Videos",
          ),
        ],
      ),
    );
  }
}
