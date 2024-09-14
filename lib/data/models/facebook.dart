class FacebookReels {
  FacebookReels({
    required this.resolution,
    required this.thumbnail,
    required this.url,
    required this.shouldRender,
  });

  final String? resolution;
  final String? thumbnail;
  final String? url;
  final bool? shouldRender;

  factory FacebookReels.fromJson(Map<String, dynamic> json) {
    return FacebookReels(
      resolution: json["resolution"],
      thumbnail: json["thumbnail"],
      url: json["url"],
      shouldRender: json["shouldRender"],
    );
  }
}
