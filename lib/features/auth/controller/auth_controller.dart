import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/home/views/home_view.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

// Future provider for current user account
// FutureBuilder, when() provides with three main properties, data, error and loading.
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getCurrentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authAPI;
  AuthController({required this.authAPI}) : super(false);

  Future<User?> getCurrentUser() {
    return authAPI.currentUserAccount();
  }

  void register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await authAPI.register(email: email, password: password);

    state = false;
    // handle failure and success
    res.fold((failure) => showSnackbar(context, failure.message), (user) {
      showSnackbar(context, "Account is created successfully");
      Navigator.push(context, LoginView.route());
    });
  }

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
}
