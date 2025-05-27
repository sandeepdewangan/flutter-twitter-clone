import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/user_model.dart';

// provider
final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

class UserAPI {
  final Databases db;
  UserAPI({required this.db});

  // Save User Data to DB

  Future<Either<Failure, void>> saveUserData(UserModel userModel) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );

      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occured at Appwrite',
          stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
