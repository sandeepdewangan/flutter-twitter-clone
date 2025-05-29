// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TweetModel {
  final String tweet;
  final List<String> hashtags;
  final List<String> links;
  final List<String> images;
  final String uid;
  final int tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;

  const TweetModel({
    required this.tweet,
    required this.hashtags,
    required this.links,
    required this.images,
    required this.uid,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
  });

  TweetModel copyWith({
    String? tweet,
    List<String>? hashtags,
    List<String>? links,
    List<String>? images,
    String? uid,
    int? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
  }) {
    return TweetModel(
      tweet: tweet ?? this.tweet,
      hashtags: hashtags ?? this.hashtags,
      links: links ?? this.links,
      images: images ?? this.images,
      uid: uid ?? this.uid,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    print(tweetedAt);
    return <String, dynamic>{
      'tweet': tweet,
      'hashtags': hashtags,
      'links': links,
      'images': images,
      'uid': uid,
      'tweetedAt': tweetedAt,
      'likes': likes,
      'commentIds': commentIds,

      'reshareCount': reshareCount,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweet: map['tweet'] as String,
      hashtags: List<String>.from(map['hashtags']),
      links: List<String>.from(map['links']),
      images: List<String>.from(map['images']),
      uid: map['uid'] as String,

      tweetedAt: map['tweetedAt'],
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['id'] as String,
      reshareCount: map['reshareCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) =>
      TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TweetModel(tweet: $tweet, hashtags: $hashtags, links: $links, images: $images, uid: $uid, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount)';
  }

  @override
  bool operator ==(covariant TweetModel other) {
    if (identical(this, other)) return true;

    return other.tweet == tweet &&
        listEquals(other.hashtags, hashtags) &&
        listEquals(other.links, links) &&
        listEquals(other.images, images) &&
        other.uid == uid &&
        other.tweetedAt == tweetedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount;
  }

  @override
  int get hashCode {
    return tweet.hashCode ^
        hashtags.hashCode ^
        links.hashCode ^
        images.hashCode ^
        uid.hashCode ^
        tweetedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode;
  }
}
