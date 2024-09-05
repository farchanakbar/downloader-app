class Tiktok {
  Tiktok({
    required this.code,
    required this.msg,
    required this.processedTime,
    required this.data,
  });

  final int? code;
  final String? msg;
  final int? processedTime;
  final Data? data;

  factory Tiktok.fromJson(Map<String, dynamic> json) {
    return Tiktok(
      code: json["code"],
      msg: json["msg"],
      processedTime: json["processed_time"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.region,
    required this.title,
    required this.cover,
    required this.duration,
    required this.play,
    required this.wmplay,
    required this.size,
    required this.wmSize,
    required this.music,
    required this.musicInfo,
    required this.playCount,
    required this.diggCount,
    required this.commentCount,
    required this.shareCount,
    required this.downloadCount,
    required this.collectCount,
  });

  final String? id;
  final String? region;
  final String? title;
  final String? cover;
  final int? duration;
  final String? play;
  final String? wmplay;
  final int? size;
  final int? wmSize;
  final String? music;
  final MusicInfo? musicInfo;
  final int? playCount;
  final int? diggCount;
  final int? commentCount;
  final int? shareCount;
  final int? downloadCount;
  final int? collectCount;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      region: json["region"],
      title: json["title"],
      cover: json["cover"],
      duration: json["duration"],
      play: json["play"],
      wmplay: json["wmplay"],
      size: json["size"],
      wmSize: json["wm_size"],
      music: json["music"],
      musicInfo: json["music_info"] == null
          ? null
          : MusicInfo.fromJson(json["music_info"]),
      playCount: json["play_count"],
      diggCount: json["digg_count"],
      commentCount: json["comment_count"],
      shareCount: json["share_count"],
      downloadCount: json["download_count"],
      collectCount: json["collect_count"],
    );
  }
}

class MusicInfo {
  MusicInfo({
    required this.id,
    required this.title,
    required this.play,
    required this.cover,
    required this.author,
    required this.original,
    required this.duration,
    required this.album,
  });

  final String? id;
  final String? title;
  final String? play;
  final String? cover;
  final String? author;
  final bool? original;
  final int? duration;
  final String? album;

  factory MusicInfo.fromJson(Map<String, dynamic> json) {
    return MusicInfo(
      id: json["id"],
      title: json["title"],
      play: json["play"],
      cover: json["cover"],
      author: json["author"],
      original: json["original"],
      duration: json["duration"],
      album: json["album"],
    );
  }
}
