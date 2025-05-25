import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers.dart';

// Provide AuthAPI
// Read Only Provide
// Won't create new instance every time
final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

class AuthAPI {
  final Account account;
  AuthAPI({required this.account});

  // Register
  Future<Either<Failure, User>> register({
    required email,
    required password,
  }) async {
    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(user);
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

  // Login
  Future<Either<Failure, Session>> login({
    required email,
    required password,
  }) async {
    try {
      final session = await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return right(session);
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
