class Tiktok {
  Tiktok({
    required this.id,
    required this.region,
    required this.title,
    required this.cover,
    required this.aiDynamicCover,
    required this.originCover,
    required this.duration,
    required this.play,
    required this.wmplay,
    required this.hdplay,
    required this.size,
    required this.wmSize,
    required this.hdSize,
    required this.music,
    required this.musicInfo,
    required this.playCount,
    required this.diggCount,
    required this.commentCount,
    required this.shareCount,
    required this.downloadCount,
    required this.collectCount,
    required this.createTime,
    required this.anchors,
    required this.anchorsExtras,
    required this.isAd,
    required this.commerceInfo,
    required this.commercialVideoInfo,
    required this.itemCommentSettings,
    required this.mentionedUsers,
    required this.author,
  });

  final String? id;
  final String? region;
  final String? title;
  final String? cover;
  final String? aiDynamicCover;
  final String? originCover;
  final int? duration;
  final String? play;
  final String? wmplay;
  final String? hdplay;
  final int? size;
  final int? wmSize;
  final int? hdSize;
  final String? music;
  final MusicInfo? musicInfo;
  final int? playCount;
  final int? diggCount;
  final int? commentCount;
  final int? shareCount;
  final int? downloadCount;
  final int? collectCount;
  final int? createTime;
  final dynamic anchors;
  final String? anchorsExtras;
  final bool? isAd;
  final CommerceInfo? commerceInfo;
  final String? commercialVideoInfo;
  final int? itemCommentSettings;
  final String? mentionedUsers;
  final Author? author;

  factory Tiktok.fromJson(Map<String, dynamic> json) {
    return Tiktok(
      id: json["id"],
      region: json["region"],
      title: json["title"],
      cover: json["cover"],
      aiDynamicCover: json["ai_dynamic_cover"],
      originCover: json["origin_cover"],
      duration: json["duration"],
      play: json["play"],
      wmplay: json["wmplay"],
      hdplay: json["hdplay"],
      size: json["size"],
      wmSize: json["wm_size"],
      hdSize: json["hd_size"],
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
      createTime: json["create_time"],
      anchors: json["anchors"],
      anchorsExtras: json["anchors_extras"],
      isAd: json["is_ad"],
      commerceInfo: json["commerce_info"] == null
          ? null
          : CommerceInfo.fromJson(json["commerce_info"]),
      commercialVideoInfo: json["commercial_video_info"],
      itemCommentSettings: json["item_comment_settings"],
      mentionedUsers: json["mentioned_users"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
    );
  }
}

class Author {
  Author({
    required this.id,
    required this.uniqueId,
    required this.nickname,
    required this.avatar,
  });

  final String? id;
  final String? uniqueId;
  final String? nickname;
  final String? avatar;

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json["id"],
      uniqueId: json["unique_id"],
      nickname: json["nickname"],
      avatar: json["avatar"],
    );
  }
}

class CommerceInfo {
  CommerceInfo({
    required this.advPromotable,
    required this.auctionAdInvited,
    required this.brandedContentType,
    required this.withCommentFilterWords,
  });

  final bool? advPromotable;
  final bool? auctionAdInvited;
  final int? brandedContentType;
  final bool? withCommentFilterWords;

  factory CommerceInfo.fromJson(Map<String, dynamic> json) {
    return CommerceInfo(
      advPromotable: json["adv_promotable"],
      auctionAdInvited: json["auction_ad_invited"],
      brandedContentType: json["branded_content_type"],
      withCommentFilterWords: json["with_comment_filter_words"],
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
