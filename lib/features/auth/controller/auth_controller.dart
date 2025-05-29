import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/home/views/home_view.dart';
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

// Future provider for current user account
// FutureBuilder, when() provides with three main properties, data, error and loading.
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getCurrentUser();
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  print(currentUserId);
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

// Future provider for getting user data
// We will pass the uid from the UI
final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authAPI;
  final UserAPI userAPI;
  AuthController({required this.authAPI, required this.userAPI}) : super(false);

  // --------- Get Current User ---------

  Future<User?> getCurrentUser() {
    return authAPI.currentUserAccount();
  }

  // --------- Register New User ---------

  void register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await authAPI.register(email: email, password: password);

    // handle failure and success
    res.fold((failure) => showSnackbar(context, failure.message), (user) async {
      // success
      UserModel userModel = UserModel(
        email: email,
        name: '',
        followers: const [],
        following: const [],
        profilePic: '',
        bannerPic: '',
        uid: user.$id,
        bio: '',
        isTwitterBlue: false,
      );
      final res = await userAPI.saveUserData(userModel);

      res.fold((f) => showSnackbar(context, f.message), (s) {
        showSnackbar(context, "Account created successfully");
        Navigator.push(context, LoginView.route());
      });
    });

    state = false;
  }

  // --------- Login ---------

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await authAPI.login(email: email, password: password);

    state = false;
    // handle failure and success
    res.fold(
      (failure) => showSnackbar(context, failure.message),
      (user) => Navigator.push(context, HomeView.route()),
    );
  }

  // --------- Get User Data ---------

  Future<UserModel> getUserData(String uid) async {
    final document = await userAPI.getUserData(uid);
    final userData = UserModel.fromMap(document.data);
    return userData;
  }
}
