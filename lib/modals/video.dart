import 'package:myapp/modals/stream_data.dart';

class Video {
  String? title;
  int? views;
  String? thumbnail;
  List<StreamData> streams = [];

  Video(
      {required this.title,
      required this.views,
      required this.thumbnail,
      required this.streams});

  factory Video.sample() {
    final stream = StreamData(
      itag: 23,
      mime: 'video/mp4',
      size: 330,
      url: 'url',
      hasAudio: true,
      hasVideo: false,
    );
    return Video(
      title: "Video Title",
      views: 0,
      thumbnail:
          "https://t4.ftcdn.net/jpg/00/53/45/31/360_F_53453175_hVgYVz0WmvOXPd9CNzaUcwcibiGao3CL.jpg",
      streams: [stream],
    );
  }

  Video.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    views = json['views'];
    thumbnail = json['thumbnail'];
    final List t = json['streams'];
    streams = t.map((item) => StreamData.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['views'] = views;
    data['thumbnail'] = thumbnail;
    data['streams'] = streams;
    return data;
  }
}
