class AppwriteConstants {
  static const String databaseId = "683285d10034ffa877ef";
  static const String projectId = "6832839600241ba19c2c";
  static const String endPoint = "https://fra.cloud.appwrite.io/v1";
  static const String usersCollectionId = "683348a8003d6614bd03";
  static const String tweetsCollectionId = "68373f7a0009d5f581d0";
  static const String imagesBucketId = "6837bbd8002ca4850b8e";

  static String getImageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucketId/files/$imageId/view?project=$projectId&mode=admin';
}
