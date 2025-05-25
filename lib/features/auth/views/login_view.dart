import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/commons/small_rounded_button.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/views/register_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_form_field.dart';
import 'package:twitter_clone/theme/pallete.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  // doesnot build everytime
  final appbar = UiConstants.twitterAppbar;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
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
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.topRight,
                        child: SmallRoundedButton(
                          label: "Done",
                          textColor: Colors.black87,
                          bgColor: Colors.white,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 25),
                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have account? ',
                          style: TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                fontSize: 16,
                                color: Pallete.blueColor,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        RegisterView.route(),
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
