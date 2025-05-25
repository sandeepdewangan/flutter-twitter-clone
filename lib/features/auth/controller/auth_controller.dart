import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI authAPI;
  AuthController({required this.authAPI}) : super(false);

  void register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await authAPI.register(email: email, password: password);

    state = false;
    // handle failure and success
    res.fold(
      (failure) => showSnackbar(context, failure.message),
      (user) => print(user.email),
    );
  }
}
