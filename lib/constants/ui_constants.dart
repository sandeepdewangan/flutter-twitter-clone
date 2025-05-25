import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UiConstants {
  static AppBar twitterAppbar = AppBar(
    title: SvgPicture.asset(
      AssetsConstants.twitterLogo,
      height: 30,
      colorFilter: ColorFilter.mode(Pallete.blueColor, BlendMode.srcIn),
    ),
    centerTitle: true,
  );
}
