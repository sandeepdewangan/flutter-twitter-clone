import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_card.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getTweetsProvider)
        .when(
          data: (tweets) {
            return ref
                .watch(getLatestTweetProvider)
                .when(
                  data: (data) {
                    // if a new document is created, then we need to insert to our list
                    if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.tweetsCollectionId}.documents.*.create',
                    )) {
                      tweets.insert(0, TweetModel.fromMap(data.payload));
                    }

                    return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder:
                          (context, index) => TweetCard(tweet: tweets[index]),
                    );
                  },
                  error: (error, st) => Text(error.toString()),
                  loading:
                      () => ListView.builder(
                        itemCount: tweets.length,
                        itemBuilder:
                            (context, index) => TweetCard(tweet: tweets[index]),
                      ),
                );
          },
          error: (error, st) => Text(error.toString()),
          loading: () => const Loading(),
        );
  }
}


// ListView.builder(
//                 itemCount: tweets.length,
//                 itemBuilder:
//                     (context, index) => TweetCard(tweet: tweets[index]),
//               ),