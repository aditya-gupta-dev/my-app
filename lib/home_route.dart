import 'package:flutter/material.dart';
import 'package:myapp/app_state.dart';
import 'package:myapp/downloads_route.dart';
import 'package:myapp/theme_route.dart';
import 'package:myapp/video_route.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ThemeRoute(),
                ),
              );
            },
            icon: const Icon(Icons.brush),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              initialValue: appState.text,
              onChanged: (value) {
                appState.setText(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(12, 12),
                  ),
                ),
                labelText: 'Enter your url',
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text("Result"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoRoute(
                link: appState.text,
              ),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
