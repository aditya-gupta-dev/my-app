import 'package:flutter/material.dart';
import 'package:myapp/app_state.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/downloads_route.dart';
import 'package:provider/provider.dart';

class ThemeRoute extends StatelessWidget {
  const ThemeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Themes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DownloadsRoute(),
                ),
              );
            },
            icon: const Icon(Icons.download),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: supportedThemes.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${supportedThemes[index]["title"]}"),
                  ElevatedButton(
                    onPressed: () {
                      appState.setSelectedThemeIndex(index);
                    },
                    child: const Text("Apply"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
