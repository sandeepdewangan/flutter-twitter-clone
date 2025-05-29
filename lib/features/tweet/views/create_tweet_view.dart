import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetView());
  const CreateTweetView({super.key});

  @override
  ConsumerState<CreateTweetView> createState() => _CreateTweetViewState();
}

// TODO: Try these state management with Riverpod.

class _CreateTweetViewState extends ConsumerState<CreateTweetView> {
  final textTweetController = TextEditingController();
  List<File> images = [];

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  void onShareTweet() async {
    if (textTweetController.text.isEmpty) {
      return;
    }

    ref
        .watch(tweetControllerProvider.notifier)
        .shareTweet(
          images: images,
          text: textTweetController.text,
          context: context,
        );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    textTweetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        actions: [
          OutlinedButton(
            onPressed: onShareTweet,
            child: Text(
              "Tweet",
              style: TextStyle(
                fontSize: 18,
                color: Pallete.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body:
          isLoading || currentUser == null
              ? Loading()
              : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePic),
                        radius: 25,
                      ),
                      Expanded(
                        child: TextField(
                          controller: textTweetController,
                          decoration: InputDecoration(
                            hintText: "What's in your mind!",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Pallete.blueColor),
                            ),
                          ),
                          maxLines: 20,
                          minLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (images.isNotEmpty)
                    CarouselSlider(
                      items:
                          images.map((file) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Image.file(file),
                            );
                          }).toList(),
                      options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: false,
                      ),
                    ),
                ],
              ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10).copyWith(bottom: 20),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Pallete.greyColor, width: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            GestureDetector(
              onTap: onPickImages,
              child: SvgPicture.asset(AssetsConstants.galleryIcon),
            ),
            SvgPicture.asset(AssetsConstants.gifIcon),
            SvgPicture.asset(AssetsConstants.emojiIcon),
          ],
        ),
      ),
    );
  }
}
