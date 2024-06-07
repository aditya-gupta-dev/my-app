import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/components/video_card.dart';
import 'package:myapp/modals/video.dart';
import 'package:http/http.dart' as http;

class VideoRoute extends StatelessWidget {
  final String link;
  final String url = "https://johanliebert.vercel.app/api/video";

  const VideoRoute({super.key, required this.link});

  Future<Video?>? getVideo() async {
    try {
      final res = await http.get(Uri.parse("$url?url=$link"));
      if (res.statusCode < 300) {
        return Video.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
      } else {
        return Video.sample();
      }
    } catch (e) {
      return Video.sample();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVideo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingVideoRoute();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error Occurred"),
          );
        } else {
          return VideoCard(video: snapshot.data ?? Video.sample());
        }
      },
    );
  }
}

class LoadingVideoRoute extends StatelessWidget {
  const LoadingVideoRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Text"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
