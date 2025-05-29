import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetActionsButtons extends StatelessWidget {
  final VoidCallback onTab;
  final int value;
  final String assetName;
  const TweetActionsButtons({
    super.key,
    required this.onTab,
    required this.assetName,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      
      onPressed: () {},
      icon: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(Pallete.greyColor, BlendMode.srcIn),
      ),
      label: Text(value.toString()),
      iconAlignment: IconAlignment.start,
      
    );
  }
}
