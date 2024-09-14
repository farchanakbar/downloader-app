class Instagram {
  Instagram({
    required this.url,
    required this.title,
    required this.thumbnail,
    required this.video,
  });

  final String? url;
  final String? title;
  final String? thumbnail;
  final String? video;

  factory Instagram.fromJson(Map<String, dynamic> json) {
    return Instagram(
      url: json["url"],
      title: json["title"],
      thumbnail: json["thumbnail"],
      video: json["video"],
    );
  }
}
