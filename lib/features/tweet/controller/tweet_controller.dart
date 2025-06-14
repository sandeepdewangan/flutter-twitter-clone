import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/storage_api.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';

final tweetControllerProvider = StateNotifierProvider<TweetController, bool>((
  ref,
) {
  return TweetController(
    ref: ref,
    tweetAPI: ref.watch(tweetAPIProvider),
    storageAPI: ref.watch(storageAPIProvider),
  );
});

final getLatestTweetProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(tweetAPIProvider).getLatestTweets();
});

final getTweetsProvider = FutureProvider((ref) {
  return ref.watch(tweetControllerProvider.notifier).getTweets();
});

class TweetController extends StateNotifier<bool> {
  final Ref ref;
  final TweetAPI tweetAPI;
  final StorageAPI storageAPI;
  TweetController({
    required this.ref,
    required this.tweetAPI,
    required this.storageAPI,
  }) : super(false);

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    state = true;

    final links = _extractUrls(text);
    final hashtags = _extractHashtags(text);
    final userId = ref.watch(currentUserDetailsProvider).value!.uid;
    List<String> imageLinks = [];

    // check images are present
    if (images.isNotEmpty) {
      // upload images into storage
      imageLinks = await storageAPI.uploadImages(images);
    }

    final tweet = TweetModel(
      tweet: text,
      hashtags: hashtags,
      links: links,
      uid: userId,
      tweetedAt: DateTime.now().millisecondsSinceEpoch,
      likes: [],
      commentIds: [],
      id: '',
      reshareCount: 0,
      images: imageLinks,
    );

    final res = await tweetAPI.tweet(tweet);
    state = false;
    res.fold((f) => showSnackbar(context, f.message), (doc) {
      // do nothing
    });
  }

  // Extract urls from the given tweet
  List<String> _extractUrls(String input) {
    final urlPattern = RegExp(
      r'((https?:\/\/)?(www\.)?[a-zA-Z0-9\-]+\.[a-zA-Z]{2,}(\S*)?)',
      caseSensitive: false,
    );

    return urlPattern
        .allMatches(input)
        .map((match) => match.group(0)!)
        .toList();
  }

  // Extract hash tags from tweet
  List<String> _extractHashtags(String input) {
    final hashtagPattern = RegExp(r'\B#\w\w+');
    return hashtagPattern
        .allMatches(input)
        .map((match) => match.group(0)!)
        .toList();
  }

  Future<List<TweetModel>> getTweets() async {
    final tweets = await tweetAPI.fetchTweets();
    return tweets.map((tweet) => TweetModel.fromMap(tweet.data)).toList();
  }

  void likeTweet(TweetModel tweet, UserModel user) async {
    List<String> likes = tweet.likes;
    // If already liked by the user, then remove
    if (tweet.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }
    // update the tweet with updated liked
    tweet = tweet.copyWith(likes: likes);

    final res = await tweetAPI.likeTweet(tweet);
    res.fold((_) => null, (_) => null);
  }
}
