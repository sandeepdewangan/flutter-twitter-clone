import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final imagePicker = ImagePicker();
  final imagesAsXFile = await imagePicker.pickMultiImage();
  if (imagesAsXFile.isNotEmpty) {
    for (final image in imagesAsXFile) {
      images.add(File(image.path));
    }
  }
  return images;
}

String formatDateTimeToTimeAgo({required int msEpoch}) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(msEpoch);
  return timeago.format(dateTime, locale: 'en_short'); // 15m
}

RichText highlightLinksAndHashtags(String text) {
  List<InlineSpan> spans = [];
  int start = 0;

  // Combine regex to find both URLs and hashtags
  final RegExp combinedRegex = RegExp(
    r'((https?:\/\/|www\.)[^\s]+|#[a-zA-Z0-9_]+)',
  );
  final matches = combinedRegex.allMatches(text);

  for (final match in matches) {
    if (match.start > start) {
      spans.add(TextSpan(text: text.substring(start, match.start)));
    }

    final String matchText = match.group(0)!;

    spans.add(
      TextSpan(
        text: matchText,
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
        // recognizer:
        // TapGestureRecognizer()
        //   ..onTap = () {
        //     print('Tapped: $matchText');
        //     // Optionally launch URL or handle hashtag tap
        //   },
      ),
    );

    start = match.end;
  }

  // Add any remaining text after the last match
  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start)));
  }

  return RichText(
    text: TextSpan(style: TextStyle(color: Colors.white), children: spans),
  );
}
