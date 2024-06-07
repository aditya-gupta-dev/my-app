import 'package:flutter/material.dart';
import 'package:myapp/app_state.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/home_route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SugoApp());
}

class SugoApp extends StatelessWidget {
  const SugoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const Index(),
    );
  }
}

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor:
                supportedThemes[appState.selectedIndex]["color"] as Color),
      ),
      home: HomeRoute(),
    );
  }
}
