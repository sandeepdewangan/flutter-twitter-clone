import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/widget/image_carousel.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_actions_buttons.dart';
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
                          // Tweet display
                          highlightLinksAndHashtags(tweet.tweet),
                          // Display tweet images
                          if (tweet.images.isNotEmpty)
                            ImageCarousel(imageLinks: tweet.images),

                          // Tweets icon buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 20,
                            children: [
                              // Views
                              TweetActionsButtons(
                                onTab: () {},
                                value: 0,
                                assetName: AssetsConstants.viewsIcon,
                              ),
                              // Comments
                              TweetActionsButtons(
                                onTab: () {},
                                value: 0,
                                assetName: AssetsConstants.commentIcon,
                              ),
                              // Like
                              TweetActionsButtons(
                                onTab: () {},
                                value: 0,
                                assetName: AssetsConstants.likeOutlinedIcon,
                              ),
                              // Re-tweet
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  AssetsConstants.retweetIcon,
                                  colorFilter: ColorFilter.mode(
                                    Pallete.greyColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 5),
                Divider(color: Pallete.greyColor, thickness: 0.1),
              ],
            );
          },
          error: (error, st) => Text(error.toString()),
          loading: () => const Loading(),
        );
  }
}
