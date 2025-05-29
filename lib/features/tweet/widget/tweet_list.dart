import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getTweetsProvider)
        .when(
          data:
              (tweets) => ListView.builder(
                itemCount: tweets.length,
                itemBuilder:
                    (context, index) => TweetCard(tweet: tweets[index]),
              ),
          error: (error, st) => Text(error.toString()),
          loading: () => const Loading(),
        );
  }
}
