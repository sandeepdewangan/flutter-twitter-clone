import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/providers.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorageProvider));
});

class StorageAPI {
  final Storage storage;
  const StorageAPI({required this.storage});

  Future<List<String>> uploadImages(List<File> files) async {
    List<String> imagesLinks = [];
    for (final file in files) {
      final uploadedImage = await storage.createFile(
        bucketId: AppwriteConstants.imagesBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      imagesLinks.add(AppwriteConstants.getImageUrl(uploadedImage.$id));
    }
    return imagesLinks;
  }
}
