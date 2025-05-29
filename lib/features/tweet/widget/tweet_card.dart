import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/widget/image_carousel.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetCard extends ConsumerWidget {
  final TweetModel tweet;
  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(userDetailsProvider(tweet.uid))
        .when(
          data: (user) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                ' • ${formatDateTimeToTimeAgo(msEpoch: tweet.tweetedAt)}',
                                style: TextStyle(color: Pallete.greyColor),
                              ),
                            ],
                          ),
                          highlightLinksAndHashtags(tweet.tweet),
                          // Text(
                          //   tweet.tweet,
                          //   style: TextStyle(color: Colors.white, fontSize: 14),
                          // ),
                          if (tweet.images.isNotEmpty)
                            ImageCarousel(imageLinks: tweet.images),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Divider(color: Pallete.greyColor, thickness: 0.1),
              ],
            );
          },
          error: (error, st) => Text(error.toString()),
          loading: () => const Loading(),
        );
  }
}
