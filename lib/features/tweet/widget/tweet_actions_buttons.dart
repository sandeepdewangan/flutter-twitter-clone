import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetActionsButtons extends StatelessWidget {
  final VoidCallback onTab;
  final int value;
  final String assetName;
  final bool isLiked;
  const TweetActionsButtons({
    super.key,
    required this.onTab,
    required this.assetName,
    required this.value,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        GestureDetector(
          onTap: onTab,
          child:
              isLiked
                  ? SvgPicture.asset(
                    height: 25,
                    AssetsConstants.likeFilledIcon,
                    colorFilter: ColorFilter.mode(
                      Pallete.redColor,
                      BlendMode.srcIn,
                    ),
                  )
                  : SvgPicture.asset(
                    assetName,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      Pallete.greyColor,
                      BlendMode.srcIn,
                    ),
                  ),
        ),
        Text(value.toString()),
      ],
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return TextButton.icon(

  //     onPressed: () {},
  //     icon: SvgPicture.asset(
  //       assetName,
  //       colorFilter: ColorFilter.mode(Pallete.greyColor, BlendMode.srcIn),
  //     ),
  //     label: Text(value.toString()),
  //     iconAlignment: IconAlignment.start,

  //   );
  // }
}
