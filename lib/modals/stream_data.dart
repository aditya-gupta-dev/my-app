class StreamData {
  int? itag;
  String? mime;
  double? size;
  String? url;
  bool? hasAudio;
  bool? hasVideo;

  StreamData(
      {required this.itag,
      required this.mime,
      required this.size,
      required this.url,
      required this.hasAudio,
      required this.hasVideo});

  StreamData.fromJson(Map<String, dynamic> json) {
    itag = json['itag'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    hasAudio = json['has_audio'];
    hasVideo = json['has_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itag'] = itag;
    data['mime'] = mime;
    data['size'] = size;
    data['url'] = url;
    data['has_audio'] = hasAudio;
    data['has_video'] = hasVideo;
    return data;
  }
}
