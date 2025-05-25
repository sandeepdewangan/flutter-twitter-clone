import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/commons/small_rounded_button.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_form_field.dart';
import 'package:twitter_clone/theme/pallete.dart';

class RegisterView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const RegisterView());
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  // doesnot build everytime
  final appbar = UiConstants.twitterAppbar;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onRegister() {
    ref
        .read(authControllerProvider.notifier)
        .register(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appbar,
      body:
          isLoading
              ? Loading()
              : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AuthTextField(
                                controller: emailController,
                                hintText: "Enter email",
                              ),
                              const SizedBox(height: 20),
                              AuthTextField(
                                controller: passwordController,
                                hintText: "Enter password",
                              ),
                              const SizedBox(height: 20),
                              AuthTextField(
                                controller: confirmPasswordController,
                                hintText: "Confirm password",
                              ),
                              const SizedBox(height: 25),
                              Align(
                                alignment: Alignment.topRight,
                                child: SmallRoundedButton(
                                  label: "Done",
                                  textColor: Colors.black87,
                                  bgColor: Colors.white,
                                  onTap: onRegister,
                                ),
                              ),
                              const SizedBox(height: 25),
                              RichText(
                                text: TextSpan(
                                  text: 'Already have account? ',
                                  style: TextStyle(fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Pallete.blueColor,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                LoginView.route(),
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
