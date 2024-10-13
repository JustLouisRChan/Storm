class ApiResponse {
  final String apiVersion;
  final VideoData data;

  ApiResponse({required this.apiVersion, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      apiVersion: json['apiVersion'],
      data: VideoData.fromJson(json['data']),
    );
  }
}
class VideoData {
  final String id;
  final String uploaded;
  final String updated;
  final String uploader;
  final String category;
  final String title;
  final String description;
  final List<String> tags;
  final Thumbnail thumbnail;
  final Player player;
  final Map<String, String> content;
  final int duration;
  final String aspectRatio;
  final double rating;
  final int likeCount; 
  final int bookmarkCount;
  final int viewCount;
  final int shareCount; // Changed from bookmarkCount
  final int commentCount; // Changed to int
  final Status status;
  final List<Restriction> restrictions;
  final AccessControl accessControl;

  VideoData({
    required this.id,
    required this.uploaded,
    required this.updated,
    required this.uploader,
    required this.category,
    required this.title,
    required this.description,
    required this.tags,
    required this.thumbnail,
    required this.player,
    required this.content,
    required this.duration,
    required this.aspectRatio,
    required this.rating,
    required this.likeCount,
    required this.bookmarkCount,
    required this.viewCount,
    required this.shareCount,
    required this.commentCount,
    required this.status,
    required this.restrictions,
    required this.accessControl,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      id: json['id'],
      uploaded: json['uploaded'],
      updated: json['updated'],
      uploader: json['uploader'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
      player: Player.fromJson(json['player']),
      content: Map<String, String>.from(json['content']),
      duration: json['duration'],
      aspectRatio: json['aspectRatio'],
      rating: json['rating'].toDouble(),
      likeCount: json['likeCount'], // Ensure it's a String
      bookmarkCount: json['bookmarkCount'] ?? 0, // Handle default value
      viewCount: json['viewCount'],
      shareCount: json['shareCount'], // Adjusted from bookmarkCount to favoriteCount
      commentCount: json['commentCount'],
      status: Status.fromJson(json['status']),
      restrictions: (json['restrictions'] as List)
          .map((i) => Restriction.fromJson(i))
          .toList(),
      accessControl: AccessControl.fromJson(json['accessControl']),
    );
  }
}

class Thumbnail {
  final String sqDefault;
  final String hqDefault;

  Thumbnail({required this.sqDefault, required this.hqDefault});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      sqDefault: json['sqDefault'],
      hqDefault: json['hqDefault'],
    );
  }
}

class Player {
  final String defaultUrl;

  Player({required this.defaultUrl});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      defaultUrl: json['default'],
    );
  }
}

class Status {
  final String value;
  final String reason;

  Status({required this.value, required this.reason});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      value: json['value'],
      reason: json['reason'],
    );
  }
}

class Restriction {
  final String type;
  final String relationship;
  final String countries;

  Restriction({required this.type, required this.relationship, required this.countries});

  factory Restriction.fromJson(Map<String, dynamic> json) {
    return Restriction(
      type: json['type'],
      relationship: json['relationship'],
      countries: json['countries'],
    );
  }
}

class AccessControl {
  final String comment;
  final String commentVote;
  final String videoRespond;
  final String rate;
  final String embed;
  final String list;
  final String autoPlay;
  final String syndicate;

  AccessControl({
    required this.comment,
    required this.commentVote,
    required this.videoRespond,
    required this.rate,
    required this.embed,
    required this.list,
    required this.autoPlay,
    required this.syndicate,
  });

  factory AccessControl.fromJson(Map<String, dynamic> json) {
    return AccessControl(
      comment: json['comment'],
      commentVote: json['commentVote'],
      videoRespond: json['videoRespond'],
      rate: json['rate'],
      embed: json['embed'],
      list: json['list'],
      autoPlay: json['autoPlay'],
      syndicate: json['syndicate'],
    );
  }
}
